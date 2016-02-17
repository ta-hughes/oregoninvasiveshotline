from django.conf import global_settings
from django.contrib.messages import constants as messages

from arcutils.settings import init_settings

init_settings()

MESSAGE_TAGS = {
    messages.ERROR: 'danger',
}
PASSWORD_HASHERS = list(global_settings.PASSWORD_HASHERS)
PASSWORD_HASHERS.insert(1, 'oregoninvasiveshotline.utils.RubyPasswordHasher')
