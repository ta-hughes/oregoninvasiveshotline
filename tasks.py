import os
import sys
from getpass import getpass

from arctasks import *
from arctasks.django import setup, get_settings, manage


@arctask(configured='dev', timed=True)
def init(ctx, overwrite=False):
    virtualenv(ctx, overwrite=overwrite)
    install(ctx)
    createdb(ctx, drop=overwrite)
    migrate(ctx)
    manage(ctx, 'rebuild_index --clopen --noinput')
    loaddata(ctx)


@arctask(configured='dev')
def loaddata(ctx):
    manage(ctx, (
        'loaddata',
        'dummy_user.json category.json severity.json species.json counties.json pages.json',
    ))


@arctask(configured='dev')
def convert(ctx, copy_images=False):
    setup()
    settings = get_settings()
    settings.DATABASES['old'] = {
        'ENGINE': 'django.contrib.gis.db.backends.postgis',
        'HOST': 'pgsql.rc.pdx.edu',
        'NAME': 'invhotline',
        'USER': 'invhotline_l',
        'PASSWORD': getpass(
            'Old database password (get from '
            '/vol/www/invasivespecieshotline/invasivespecieshotline/config/database.yml): '
        ),
    }
    sys.path.insert(0, os.path.dirname(__file__))
    import convert
    if copy_images:
        local(ctx, 'bash convert.sh')
