from django.contrib import messages
from django.core.urlresolvers import reverse
from django.db.models import Q
from django.http import HttpResponseRedirect
from django.shortcuts import redirect, render

from hotline.perms import permissions
from hotline.reports.models import Invite, Report

from .forms import UserNotificationQueryForm, UserSubscriptionDeleteForm
from .models import UserNotificationQuery


@permissions.is_active
def create(request):
    query = request.GET.urlencode()
    instance = UserNotificationQuery(user=request.user, query=query)
    if request.method == "POST":
        form = UserNotificationQueryForm(request.POST, instance=instance)
        if form.is_valid():
            form.save()
            messages.success(request, "Saved")
            return HttpResponseRedirect(reverse("reports-list") + "?" + request.GET.urlencode())
    else:
        form = UserNotificationQueryForm(instance=instance)

    return render(request, "notifications/create.html", {
        "form": form,
    })


@permissions.is_active
def list_(request):
    # all that awesome tabs stuff
    user = request.user

    invited_to = [invite.report for invite in Invite.objects.filter(user_id=user.pk).select_related("report")]
    reported = Report.objects.filter(Q(pk__in=request.session.get("report_ids", [])) | Q(created_by_id=user.pk))
    reported_querystring = "created_by_id:(%s)" % (" ".join(map(str, set(reported.values_list("created_by_id", flat=True)))))
    open_and_claimed = Report.objects.filter(claimed_by_id=user.pk, is_public=False, is_archived=False).exclude(claimed_by=None)
    subscribed = UserNotificationQuery.objects.filter(user_id=user.pk) 

    unclaimed_reports = []
    if user.is_authenticated() and user.is_active:
        unclaimed_reports = Report.objects.filter(claimed_by=None, is_public=False, is_archived=False)

    if request.method == "POST":
        form = UserSubscriptionDeleteForm(request.POST, user=request.user)
        if form.is_valid():
            form.save()
            messages.success(request, "Saved")
            return redirect("notifications-list")
    else:
        form = UserSubscriptionDeleteForm(user=request.user)

    return render(request, "notifications/list.html", {
        "form": form,
        "invited_to": invited_to,
        "reported": reported,
        "subscribed": subscribed,
        "open_and_claimed": open_and_claimed,
        "unclaimed_reports": unclaimed_reports,
        "reported_querystring": reported_querystring
    })
