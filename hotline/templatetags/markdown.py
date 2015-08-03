from django import template
import markdown

register = template.Library()

@register.filter
def md(text):
    return markdown.markdown(text)
