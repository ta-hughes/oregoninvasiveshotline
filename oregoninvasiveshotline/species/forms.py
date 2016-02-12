from django import forms
from haystack.forms import SearchForm

from .models import Species


class SpeciesSearchForm(SearchForm):

    q = forms.CharField(required=False, widget=forms.widgets.TextInput(attrs={
        'placeholder': 'Enter a keyword, then click \'Search\''
    }), label='Search')

    order_by = forms.ChoiceField(choices=[
        ('name', 'Name'),
        ('scientific_name', 'Scientific Name'),
        ('severity', 'Severity'),
        ('category', 'Category'),
        ('is_confidential', 'Confidential'),
    ], required=False)

    order = forms.ChoiceField(choices=[
        ('ascending', 'Ascending'),
        ('descending', 'Descending'),
    ], required=False, initial='ascending', widget=forms.widgets.RadioSelect)

    def no_query_found(self):
        return self.searchqueryset.all().models(Species)

    def search(self):
        results = super().search().models(Species)

        if not self.is_valid():
            return self.no_query_found()

        order_by = self.cleaned_data.get('order_by')
        order = self.cleaned_data.get('order')
        if order_by:
            if order == 'descending':
                order_by = '-{order_by}'.format_map(locals())
            results = results.order_by(order_by)

        return results
