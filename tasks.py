from collections import defaultdict

from arctasks import *
from arctasks.django import call_command, manage, setup
from arctasks.util import confirm, print_info, print_warning


@arctask(configured='dev', timed=True)
def init(ctx, overwrite=False):
    virtualenv(ctx, overwrite=overwrite)
    install(ctx)
    createdb(ctx, drop=overwrite)
    migrate(ctx)
    rebuild_index(ctx, input=False)
    loaddata(ctx)
    generate_icons(ctx, clean=overwrite, input=False)


@arctask(configured='dev')
def loaddata(ctx):
    manage(ctx, (
        'loaddata',
        'dummy_user.json category.json severity.json counties.json pages.json',
    ))


@arctask(configured=DEFAULT_ENV)
def post_deploy(ctx):
    """A set of tasks that commonly needs to be run after deploying."""
    generate_icons(ctx, clean=True, input=False)
    rebuild_index(ctx, input=False)


@arctask(configured=DEFAULT_ENV)
def rebuild_index(ctx, input=True):
    call_command('rebuild_index', interactive=input)


@arctask(configured=DEFAULT_ENV)
def generate_icons(ctx, clean=False, force=False, input=True):
    call_command('generate_icons', clean=clean, force=force, interactive=input)


@arctask(configured=DEFAULT_ENV)
def remove_duplicate_users(ctx):
    setup()
    from django.contrib.auth import get_user_model
    from arcutils.db import will_be_deleted_with

    user_model = get_user_model()
    dupes = user_model.objects.raw(
        'SELECT * from "user" u1 '
        'WHERE ('
        '    SELECT count(*) FROM "user" u2 WHERE lower(u2.email) = lower(u1.email )'
        ') > 1 '
        'ORDER BY lower(email)'
    )
    dupes = [d for d in dupes]

    print_info('Found {n} duplicates'.format(n=len(dupes)))

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
            print_warning('Deleting {email} will *not* cascade.'.format_map(f))
            if confirm(ctx, 'Delete {email}?'.format_map(f), yes_values=('yes',)):
                print('Okay, deleting {email}...'.format_map(f), end='')
                user.delete()
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
        print('Winner:', winner.full_name, '<{0.email}>'.format(winner), winner.is_active, winner.is_staff)
        for loser in losers:
            print('Loser:', loser.full_name, '<{0.email}>'.format(loser), loser.is_active, loser.is_staff)
        print_warning('Moving records has not yet been implemented :(')
