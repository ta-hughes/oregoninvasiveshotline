from ..perms import permissions
from hotline.users.models import User

@permissions.register
def can_modify_page(user):
    return user.is_staff

