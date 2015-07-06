from django.test import TestCase
from model_mommy.mommy import make

from .models import Category, Severity, Species


class CategoryTest(TestCase):
    def test_str(self):
        self.assertEqual(str(make(Category, name="foo")), "foo")


class SeverityTest(TestCase):
    def test_str(self):
        self.assertEqual(str(make(Severity, name="foo")), "foo")


class SpeciesTest(TestCase):
    def test_str(self):
        self.assertEqual(str(make(Species, name="foo", scientific_name="bar")), "foo (bar)")
