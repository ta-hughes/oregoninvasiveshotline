from django import forms
from django.core.mail import send_mail
from django.core.urlresolvers import reverse
from django.template.loader import render_to_string
from haystack.forms import SearchForm

from oregoninvasiveshotline.utils import generate_thumbnail

from .models import User


class UserSearchForm(SearchForm):

    is_manager = forms.BooleanField(initial=True, required=False)

    def no_query_found(self):
        return self.searchqueryset.all().models(User)

    def search(self):
        results = super().search().models(User)

        # Show all users when search isn't valid
        if not self.is_valid():
            return self.no_query_found()

        if self.cleaned_data.get('is_manager'):
            results = results.filter(is_active=True)

        return results


class PublicLoginForm(forms.Form):

    """Allows users to log in via a link sent via email."""

    email = forms.EmailField()

    def clean_email(self):
        email = self.cleaned_data['email']

        try:
            user = User.objects.get(email__iexact=email)
        except User.DoesNotExist:
            raise forms.ValidationError('Could not find an account with that email address')

        if user.is_active:
            raise forms.ValidationError('You must log in with your username and password')

        return email

    def save(self, request):
        email = self.cleaned_data['email']

        # XXX: This can fail because there are several duplicate
        #      accounts that have the same email address with a
        #      different case. This SQL query will reveal the dupes:
        #
        #      SELECT user_id, email, first_name, last_name, is_active, is_staff
        #      FROM "user" u1
        #      WHERE (SELECT count(*) FROM "user" u2 WHERE lower(u2.email) = lower(u1.email )) > 1
        #      ORDER BY lower(email);
        #
        #      Cleaning up the dupes is going to be... fun.
        user = User.objects.get(email__iexact=email)

        subject = 'Oregon Invasives Hotline - Login Link'
        body = render_to_string('users/_login.txt', {
            'user': user,
            'url': user.get_authentication_url(request, next=reverse('users-home'))
        })
        from_email = 'noreply@pdx.edu'
        recipients = [user.email]

        send_mail(subject, body, from_email, recipients)


class UserForm(forms.ModelForm):
    class Meta:
        model = User
        fields = (
            'email',
            'first_name',
            'last_name',
            'phone',
            'biography',
            'affiliations',
            'photo',
            'is_active',
            'is_staff',
        )

    def __init__(self, *args, user, **kwargs):
        """
        `user` is the person using the form, not the person the form is actually going edit
        """
        super().__init__(*args, **kwargs)

        # add a password field to the form if the user is being created. This
        # allows an admin to set an initial password
        if self.instance.pk is None:
            self.fields['password'] = forms.CharField(widget=forms.widgets.PasswordInput)

        if user.pk == self.instance.pk:
            # these fields you shouldn't be allowed to alter if you're editing
            # yourself, for safety reasons
            self.fields.pop("is_active")
            self.fields.pop("is_staff")

        if not user.is_staff:
            # only staff members can control the is_staff field
            self.fields.pop("is_staff", None)

        # only active users should be allowed to fill out these fields
        if not user.is_active:
            self.fields.pop("photo")
            self.fields.pop("biography")
            self.fields.pop("affiliations")

        # stupid chrome...http://stackoverflow.com/a/30976223/2733517
        for name, field in self.fields.items():
            field.widget.attrs['autocomplete'] = "new-password"

    def save(self, *args, **kwargs):
        """
        Save the form, and set the password, if it has been set
        """
        password = self.cleaned_data.pop("password", None)
        if password is not None:
            self.instance.set_password(password)

        instance = super().save(*args, **kwargs)

        # if we got a new photo resize it and convert it to a png
        if self.cleaned_data.get("photo"):
            output_path = instance.photo.path + ".png"
            generate_thumbnail(instance.photo.path, output_path, width=256, height=256)
            self.instance.photo = instance.photo.name + ".png"
            self.instance.save()

        return instance
