from django.contrib.auth.models import AnonymousUser
from django.test import TestCase
from model_mommy.mommy import make

from .notifications.models import UserNotificationQuery
from .reports.models import Invite, Report
from .users.models import User
from .utils import get_tab_counts


class GetTabCountsTest(TestCase):
    def test_subscribed(self):
        user = make(User)
        make(UserNotificationQuery, user=user)
        make(UserNotificationQuery)
        context = get_tab_counts(user, [])
        self.assertEqual(context['subscribed'], 1)

    def test_invited_to(self):
        user = make(User)
        make(Invite, user=user)
        make(Invite)
        context = get_tab_counts(user, [])
        self.assertEqual(context['invited_to'], 1)

    def test_reported(self):
        user = make(User)
        make(Report, created_by=user)
        make(Report)
        report_id = make(Report).pk
        context = get_tab_counts(user, [report_id])
        self.assertEqual(context['reported'], 2)

    def test_open_and_claimed(self):
        make(Report)
        user = AnonymousUser()
        context = get_tab_counts(user, [])
        self.assertEqual(context['open_and_claimed'], 0)

        user = make(User)
        make(Report, claimed_by=user)
        context = get_tab_counts(user, [])
        self.assertEqual(context['open_and_claimed'], 1)

    def test_unclaimed_reports(self):
        make(Report, claimed_by=make(User))
        make(Report)
        user = AnonymousUser()
        context = get_tab_counts(user, [])
        self.assertEqual(context['unclaimed_reports'], 0)

        user = make(User, is_active=False)
        context = get_tab_counts(user, [])
        self.assertEqual(context['unclaimed_reports'], 0)

        user = make(User, is_active=True)
        context = get_tab_counts(user, [])
        self.assertEqual(context['unclaimed_reports'], 1)
