# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations
import django.contrib.gis.db.models.fields
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('users', '0001_initial'),
        ('species', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Invite',
            fields=[
                ('invite_id', models.AutoField(primary_key=True, serialize=False)),
                ('created_on', models.DateTimeField(auto_now_add=True)),
                ('created_by', models.ForeignKey(related_name='+', to='users.User', on_delete=django.db.models.deletion.CASCADE)),
            ],
            options={
                'db_table': 'invite',
            },
        ),
        migrations.CreateModel(
            name='Report',
            fields=[
                ('report_id', models.AutoField(primary_key=True, serialize=False)),
                ('description', models.TextField(verbose_name='Please provide a description of your find')),
                ('location', models.TextField(verbose_name='Please provide a description of the area where species was found')),
                ('has_specimen', models.BooleanField(default=False)),
                ('point', django.contrib.gis.db.models.fields.PointField(srid=4326)),
                ('created_on', models.DateTimeField(auto_now_add=True)),
                ('edrr_status', models.IntegerField(default=0, choices=[(0, ''), (1, 'No Response/Action Required'), (2, 'Local expert notified'), (3, 'Population assessed'), (4, 'Population treated'), (5, 'Ongoing monitoring'), (6, 'Controlled at site')])),
                ('is_archived', models.BooleanField(default=False)),
                ('is_public', models.BooleanField(default=False, help_text='This report can be viewed by the public')),
                ('actual_species', models.ForeignKey(default=None, related_name='reports', null=True, to='species.Species', on_delete=django.db.models.deletion.SET_NULL)),
                ('claimed_by', models.ForeignKey(default=None, related_name='claimed_reports', null=True, to='users.User', on_delete=django.db.models.deletion.SET_NULL)),
                ('created_by', models.ForeignKey(related_name='reports', to='users.User', on_delete=django.db.models.deletion.CASCADE)),
                ('reported_category', models.ForeignKey(to='species.Category', on_delete=django.db.models.deletion.CASCADE)),
                ('reported_species', models.ForeignKey(default=None, related_name='+', null=True, to='species.Species', on_delete=django.db.models.deletion.SET_NULL)),
            ],
            options={
                'db_table': 'report',
            },
        ),
        migrations.AddField(
            model_name='invite',
            name='report',
            field=models.ForeignKey(to='reports.Report', on_delete=django.db.models.deletion.CASCADE),
        ),
        migrations.AddField(
            model_name='invite',
            name='user',
            field=models.ForeignKey(related_name='invites', to='users.User', on_delete=django.db.models.deletion.CASCADE),
        ),
    ]
