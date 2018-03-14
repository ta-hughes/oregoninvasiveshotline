from runcommands.commands import remote
from runcommands import command

from emcee.commands.deploy import deploy
from emcee.commands.python import virtualenv, install
from emcee.commands.django import manage, manage_remote
from emcee.commands.files import rsync

from emcee.backends.dev.db import provision_database as provision_database_local
from emcee.backends.aws.provision.base import patch_host
from emcee.backends.aws.provision.base import provision_volume, patch_host
from emcee.backends.aws.provision.gis import provision_gis
from emcee.backends.aws.provision.python import provision_python
from emcee.backends.aws.provision.services.local import provision_nginx
from emcee.backends.aws.provision.services.remote import provision_database
from emcee.backends.aws.deploy import AWSDjangoDeployer
from emcee.backends.aws.infrastructure.commands import *

DEFAULT_FIXTURES = 'counties.json'
DEVELOPMENT_FIXTURES = 'dummy_user.json category.json severity.json pages.json'


@command
def loaddata(config):
    manage(config, 'loaddata {}'.format(DEFAULT_FIXTURES))
    manage(config, 'loaddata {}'.format(DEVELOPMENT_FIXTURES))


@command(env='dev', timed=True)
def init(config, overwrite=False):
    virtualenv(config, config.venv, overwrite=overwrite)
    install(config)
    # provision_database_local(config, drop=overwrite, with_postgis=True)
    manage(config, 'migrate --no-input')
    loaddata(config)
    manage(config, 'generate_icons --no-input --clean --force')
    manage(config, 'rebuild_index --noinput')
    # test(config, with_coverage=True, force_env='test')


class Deployer(AWSDjangoDeployer):
    def bootstrap_application(self):
        super(Deployer, self).bootstrap_application()

        # Install static/managed record data
        manage_remote(self.config, 'loaddata {}'.format(DEFAULT_FIXTURES))

        # Create media directory on EBS mount and link to app's media root
        remote(self.config, ('mkdir', '-p', '/vol/store/media'), sudo=True)
        remote(self.config, ('mkdir', '-p', '{remote.path.root}/media'), sudo=True)
        remote(self.config, ('test', '-h', '{remote.path.media}', '||',
                             'ln', '-sf', '/vol/store/media', '{remote.path.media}'), sudo=True)

        # Synchronize icons and assorted media assets
        rsync(self.config, 'media/icons', self.config.remote.path.media)
        rsync(self.config, 'media/generated_icons', self.config.remote.path.media)
        rsync(self.config, 'media/generated_thumbnails', self.config.remote.path.media)

        # Generate icons
        manage_remote(self.config, 'generate_icons --no-input')

        # Set the correct permissions on generated assets
        remote(self.config, ('chown', '-R', '{service.user}:nginx', '/vol/store/media'), sudo=True)

        # Rebuild search index
        manage_remote(self.config, 'rebuild_index --noinput')


@command(env=True)
def deploy_app(config, provision=False, createdb=False):
    if provision:
        provision_volume(config, mount_point='/vol/store')
        provision_python(config)
        provision_gis(config)
        provision_nginx(config)
    if createdb:
        provision_database(config, with_postgis=True)

    deploy(config, Deployer)
