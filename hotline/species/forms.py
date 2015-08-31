from django import forms
from django.db.models import Q
from django.utils.safestring import mark_safe
from elasticmodels.forms import SearchForm

from hotline.perms import permissions
from hotline.users.models import User

from .indexes import SpeciesIndex
from .models import Species, Severity, Category


class SpeciesSearchForm(SearchForm):
    """
    This form handles searching for a species in the species list view.
    """
    q = None

    querystring = forms.CharField(required=False, widget=forms.widgets.TextInput(attrs={
        "placeholder": "name:Foobarius"
    }), label=mark_safe("Search <a target='_blank' class='help' href='help'>[?]</a>"))

    sort_by = forms.ChoiceField(choices=[
        ("name", "Name (Desc)"),
        ("-name", "Name (Asc)"),
        ("scientific_name", "Scientific Name (Desc)"),
        ("-scientific_name", "Scientific Name (Asc)"),
        ("remedy", "Remedy (Desc)"),
        ("-remedy", "Remedy (Asc)"),
        ("resources", "Resources (Desc)"),
        ("-resources", "Resources (Asc)"),
        ("severity.name", "Severity (Desc)"),
        ("-severity.name", "Severity (Asc)"),
        ("category.name", "Category (Desc)"),
        ("-category.name", "Category (Asc)"),

    ], required=False)

    def __init__(self, *args, user, species_ids=(), **kwargs):
        self.user = user
        self.species_ids = species_ids
        super().__init__(*args, index=SpeciesIndex, **kwargs)

    def get_queryset(self):
        queryset = super().get_queryset().prefetch_related().select_related(
        )

        return queryset

    def search(self):
        results = super().search()
        if self.cleaned_data.get("querystring"):
            query = results.query(
                "query_string",
                query=self.cleaned_data.get("querystring", ""),
                lenient=True,
            )
            if not self.is_valid_query(query):
                results = results.query(
                    "simple_query_string",
                    query=self.cleaned_data.get("querystring", ""),
                    lenient=True,
                )
            else:
                results = query

        sort_by = self.cleaned_data.get("sort_by")
        if sort_by:
            results = results.sort(sort_by)

        return results
