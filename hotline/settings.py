from django.conf import global_settings
from django.contrib.messages import constants as messages
from django.core.urlresolvers import reverse_lazy

from local_settings import LocalSetting, SecretSetting

from arcutils.settings import init_settings


ELASTICSEARCH_CONNECTIONS = {
    'default': {
        'hosts': [LocalSetting(default='http://localhost:9200')],
        'index_name': LocalSetting(),
    }
}

init_settings()


PASSWORD_HASHERS = list(global_settings.PASSWORD_HASHERS)
PASSWORD_HASHERS.insert(1, 'hotline.utils.RubyPasswordHasher')
