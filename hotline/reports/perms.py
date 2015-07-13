from ..perms import permissions
from .models import Invite, Report


@permissions.register(model=Report)
def can_view_private_report(user, report):
    if getattr(user, 'is_elevated', False):
        return True

    if Invite.objects.filter(report=report, user_id=user.pk).exists():
        return True

    if report.created_by == user:
        return True


@permissions.register(model=Report)
def can_edit_report(user, report):
    return report.claimed_by == user


@permissions.register(model=Report)
def can_adjust_visibility(user, report):
    return user.is_elevated or Invite.objects.filter(user=user, report=report).exists()


def can_masquerade_as_user_for_report(request, report):
    if request.user.is_anonymous() and report.pk in request.session.get("report_ids", []):
        if report.created_by.is_active:
            # make them login before they can view this page, since they are
            # allowed to login. This prevents an anonymous user from being able
            # to masquerade as an active user
            return False
        else:
            # for the life of this request, the user can masquerade as the
            # person who submitted the report. This is kind of dangerous
            # because by submitted a report using a spoofed email address, you
            # can become that user (but only for the life of this request)
            request.user = report.created_by

    return True
