# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations
import django.contrib.gis.db.models.fields


class Migration(migrations.Migration):

    dependencies = [
        ('users', '__first__'),
        ('species', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Comment',
            fields=[
                ('comment_id', models.AutoField(serialize=False, primary_key=True)),
                ('body', models.TextField()),
                ('created_on', models.DateField(auto_now_add=True)),
                ('edited_on', models.DateField(auto_now=True)),
                ('visibility', models.IntegerField(default=0, verbose_name=[(0, 'Private'), (1, 'Protected'), (2, 'Public')])),
                ('created_by', models.ForeignKey(to='users.User')),
            ],
            options={
                'db_table': 'comment',
            },
        ),
        migrations.CreateModel(
            name='Invite',
            fields=[
                ('invite_id', models.AutoField(serialize=False, primary_key=True)),
                ('invited_on', models.DateTimeField(auto_now_add=True)),
                ('invited_by', models.ForeignKey(related_name='+', to='users.User')),
            ],
            options={
                'db_table': 'invite',
            },
        ),
        migrations.CreateModel(
            name='Report',
            fields=[
                ('report_id', models.AutoField(serialize=False, primary_key=True)),
                ('description', models.TextField(verbose_name='Please provide a description of your find')),
                ('location', models.TextField(verbose_name='Please provide a description of the area where species was found')),
                ('point', django.contrib.gis.db.models.fields.PointField(srid=4326)),
                ('created_on', models.DateTimeField(auto_now_add=True)),
                ('edrr_status', models.IntegerField(choices=[(0, ''), (1, 'No Response/Action Required'), (2, 'Local expert notified'), (3, 'Population assessed'), (4, 'Population treated'), (5, 'Ongoing monitoring'), (6, 'Controlled at site')])),
                ('is_archived', models.BooleanField(default=False)),
                ('is_public', models.BooleanField(help_text='This report can be viewed by the public', default=False)),
                ('actual_species', models.ForeignKey(null=True, related_name='reports', default=None, to='species.Species')),
                ('claimed_by', models.ForeignKey(null=True, related_name='claimed_reports', default=None, to='users.User')),
                ('reported_by', models.ForeignKey(related_name='reports', to='users.User')),
                ('reported_category', models.ForeignKey(to='species.Category')),
                ('reported_species', models.ForeignKey(null=True, related_name='+', default=None, to='species.Species')),
            ],
            options={
                'db_table': 'report',
            },
        ),
        migrations.AddField(
            model_name='invite',
            name='report',
            field=models.ForeignKey(to='reports.Report'),
        ),
        migrations.AddField(
            model_name='invite',
            name='user',
            field=models.ForeignKey(related_name='invites', to='users.User'),
        ),
        migrations.AddField(
            model_name='comment',
            name='report',
            field=models.ForeignKey(to='reports.Report'),
        ),
    ]
