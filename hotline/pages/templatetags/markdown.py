from django import template
from django.utils.html import mark_safe
import markdown

register = template.Library()


@register.filter
def md(text):
    return mark_safe(markdown.markdown(text))
