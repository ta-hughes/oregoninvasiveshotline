import json
from collections import defaultdict

from django.core.validators import RegexValidator
from django.db import models


def category_id_to_species_id_json():
    species = Species.objects.all().select_related("category").values_list("category__pk", "pk").order_by("category__pk")
    category_id_to_species_id = defaultdict(list)
    for category_id, species_id in species:
        category_id_to_species_id[category_id].append(species_id)

    return json.dumps(category_id_to_species_id)


class Category(models.Model):
    """Simply a container for species"""
    category_id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=255)
    icon = models.ImageField(upload_to="icons", help_text="""
        It is expected that you got the icon from http://mapicons.mapsmarker.com
        and they have a transparent background, and a white foreground
    """, null=True, blank=True)

    class Meta:
        db_table = "category"
        ordering = ['name']

    def __str__(self):
        return self.name


class Severity(models.Model):
    """
    This could be an enum, but in the original DB it was a table with 3 rows
    for "native" "non-native" "invasive"
    """
    severity_id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=255)
    color = models.CharField(max_length=7, help_text="An HTML color of the form '#rrggbb'", validators=[
        RegexValidator(r"#[0-9A-Fa-f]{6}")
    ])

    class Meta:
        db_table = "severity"
        ordering = ['name']

    def __str__(self):
        return self.name


class Species(models.Model):

    class Meta:
        db_table = 'species'
        ordering = ['name']

    species_id = models.AutoField(primary_key=True)
    category = models.ForeignKey(Category)
    is_confidential = models.BooleanField(
        default=False,
        help_text=(
            'A species can be marked as confidential if making a report about it public would '
            'cause harm'
        )
    )
    name = models.CharField(max_length=255)
    remedy = models.TextField(blank=True)
    resources = models.TextField(blank=True)
    scientific_name = models.CharField(max_length=255, blank=True)
    severity = models.ForeignKey(Severity)

    @property
    def title(self):
        if self.scientific_name:
            return '{0.name} ({0.scientific_name})'.format(self)
        return self.name

    def __str__(self):
        return self.title
