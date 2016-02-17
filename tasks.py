from arctasks import *
from arctasks.django import call_command, manage


@arctask(configured='dev', timed=True)
def init(ctx, overwrite=False):
    virtualenv(ctx, overwrite=overwrite)
    install(ctx)
    createdb(ctx, drop=overwrite)
    migrate(ctx)
    rebuild_index(ctx, input=False)
    loaddata(ctx)
    generate_icons(ctx, clean=overwrite, input=False)


@arctask(configured='dev')
def loaddata(ctx):
    manage(ctx, (
        'loaddata',
        'dummy_user.json category.json severity.json counties.json pages.json',
    ))


@arctask(configured=DEFAULT_ENV)
def post_deploy(ctx):
    """A set of tasks that commonly needs to be run after deploying."""
    generate_icons(ctx, clean=True, input=False)
    rebuild_index(ctx, input=False)


@arctask(configured=DEFAULT_ENV)
def rebuild_index(ctx, input=True):
    call_command('rebuild_index', interactive=input)


@arctask(configured=DEFAULT_ENV)
def generate_icons(ctx, clean=False, force=False, input=True):
    call_command('generate_icons', clean=clean, force=force, interactive=input)
