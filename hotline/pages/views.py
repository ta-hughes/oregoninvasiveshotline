from arcutils import will_be_deleted_with
from django.shortcuts import render, get_object_or_404, redirect
from django.contrib import messages
from django.contrib.flatpages.models import FlatPage

from hotline.pages.forms import FlatterPageForm

from .perms import permissions


def list_(request):
    """

    """
    pages = FlatPage.objects.all()

    return render(request, "pages/list.html", {
        'pages': pages,
    })


@permissions.can_modify_page
def create(request):
    return _edit(request, page_id=None)


@permissions.can_modify_page
def edit(request, page_id):
    return _edit(request, page_id)


def _edit(request, page_id):
    if page_id is None:
        page = None
    else:
        page = get_object_or_404(FlatPage, pk=page_id)

    if request.method == "POST":
        form = FlatterPageForm(request.POST, instance=page)
        if form.is_valid():
            form.save()
            return redirect('pages-list')

    else:
        form = FlatterPageForm(instance=page)

    return render(request, "pages/edit.html", {
        'form': form,
        'page_id': page_id,
    })


@permissions.can_modify_page
def delete(request, page_id):
    page = get_object_or_404(FlatPage, pk=page_id)
    if request.method == "POST":
        page.delete()
        messages.success(request, "Page deleted!")
        return redirect('pages-list')

    related_objects = list(will_be_deleted_with(page))

    return render(request, "delete.html", {
        "object": page,
        "related_objects": related_objects,
    })
