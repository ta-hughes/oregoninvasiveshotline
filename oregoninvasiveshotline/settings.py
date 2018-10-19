import os

from django.conf import global_settings

from arcutils.settings import init_settings
from emcee.backends.aws import processors


def set_google_map_url(settings):
    env = settings["ENV"]
    if env == 'prod' or env == 'stage':
        GOOGLE_API_KEY = processors.ssm(
            'GOOGLE_API_KEY', ssm_prefix=settings['SSM_KEY'], region=settings['AWS_REGION'])
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


init_settings(settings_processors=[processors.set_secret_key,
                                   processors.set_sentry_dsn,
                                   processors.set_smtp_parameters,
                                   processors.set_database_parameters,
                                   processors.set_elasticsearch_parameters,
                                   set_google_map_url])

PASSWORD_HASHERS = list(global_settings.PASSWORD_HASHERS)
PASSWORD_HASHERS.insert(1, 'oregoninvasiveshotline.hashers.RubyPasswordHasher')
