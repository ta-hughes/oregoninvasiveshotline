import logging
from urllib import parse
from PIL import Image

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


def generate_thumbnail(input_path, output_path, width, height):
    """Generate a thumbnail from the source image.

    If the input image is already smaller than ``width`` X ``height``,
    it will be returned as is.

    The aspect ratio will be preserved if the image has to be resized.

    If the input and output paths are the same, a ``ValueError`` will
    be raised.

    On successful thumbnail generation, ``True`` will be returned. If
    the thumbnail can't be generated for some reason, ``False`` will be
    returned.

    """
    if input_path == output_path:
        raise ValueError('Input path is identical to output path')

    try:
        img = Image.open(input_path)
    except FileNotFoundError:
        log.error('Could not find image at: %s', input_path)
        return False
    except IOError:
        log.exception('Error while opening image at: %s', input_path)
        return False

    try:
        img.thumbnail((width, height))
        img.save(output_path)
    except IOError:
        log.exception('Cannot resize image at: %s', input_path)
        return False

    return True
