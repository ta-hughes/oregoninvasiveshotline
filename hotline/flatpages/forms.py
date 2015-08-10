from django import forms
from django.contrib.flatpages.forms import FlatpageForm
from django.utils.translation import ugettext

reserved = ['edit', 'create', 'list', 'delete']


class FlatterPageForm(FlatpageForm):

    def clean_url(self):
        super().clean_url()
        url = self.cleaned_data['url']
        if not url.startswith("/pages"):
            url = "/pages" + url
        for page in reserved:
            if url.endswith(page + "/"):
                raise forms.ValidationError(
                    ugettext("Sorry, that URL is reserved. Please use a different URL."),
                    code='duplicate_url',
                )
        return url
