from django.test import TestCase
from django.test.client import RequestFactory
from model_mommy.mommy import make

from hotline.users.models import User

from ..forms import SpeciesSearchForm
from ..models import Species


class SpeciesFormsTest(TestCase):
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

    def test_get_queryset(self):
        """
        test to ensure initial queryset is the entire set of species model objects.
        """
        form = SpeciesSearchForm(user=self.user, data={})
        queryset = form.get_queryset()
        self.assertEqual(len(queryset), Species.objects.count())

    def test_valid_form(self):
        data = {
            "querystring": "other",
        }
        form = SpeciesSearchForm(user=self.user, data=data)
        self.assertTrue(form.is_valid())

    def test_search(self):
        # test object
        other = make(Species, name="other")
        # set it all up
        request = RequestFactory().get("/", {'querystring': 'other'})
        form = SpeciesSearchForm(request.GET, user=self.user)
        # make sure the form is valid
        self.assertTrue(form.is_valid())
        results = form.search()
        values = results.to_dict()
        ids_list = values['query']['filtered']['filter']['ids']['values']
        # Check to see that the id of the test object "other"
        # is in the list of ids returned by the search function
        self.assertIn(other.pk, ids_list)
