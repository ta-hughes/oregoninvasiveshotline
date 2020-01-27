from django.db.models import Q

from oregoninvasiveshotline.notifications.models import UserNotificationQuery
from oregoninvasiveshotline.reports.models import Report, Invite


def get_tab_counts(user, report_ids):
    return {
        "subscribed": UserNotificationQuery.objects.filter(user_id=user.pk).count(),
        "invited_to": Invite.objects.filter(user_id=user.pk).count(),
        "reported": Report.objects.filter(Q(pk__in=report_ids) | Q(created_by_id=user.pk)).count(),
        "open_and_claimed": 0 if user.is_anonymous else
        Report.objects.filter(claimed_by_id=user.pk, is_public=False, is_archived=False).count(),
        "claimed_by_me": 0 if user.is_anonymous else
        Report.objects.filter(claimed_by_id=user.pk).count(),
        "unclaimed_reports": Report.objects.filter(
            claimed_by=None,
            is_public=False,
            is_archived=False
        ).count() if user.is_authenticated and user.is_active else 0,
    }
