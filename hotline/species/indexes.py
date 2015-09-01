from elasticmodels import Index, StringField

from .models import Species


class SpeciesIndex(Index):

    severity = StringField(attr="severity.name")
    category = StringField(attr="category.name")

    class Meta:
        model = Species
        fields = [
            'name',
            'scientific_name',
            'remedy',
            'resources',
            'is_confidential',
        ]
