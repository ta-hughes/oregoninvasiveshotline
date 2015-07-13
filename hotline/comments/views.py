from django.contrib import messages
from django.contrib.auth.decorators import login_required
from django.shortcuts import get_object_or_404, redirect, render
from django.utils.functional import curry

from hotline.images.forms import get_image_formset
from hotline.images.models import Image
from hotline.reports.perms import can_masquerade_as_user_for_report

from .forms import CommentForm
from .models import Comment
from .perms import permissions


def edit(request, comment_id):
    comment = get_object_or_404(Comment, pk=comment_id)

    # this will redirect to login page if the user doesn't have permission to
    # be here
    if not can_masquerade_as_user_for_report(request, comment.report):
        return login_required(lambda request: None)(request)

    # if they aren't allowed to edit this comment, send them away
    permissions.can_edit_comment(lambda *args, **kwargs: None)(request, comment_id)

    PartialCommentForm = curry(CommentForm, user=request.user, report=comment.report, instance=comment)
    # this is dumb, but the only way to pass an extra arg to the subform
    ImageFormSet = get_image_formset(user=request.user)

    if request.POST:
        form = PartialCommentForm(request.POST)
        formset = ImageFormSet(request.POST, request.FILES, queryset=Image.objects.filter(comment=comment))
        if form.is_valid() and formset.is_valid():
            form.save()
            formset.save(user=comment.created_by, fk=comment)
            messages.success(request, "Comment Edited")
            return redirect("reports-detail", comment.report.pk)
    else:
        form = PartialCommentForm()
        formset = ImageFormSet(queryset=Image.objects.filter(comment=comment))

    return render(request, "comments/edit.html", {
        "comment": comment,
        "form": form,
        "formset": formset,
    })
