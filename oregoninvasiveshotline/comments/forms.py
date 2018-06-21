from django.db import transaction
from django import forms

from oregoninvasiveshotline.reports.perms import can_adjust_visibility

from .tasks import notify_users_for_comment
from .models import Comment


class CommentForm(forms.ModelForm):

    SUBMIT_FLAG = 'COMMENT'

    class Meta:
        model = Comment
        fields = (
            'body',
            'visibility',
        )

    def __init__(self, *args, user, report, **kwargs):
        super().__init__(*args, **kwargs)

        self.fields['body'].label = ''
        self.fields['body'].widget.attrs.update({
            'placeholder': 'Comment body...',
            'rows': 3,
        })

        if self.instance.pk is None:
            self.instance.report = report
            self.instance.created_by = user

        if not can_adjust_visibility(user, report):
            self.fields.pop('visibility')
            self.instance.visibility = Comment.PROTECTED

    def save(self, commit=True):
        is_new = self.instance.pk is None  # Must be before save
        instance = super().save(commit=commit)
        if is_new:
            transaction.on_commit(lambda: notify_users_for_comment.delay(instance.pk))
        return instance
