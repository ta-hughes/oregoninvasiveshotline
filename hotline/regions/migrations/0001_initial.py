# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations
import django.contrib.gis.db.models.fields


class Migration(migrations.Migration):

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Region',
            fields=[
                ('region_id', models.AutoField(primary_key=True, serialize=False)),
                ('name', models.CharField(max_length=255)),
                ('center', django.contrib.gis.db.models.fields.PointField(srid=4326)),
            ],
            options={
                'ordering': ['name'],
                'db_table': 'region',
            },
        ),
    ]
