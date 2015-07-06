from django.test import TestCase
from model_mommy.mommy import make

from .models import Region


class RegionTest(TestCase):
    def test_str(self):
        self.assertEqual(str(make(Region, name="foo")), "foo")
