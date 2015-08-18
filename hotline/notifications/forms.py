from django import forms

from .models import UserNotificationQuery


class UserNotificationQueryForm(forms.ModelForm):
    class Meta:
        model = UserNotificationQuery
        fields = ['name']


class UserSubscriptionDeleteForm(forms.Form):
    subscriptions = forms.ModelMultipleChoiceField(required=True, widget=forms.CheckboxSelectMultiple, queryset=None)

    def __init__(self, *args, user, **kwargs):
        self.user = user
        super().__init__(*args, **kwargs)
        initial = UserNotificationQuery.objects.filter(user=self.user)
        self.fields['subscriptions'].queryset = initial

    def save(self, *args, **kwargs):
        for field in self.cleaned_data['subscriptions']:
            field.delete()
