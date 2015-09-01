from elasticmodels import Index, StringField

from .models import Species


class SpeciesIndex(Index):

    severity = StringField(attr="get_severity")
    category = StringField(attr="get_category")

    class Meta:
        model = Species
        fields = [
            'species_id',
            'name',
            'scientific_name',
            'remedy',
            'resources',
            'is_confidential',
        ]
