from django import template
from hotline.notifications.models import UserNotificationQuery

register = template.Library()


@register.filter
def notification_url(entry):
    return str(UserNotificationQuery.objects.get(pk=entry.choice_value).query)
