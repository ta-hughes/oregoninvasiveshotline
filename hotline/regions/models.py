from django.contrib.gis.db import models


class Region(models.Model):
    region_id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=255)
    center = models.PointField(srid=4326)

    objects = models.GeoManager()

    class Meta:
        db_table = "region"
        ordering = ['name']

    def __str__(self):
        return self.name
