import subprocess

from django.db.models import Q


def resize_image(input_path, output_path, width, height):
    size = "%dx%d" % (width, height)
    return subprocess.call([
        "convert",
        input_path,
        "-thumbnail",
        # the > below means don't enlarge images that fit in the box
        size + ">",
        "-background",
        "transparent",
        "-gravity",
        "center",
        # fill the box with the background color (which
        # is transparent)
        "-extent",
        size,
        output_path
    ])


def get_tab_counts(user, report_ids):
    from .reports.models import Report, Invite
    from .notifications.models import UserNotificationQuery
    return {
        "subscribed": UserNotificationQuery.objects.filter(user_id=user.pk).count(),
        "invited_to": Invite.objects.filter(user_id=user.pk).count(),
        "reported": Report.objects.filter(Q(pk__in=report_ids) | Q(created_by_id=user.pk)).count(),
        "open_and_claimed": 0 if user.is_anonymous() else Report.objects.filter(claimed_by_id=user.pk, is_public=False, is_archived=False).count(),
        "unclaimed_reports": Report.objects.filter(
            claimed_by=None,
            is_public=False,
            is_archived=False
        ).count() if user.is_authenticated() and user.is_active else 0,
    }
