from django import forms
from django.utils.safestring import mark_safe
from elasticmodels.forms import SearchForm

from .indexes import SpeciesIndex


class SpeciesSearchForm(SearchForm):
    """
    This form handles searching for a species in the species list view.
    """
    q = None

    querystring = forms.CharField(required=False, widget=forms.widgets.TextInput(attrs={
        "placeholder": "name:Foobarius"
    }), label=mark_safe("Search <a target='_blank' class='help' href='help'>[?]</a>"))

    sort_by = forms.ChoiceField(choices=[
        ("name", "Name"),
        ("scientific_name", "Scientific Name"),
        ("severity", "Severity"),
        ("category", "Category"),
        ("is_confidential", "Confidential"),
    ], required=False)

    order = forms.ChoiceField(choices=[
        ("ascending", "Ascending"),
        ("descending", "Descending"),
    ], required=False, initial="ascending", widget=forms.widgets.RadioSelect)

    def __init__(self, *args, user, **kwargs):
        self.user = user
        super().__init__(*args, index=SpeciesIndex, **kwargs)

    def get_queryset(self):
        queryset = super().get_queryset().select_related(
            'category',
            'severity'
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
        order = self.cleaned_data.get("order")
        if sort_by:
            if order == "descending":
                sort_by = "-" + sort_by
            results = results.sort(sort_by)

        return results
