from arctasks import *
from arctasks.django import manage


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


@arctask(configured='convert')
def convert(ctx, copy_images=False):
    local(ctx, '{bin.python} convert.py')
    if copy_images:
        local(ctx, 'bash convert.sh')
