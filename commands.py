from collections import defaultdict

from runcommands import DEFAULT_ENV, command, configure
from runcommands.util import confirm, printer

from arctasks.commands import *
from arctasks.django import call_command, manage, setup


configure(default_env='dev')


@command(env='dev', timed=True)
def init(config, overwrite=False):
    virtualenv(config, overwrite=overwrite)
    install(config)
    createdb(config, drop=overwrite)
    migrate(config)
    rebuild_index(config, input=False)
    loaddata(config)
    generate_icons(config, clean=overwrite, input=False)


@command(env='dev')
def loaddata(config):
    manage(config, (
        'loaddata',
        'dummy_user.json category.json severity.json counties.json pages.json',
    ))


@command(default_env=DEFAULT_ENV)
def post_deploy(config):
    """A set of tasks that commonly needs to be run after deploying."""
    generate_icons(config, clean=True, input=False)
    rebuild_index(config, input=False)


@command(default_env=DEFAULT_ENV)
def rebuild_index(config, input=True):
    call_command(config, 'rebuild_index', interactive=input)


@command(default_env=DEFAULT_ENV)
def generate_icons(config, clean=False, force=False, input=True):
    call_command(config, 'generate_icons', clean=clean, force=force, interactive=input)


@command(default_env=DEFAULT_ENV)
def remove_duplicate_users(config):
    setup(config)
    from django.apps import apps
    from django.contrib.auth import get_user_model
    from arcutils.db import will_be_deleted_with

    Comment = apps.get_model('comments', 'Comment')
    Image = apps.get_model('images', 'Image')
    Notification = apps.get_model('notifications', 'Notification')
    UserNotificationQuery = apps.get_model('notifications', 'UserNotificationQuery')
    Invite = apps.get_model('reports', 'Invite')
    Report = apps.get_model('reports', 'Report')

    user_model = get_user_model()
    dupes = user_model.objects.raw(
        'SELECT * from "user" u1 '
        'WHERE ('
        '    SELECT count(*) FROM "user" u2 WHERE lower(u2.email) = lower(u1.email )'
        ') > 1 '
        'ORDER BY lower(email)'
    )
    dupes = [d for d in dupes]

    printer.info('Found {n} duplicates'.format(n=len(dupes)))

    # Delete any dupes we can.
    # Active and staff users are never deleted.
    # Public users with no associated records will be deleted.
    for user in dupes:
        email = user.email
        objects = list(will_be_deleted_with(user))
        num_objects = len(objects)
        f = locals()
        if user.is_active:
            print('Skipping active user: {email}.'.format_map(f))
        elif user.is_staff:
            print('Skipping inactive staff user: {email}.'.format_map(f))
        elif num_objects == 0:
            printer.warning('Deleting {email} will *not* cascade.'.format_map(f))
            if confirm(config, 'Delete {email}?'.format_map(f), yes_values=('yes',)):
                print('Okay, deleting {email}...'.format_map(f), end='')
                user.delete()
                dupes.remove(user)
                print('Deleted')
        else:
            print(
                'Deleting {email} would cascade to {num_objects} objects. Skipping.'.format_map(f))

    # Group the remaining duplicates by email address
    grouped_dupes = defaultdict(list)
    for user in dupes:
        email = user.email.lower()
        grouped_dupes[email].append(user)
    grouped_dupes = {email: users for (email, users) in grouped_dupes.items() if len(users) > 1}

    # For each group, find the "best" user (staff > active > inactive).
    # The other users' associated records will be associated with this
    # "winner".
    for email, users in grouped_dupes.items():
        winner = None
        for user in users:
            if user.is_staff:
                winner = user
                break
        if winner is None:
            for user in users:
                if user.is_active:
                    winner = user
                    break
        if winner is None:
            for user in users:
                if user.full_name:
                    winner = user
        if winner is None:
            winner = users[0]
        losers = [user for user in users if user != winner]
        print('Winner:', winner.full_name, '<{0.email}>'.format(winner))
        for loser in losers:
            print('Loser:', loser.full_name, '<{0.email}>'.format(loser))
            print('Re-associating loser objects...', end='')
            Comment.objects.filter(created_by=loser).update(created_by=winner)
            Image.objects.filter(created_by=loser).update(created_by=winner)
            Invite.objects.filter(user=loser).update(user=winner)
            Invite.objects.filter(created_by=loser).update(created_by=winner)
            Notification.objects.filter(user=loser).update(user=winner)
            Report.objects.filter(claimed_by=loser).update(claimed_by=winner)
            Report.objects.filter(created_by=loser).update(created_by=winner)
            UserNotificationQuery.objects.filter(user=loser).update(user=winner)
            print('Done')
