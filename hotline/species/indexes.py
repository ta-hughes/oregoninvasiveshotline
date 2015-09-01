from elasticmodels import DateField, Index, IntegerField, StringField
from elasticsearch_dsl import MetaField, analyzer, token_filter, tokenizer

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
