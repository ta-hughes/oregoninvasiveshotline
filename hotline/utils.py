import subprocess

from django.conf import settings
from django.contrib.auth import get_user_model
from django.contrib.auth.forms import PasswordResetForm
from django.contrib.sites.models import Site
from django.db.models import Q


# The sites framework is dumb. I don't want to hardcode the hostname of the
# site in the database. To avoid doing that, we monkey patch
# Site.objects.get_current so it uses our custom function that always returns a
# Site object with the proper domain
def get_current(request=None, _get_current=Site.objects.get_current):
    if request is not None:
        # fake a Site object, since we are too lazy to keep the database updated
        return Site(domain=request.get_host(), name=request.get_host(), pk=getattr(settings, "SITE_ID", 1))
    else:
        return _get_current(request)

Site.objects.get_current = get_current


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


# Monkey patch the PasswordResetForm so it doesn't just silently ignore people
# with unusable password. Anyone with an is_active account should be able to
# reset their password
def get_users(self, email):
    return get_user_model()._default_manager.filter(email__iexact=email, is_active=True)

PasswordResetForm.get_users = get_users
