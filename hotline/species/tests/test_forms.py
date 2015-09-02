import elasticmodels
from django.test import TestCase
from model_mommy.mommy import make

from hotline.users.models import User

from ..forms import SpeciesSearchForm
from ..models import Species


class SpeciesFormsTest(TestCase, elasticmodels.ESTestCase):
    """
    Some unit tests to ensure forms in the species app work as they should.

    """
    def setUp(self):
        super(SpeciesFormsTest, self).setUp()
        make(Species, name="stuff")
        self.user = User(first_name="foo", last_name="bar", email="foobar@example.com", is_staff=True)
        self.user.set_password("foobar")
        self.user.save()
        self.client.login(username="foobar@example.com", password="foobar")

    def test_get_initial_queryset(self):
        form = SpeciesSearchForm(user=self.user, data={})
        queryset = form.get_queryset()
        self.assertEqual(len(queryset), Species.objects.count())

    def test_valid_form(self):
        form = SpeciesSearchForm({'querystring': 'other'}, user=self.user)
        self.assertTrue(form.is_valid())

    def test_form_with_empty_querystring_returns_everything(self):
        form = SpeciesSearchForm({'querystring': ''}, user=self.user)
        self.assertTrue(form.is_valid())
        results = list(form.search().execute())
        self.assertEqual(len(results), Species.objects.count())

    def test_search_returns_correct_object(self):
        # test object
        name = "other"
        make(Species, name=name)
        # set it all up
        form = SpeciesSearchForm({'querystring': 'other'}, user=self.user)
        # make sure the form is valid
        self.assertTrue(form.is_valid())
        results = form.search().execute()[0]
        # Check to see that the id of the test object "other"
        # is in the list of ids returned by the search function
        self.assertEqual(results['name'], name)
