from django.conf import settings


def defaults(request):
    return {
        'PROJECT': settings.PROJECT,
        'CONTACT_EMAIL': settings.CONTACT_EMAIL,
        'GOOGLE': settings.GOOGLE,
    }
