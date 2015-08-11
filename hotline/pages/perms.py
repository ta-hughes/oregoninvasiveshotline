from ..perms import permissions


@permissions.register
def can_modify_page(user):
    return user.is_staff
