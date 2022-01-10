# Oregon Invasive Species Hotline

[![Build Status](https://travis-ci.org/PSU-OIT-ARC/oregoninvasiveshotline.svg?branch=master)](https://travis-ci.org/PSU-OIT-ARC/oregoninvasiveshotline)

This project allows members of the public to submit reports of invasive species for experts to
review. Experts can login and review the reports, comment on them, and make a final determination
about the species that was reported

## Technology stack

- PostgreSQL 11
- PostGIS 2.5.x
- Python 3.7
- Django 3.2 LTS
- Google Maps

## Getting started

Ensure that you have Docker and Docker Compose installed in your host's environment.

To use the provided Docker container definitions:

    docker-compose -f docker-compose.dev.yml up -d

To authenticate with the provided default user:

    username: foobar@example.com
    password: foobar

A Google API Key is needed for the mapping features in this project. In
development environments (native or docker) you should export an environment variable, eg:

    export GOOGLE_API_KEY='{ key }'

To prepare the database you may use, e.g., the `import_database` command to install a copy of production data.

To update the frontend dependencies of the project, use the included make rule:

    make client_dependencies

To run the test library:

    docker-compose -f docker-compose.dev.yml run test

## Deploying

This project using the Emcee tooling to define and orchestrate resource provisioning and deployment.
See the AWS cloudformation templates in `cloudformation` and the command definitions in `commands.py`
for more information.

API keys for stage and production environments are stored and fetched from AWS key store; you will be
prompted to supply these keys the first time you provision infrastructure for a given environment.

## General notes

### Regular maintenance tasks

This project ships with a crontab which handles scheduling of several regular tasks:

- Clearing expired HTTP sessions
- Generates icons for uploaded images
- Rebuilds the Elasticsearch index

### Email notifications

Several workflows trigger email notifications based on specific criteria. All such notifications
are implemented and orchestrated using Celery-based tasks in order that they are performed
out-of-band with respect to the request/response cycle.

### Application behavior

This project uses an unconventional approach to its use of the built-in Django user and
authentication mechanisms. Traditionally, the `User.is_active` attribute supports soft-delete
behavior, whereby individual users may be disabled without removing the record and those with
relations to it. In this case, the attribute signifies whether or not the user record in question
is considered to be staff or an individual (unaffiliated) contributor.

In order to support the pre-existing workflows which require these users to be able to login
(i.e., successfully authenticate), the `django.contrib.auth.backends.AllowAllUsersModelBacked`
added in Django 1.10 is used.

There is a "subscribe to search" feature that allows an active user of the system to perform
a search on the reports list page and then subscribe to it. Meaning: whenever a new report is
submitted that matches that search, the subscriber will get an email notification about it.
The way this is implemented is the `request.GET` parameters are saved to the `UserNotificationQuery`
model as a string like "querystring=foobar&category-4=142".

When a report is submitted, a new `ReportSearchForm` is instantiated and passed the decoded GET
parameters that were saved in the `UserNotificationQuery` model; if the `search` method on the
form finds results matching the newly submitted report a notification is sent to the user.
