import base64
import hashlib
from collections import OrderedDict

from django.contrib.auth.hashers import BasePasswordHasher, mask_hash
from django.utils.crypto import get_random_string, pbkdf2
from django.utils.translation import ugettext_noop as _


class RubyPasswordHasherInvalidHashException(Exception):
    pass


class RubyPasswordHasher(BasePasswordHasher):
    """
    A password hasher that re-hashes the passwords from the old site so they can be used here.
    Encryption (old): Sha256
    """
    algorithm = "RubyPasswordHasher"
    iterations = 1500
    digest = hashlib.sha256

    def verify(self, password, encoded):
        """
        Actually, I think the only thing we have to do here is check that
        encoded_2 == encrypted
        instead of password == encrypted
        """
        algorithm, iterations, salt, hash = encoded.split('$', 3)
        assert algorithm == self.algorithm
        # here's the extra step
        hashed = hashlib.sha256(password.encode("utf-8")).hexdigest()
        encoded_2 = self.encode(hashed, salt)
        return encoded_2 == encoded

    def encode(self, password, salt, iterations=None):
        assert password is not None
        assert salt and '$' not in salt
        if not iterations:
            iterations = self.iterations
        hashed = hashlib.sha256(password.encode("utf-8")).hexdigest()
        hash = pbkdf2(hashed, salt, iterations, digest=self.digest)
        hash = base64.b64encode(hash).decode('ascii').strip()
        return "%s$%d$%s$%s" % (self.algorithm, iterations, salt, hash)

    def salt(self):
        return get_random_string(8)

    def safe_summary(self, encoded):
        algorithm, iterations, salt, hash = encoded.split('$', 3)
        assert algorithm == self.algorithm
        return OrderedDict([
            (_('algorithm'), algorithm),
            (_('iterations'), iterations),
            (_('salt'), mask_hash(salt)),
            (_('hash'), mask_hash(hash)),
        ])

    def must_update(self, encoded):
        algorithm, iterations, salt, hash = encoded.split('$', 3)
        return int(iterations) != self.iterations
