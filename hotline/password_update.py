from django.utils.crypto import get_random_string

from hotline.users.models import User
from hotline.users.utils import RubyPasswordHasher

"""
    So here we got a little script to move all the passwords from the old site to the new one.
    The old passwords should be a 64 character string representing the sha256 hash of the password.
    So something like

        v3aiiff13720e8ad9047dd39466b332974e592c2fa383d4a3960714caefzc4f2
        ^
        NOTE: not an actual hash so don't go messin' with it or anything.
        Your efforts will be fruitless and boring.

    This script takes the raw password from the database, seasons it with some salt, and grills
    it in the encode method of the RubyPasswordHasher class.
    The resulting string is in the official Django format, e.g.

        <algorithm>$<iterations>$<salt>$<hash>

    Bam! And there you have it. Hot new password fresh off the grill. Serve with fries, and peace of mind.
"""

PASS_LENGTH = 64

algorithm = "RubyPasswordHasher"
hasher = RubyPasswordHasher()


def update():
    users = User.objects.all()
    for user in users:
        password = user.password
        if len(password) == PASS_LENGTH:
            # Password is just a SHA256 hash. gotta prefix it and all
            salt = get_random_string(8)
            hashed = hasher.encode(password, salt)
            user.password = hashed
            user.save()
            print(user.password)

update()
