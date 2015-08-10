from arcutils import will_be_deleted_with
from django.shortcuts import render, get_object_or_404, redirect
from django.core.exceptions import ObjectDoesNotExist
from django.contrib import messages
from django.contrib.sites.models import Site
from django.contrib.flatpages.models import FlatPage

from hotline.flatpages.forms import FlatterPageForm

from .perms import permissions


def _list(request):
    """

    """
    pages = FlatPage.objects.all()

    return render(request, "flatpages/list.html", {
        'pages': pages,
    })


@permissions.can_modify_page
def create(request):
    return _edit(request, page_url=None)


@permissions.can_modify_page
def edit(request, page_url):
    print(page_url)
    return _edit(request, page_url)


def _edit(request, page_url):

    site = Site.objects.first()
    if page_url is None:
        page = None
        url = None
    else:
        url = page_url
        try:
            page = FlatPage.objects.get(url=url)
        except ObjectDoesNotExist:
            url = "/" + str(url)
            page = get_object_or_404(FlatPage, url=url)

    if request.method == "POST":
        form = FlatterPageForm(request.POST, instance=page)
        form.fields['sites'].initial = [site]
        if form.is_valid():
            form.save()
            return redirect('pages-list')

    else:
        form = FlatterPageForm(instance=page)
        form.fields['sites'].initial = [site]

    return render(request, "flatpages/edit.html", {
        'form': form,
        'page_url': url,
    })


@permissions.can_modify_page
def delete(request, page_url):
    page = get_object_or_404(FlatPage, url=page_url)
    if request.method == "POST":
        page.delete()
        messages.success(request, "Page deleted!")
        return redirect('pages-list')

    related_objects = list(will_be_deleted_with(page))

    return render(request, "delete.html", {
        "object": page,
        "related_objects": related_objects,
    })
