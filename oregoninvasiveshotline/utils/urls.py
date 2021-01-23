import logging
from urllib import parse

from django.contrib.sites.models import Site

log = logging.getLogger(__name__)


def build_absolute_url(path, query_string=None):
    domain = Site.objects.get_current().domain
    return parse.urlunparse((
        # scheme
        'https',
        # netloc
        domain,
        # path
        path,
        # params
        '',
        # query
        query_string,
        # fragment
        ''
    ))
