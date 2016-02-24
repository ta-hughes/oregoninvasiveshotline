from django import forms
from django.conf import settings
from django.core.mail import send_mass_mail
from django.template.loader import render_to_string

from ..reports.models import Invite
from ..reports.perms import can_adjust_visibility

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

    def save(self, *args, request, **kwargs):
        is_new = self.instance.pk is None  # Must be before save
        instance = super().save(*args, **kwargs)
        if is_new:
            self.notify_users(request)
        return instance

    def notify_users(self, request):
        # Send an email notification about the comment to the relevant
        # users.
        comment = self.instance
        report = comment.report
        recipients = set()

        # Notify staff & managers who commented on the report
        q = Comment.objects.filter(report=report, created_by__is_active=True)
        q = q.prefetch_related('created_by')
        recipients.update(c.created_by for c in q)

        # Notify the user who claimed the report
        if report.claimed_by:
            recipients.add(report.claimed_by)

        # Notify invited experts
        q = Invite.objects.filter(report=report).prefetch_related('user')
        q = q.prefetch_related('user')
        recipients.update(invite.user for invite in q)

        # Notify the user that submitted the report
        if comment.visibility in (Comment.PROTECTED, Comment.PUBLIC):
            recipients.add(report.created_by)

        # Don't notify the user who made the comment
        recipients.discard(comment.created_by)

        emails = []
        subject = '{0.PROJECT[title]} - New Comment on Report'.format(settings)

        for user in recipients:
            if user.is_active:
                url = request.build_absolute_uri(comment.get_absolute_url())
            else:
                url = user.get_authentication_url(request, next=comment.get_absolute_url())
            body = render_to_string('reports/_new_comment.txt', {
                'user': comment.created_by,
                'body': comment.body,
                'url': url,
            })
            emails.append((subject, body, 'noreply@pdx.edu', (user.email,)))

        send_mass_mail(emails)
