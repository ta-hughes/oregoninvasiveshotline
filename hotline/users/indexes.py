from elasticmodels import Index, StringField

from hotline.reports.indexes import name

from .models import User


class UserIndex(Index):
    first_name = StringField(analyzer=name)
    last_name = StringField(analyzer=name)
    email = StringField(analyzer=name)

    class Meta:
        model = User
