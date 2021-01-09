import os

from emcee.backends.aws import processors
from sentry_sdk.integrations.celery import CeleryIntegration
from sentry_sdk.integrations.django import DjangoIntegration
import sentry_sdk

from django.conf import global_settings

from oregoninvasiveshotline.utils.settings import init_settings
from oregoninvasiveshotline import __version__


def set_google_map_url(settings):
    env = settings["ENV"]
    if env == 'prod' or env == 'stage':
        GOOGLE_API_KEY = processors.ssm('GOOGLE_API_KEY',
                                        ssm_prefix=settings['SSM_KEY'],
                                        region=settings['AWS_REGION'])
        settings["GOOGLE"]["maps"] = {
            "url": "//maps.googleapis.com/maps/api/js?key={}".format(GOOGLE_API_KEY)}
    else:
        try:
            GOOGLE_API_KEY = os.environ["GOOGLE_API_KEY"]
            settings["GOOGLE"]["maps"] = {
                "url": "//maps.googleapis.com/maps/api/js?key={}".format(GOOGLE_API_KEY)}
        except KeyError:
            raise KeyError(
                'You need to export a GOOGLE_API_KEY environment variable in development environments')


def init_sentry_sdk(settings):
    env = settings['ENV']
    if env == 'prod' or env == 'stage':
        sentry_sdk.init(
            dsn="https://263913aeb1264f1bbc40c1b35dda9933@o50547.ingest.sentry.io/153798",
            release=__version__,
            environment=env,
            traces_sample_rate=0.1,
            send_default_pii=True,
            integrations=[CeleryIntegration(),
                          DjangoIntegration()]
        )


init_settings(settings_processors=[processors.set_secret_key,
                                   processors.set_smtp_parameters,
                                   processors.set_database_parameters,
                                   processors.set_elasticsearch_parameters,
                                   set_google_map_url,
                                   init_sentry_sdk])

PASSWORD_HASHERS = list(global_settings.PASSWORD_HASHERS)
PASSWORD_HASHERS.insert(1, 'oregoninvasiveshotline.hashers.RubyPasswordHasher')
