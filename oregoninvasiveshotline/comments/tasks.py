from django.template.loader import render_to_string
from django.core.mail import send_mass_mail

from oregoninvasiveshotline.utils.settings import get_setting
from oregoninvasiveshotline.utils.urls import build_absolute_url
from oregoninvasiveshotline.reports.models import Invite
from oregoninvasiveshotline.comments.models import Comment
from oregoninvasiveshotline.celery import app


@app.task
def notify_users_for_comment(comment_id):
    """
    Send an email notification about the comment to the relevant users.
    """
    comment = Comment.objects.get(pk=comment_id)
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
    subject = get_setting('NOTIFICATIONS.notify_new_comment__subject')
    from_email = get_setting('NOTIFICATIONS.from_email')

    for user in recipients:
        next_url = comment.get_absolute_url()

        if user.is_active:
            url = build_absolute_url(next_url)
        else:
            url = user.get_authentication_url(next=next_url)

        body = render_to_string('reports/_new_comment.txt', {
            'user': comment.created_by,
            'body': comment.body,
            'url': url,
        })
        emails.append((subject, body, from_email, (user.email,)))

    send_mass_mail(emails)
