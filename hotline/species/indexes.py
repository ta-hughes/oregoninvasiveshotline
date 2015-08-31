from elasticmodels import DateField, Index, IntegerField, StringField
from elasticsearch_dsl import MetaField, analyzer, token_filter, tokenizer

from .models import Species


name = analyzer(
    "name",
    tokenizer=tokenizer("standard"),
    filter=[
        "standard",
        "lowercase",
        token_filter(
            "simple_edge",
            type="pattern_capture",
            patterns=["(?=(...))(?=(....))"]
        )
    ]
)


class SpeciesIndex(Index):
    category = StringField(
        attr="category.name",
        fields={
            'raw': StringField(index="not_analyzed"),
        },
    )
    category_id = IntegerField(attr="category.pk")

    severity = StringField(
        attr="severity.name",
        fields={
            'raw': StringField(index="not_analyzed"),
        },
    )
    severity_id = IntegerField(attr="severity.pk")

    class Meta:
        doc_type = "species"
        model = Species
        fields = [
            'is_confidential',
        ]
        all = MetaField(analyzer='name')
