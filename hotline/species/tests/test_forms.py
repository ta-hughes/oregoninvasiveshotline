from django.test import TestCase
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
        data = {
            "querystring": "stuff",
        }
        species_ids = Species.objects.all().values_list("pk")
        form = SpeciesSearchForm(user=self.user, data=data, species_ids=species_ids)
        self.assertTrue(form.is_valid())
