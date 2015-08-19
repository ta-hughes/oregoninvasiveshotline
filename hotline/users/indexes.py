from hotline.reports.indexes import name
from elasticmodels import DateField, Index, IntegerField, StringField
from elasticsearch_dsl import MetaField, analyzer, token_filter, tokenizer
from .models import User


class UserIndex(Index):
    first_name = StringField(analyzer="name")
    last_name = StringField(analyzer="name")
    email = StringField(analyzer="name")

    class Meta:
        model = User
