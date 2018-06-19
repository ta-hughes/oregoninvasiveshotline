import random

from django.conf import settings
from django.contrib import messages
from django.contrib.auth import login as django_login
from django.contrib.auth.views import login as django_login_view
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
from django.core.signing import BadSignature
from django.shortcuts import get_object_or_404, redirect, render
from django.views.generic import DetailView

from arcutils.db import will_be_deleted_with

from oregoninvasiveshotline.reports.models import Invite, Report

from .utils import get_tab_counts
from .colors import AVATAR_COLORS
from .perms import can_list_users, permissions
from .forms import PublicLoginForm, UserForm, UserSearchForm
from .models import User


def login(request, *args, **kwargs):
    """
    This delegates most of the work to `django.contrib.auth.views.login`, but
    we need to display an extra form, that allows users to login with just an
    email address. To do that without rewriting all the django login code, we
    tap into the TemplateResponse.context_data and add the extra form
    """
    response = django_login_view(request, *args, **kwargs)
    # if our special "OTHER_LOGIN" flag is present, we process our login form
    if request.method == "POST" and request.POST.get("form") == "OTHER_LOGIN":
        # make it look like the django login form wasn't filled out
        response.context_data['form'] = response.context_data['form'].__class__(request)
        # now do the regular form processing stuff...
        other_form = PublicLoginForm(request.POST)
        if other_form.is_valid():
            other_form.save(request=request)
            messages.success(request, "Check your email! You have been sent the login link.")
            return redirect(request.get_full_path())
    else:
        other_form = PublicLoginForm()

    # patch in the other_form variable, so the template can render it.
    # Sometimes the django_login_view returns an HttpResponseRedirect, which
    # doesn't have context_data, hence the check
    if hasattr(response, "context_data"):
        response.context_data['other_form'] = other_form

    return response


def authenticate(request):
    params = request.GET
    signature = params.get('sig', '')

    try:
        user = User.from_signature(signature)
    except BadSignature:
        messages.error(request, 'Unable to login with that URL')
        return redirect('home')

    if user is None:
        # Signature expired
        messages.error(request, 'That login URL has expired')
        return redirect('login')

    if user.is_active or Invite.objects.filter(user=user).exists():
        django_login(request, user)

    # Add user's reports to their session
    report_ids = Report.objects.filter(created_by=user).values_list('pk', flat=True)
    request.session['report_ids'] = list(report_ids)

    next_url = params.get('next') or settings.LOGIN_REDIRECT_URL
    return redirect(next_url)


def avatar(request, user_id, colors=AVATAR_COLORS):
    """
    Generates an SVG to use as the user's default avatar, using some random
    colors based on the user's PK
    """
    user = get_object_or_404(User, pk=user_id)
    background_color, text_color = random.Random(user.pk).sample(colors, 2)

    return render(request, "users/avatar.svg", {
        "user": user,
        "background_color": background_color,
        "text_color": text_color,
    }, content_type="image/svg+xml")


def home(request):
    """
    Just redirect to the detail view for the user. This page exists solely
    because settings.LOGIN_REDIRECT_URL needs to redirect to a "simple" URL
    (i.e. we can't use variables in the URL)
    """
    user = request.user
    if user.is_anonymous() and not request.session.get('report_ids'):
        messages.error(request, "You are not allowed to be here")
        return redirect("home")

    tab_context = get_tab_counts(request.user, request.session.get("report_ids", []))

    return render(request, "users/home.html", dict({
        "user": user,
    }, **tab_context))


class Detail(DetailView):

    def get_queryset(self):
        queryset = User.objects.all()
        if not self.request.user.is_staff:
            queryset = queryset.filter(is_active=True)

        return queryset

    def get_context_data(self, **kwargs):
        super(DetailView, self).get_object()
        context = super(Detail, self).get_context_data(**kwargs)
        context['current_user'] = self.request.user

        return context


@permissions.can_list_users
def list_(request):
    """List all users in the system *or* search for users.

    If the user is *not* doing a search, all the users are loaded and
    ordered by the default User ordering.

    If the user is doing a search (indicated by the presence of certain
    query parameters), then we do a search and order the results by
    relevance (we just let Haystack/ES do its default ordering).

    """
    params = request.GET
    form = UserSearchForm(params)

    # Search parameters
    q = params.get('q')
    is_manager = params.get('is_manager')

    # XXX: Temporary (remove line)
    only_dupes = params.get('$dupes') == '1'

    if q:
        users = form.search()
    else:
        users = User.objects.all()
        if is_manager:
            users = users.filter(is_active=True)

        # XXX: Temporary (remove entire block)
        if only_dupes:
            users = User.objects.raw(
                'SELECT * from "user" u1 '
                'WHERE ('
                '    SELECT count(*) FROM "user" u2 WHERE lower(u2.email) = lower(u1.email )'
                ') > 1 '
                'ORDER BY lower(email)'
            )

    active_page = params.get('page')
    paginator = Paginator(users, settings.ITEMS_PER_PAGE)

    if not only_dupes:  # XXX: Temporary (remove this line & dedent block)
        try:
            users = paginator.page(active_page)
        except PageNotAnInteger:
            users = paginator.page(1)
        except EmptyPage:
            users = paginator.page(paginator.num_pages)

    return render(request, 'users/list.html', {
        'users': users,
        'form': form,
    })


@permissions.can_delete_user
def delete(request, user_id):
    user = get_object_or_404(User, pk=user_id)
    if request.method == "POST":
        user.delete()
        messages.success(request, "User deleted!")
        return redirect("users-list")

    related_objects = list(will_be_deleted_with(user))

    return render(request, "delete.html", {
        # we don't call this template variable "user" because that collides
        # with the "user" variable which references the currently logged in
        # user
        "object": user,
        "will_be_deleted_with": related_objects,
    })


@permissions.can_create_user
def create(request):
    """
    Create a new user
    """
    return _edit(request)


@permissions.can_edit_user
def edit(request, user_id):
    """
    Edit an existing user.
    """
    user = get_object_or_404(User, pk=user_id)
    return _edit(request, user)


def _edit(request, user=None):
    """
    Handle creating or editing a user
    """
    if request.POST:
        form = UserForm(request.POST, request.FILES, user=request.user, instance=user)

        if form.is_valid():
            is_new = user is None or user.pk is None
            user = form.save()
            if is_new:
                messages.success(request, "Created!")
            else:
                messages.success(request, "Edited!")

            if can_list_users(request.user):
                return redirect("users-list")
            return redirect("users-home")
    else:
        form = UserForm(user=request.user, instance=user)

    return render(request, 'users/edit.html', {
        "form": form,
    })
