from django.contrib.gis.db import models


class Report(models.Model):
    report_id = models.AutoField(primary_key=True)
    # It may seem odd to have FKs to the species AND category, but in the case
    # where the user doesn't know what species it is, we fall back to just a
    # category (with the reported_species field NULL'd out)
    reported_category = models.ForeignKey("species.Category")
    reported_species = models.ForeignKey("species.Species", null=True, default=None, related_name="+")

    description = models.TextField(verbose_name="Please provide a description of your find")
    location = models.TextField(verbose_name="Please provide a description of the area where species was found")
    has_specimen = models.BooleanField(default=False)

    point = models.PointField(srid=4326)

    created_by = models.ForeignKey("users.User", related_name="reports")
    created_on = models.DateTimeField(auto_now_add=True)

    claimed_by = models.ForeignKey("users.User", null=True, default=None, related_name="claimed_reports")

    # these are copied over from the original site
    edrr_status = models.IntegerField(choices=[
        (0, '',),
        (1, 'No Response/Action Required',),
        (2, 'Local expert notified',),
        (3, 'Population assessed',),
        (4, 'Population treated',),
        (5, 'Ongoing monitoring',),
        (6, 'Controlled at site'),
    ], default=0)

    # the actual species confirmed by an expert
    actual_species = models.ForeignKey("species.Species", null=True, default=None, related_name="reports")

    is_archived = models.BooleanField(default=False)
    is_public = models.BooleanField(default=False, help_text="This report can be viewed by the public")

    objects = models.GeoManager()

    class Meta:
        db_table = "report"


class Comment(models.Model):
    """
    Comments can be left on reports
    """
    comment_id = models.AutoField(primary_key=True)
    body = models.TextField()
    created_on = models.DateField(auto_now_add=True)
    edited_on = models.DateField(auto_now=True)

    visibility = models.IntegerField([
        (0, "Private"),  # only managers/admins/invited experts can see
        (1, "Protected"),  # private + the person reporting it can see
        (2, "Public"),  # the public can see (on a public report)
    ], default=0)

    created_by = models.ForeignKey("users.User")
    report = models.ForeignKey(Report)

    class Meta:
        db_table = "comment"


class Invite(models.Model):
    """
    Abitrary people can be invited (via email) to leave comments on a report
    """
    invite_id = models.AutoField(primary_key=True)
    # the person invited (a User object will be created for them)
    user = models.ForeignKey("users.User", related_name="invites")
    created_on = models.DateTimeField(auto_now_add=True)
    created_by = models.ForeignKey("users.User", related_name="+")
    report = models.ForeignKey(Report)

    class Meta:
        db_table = "invite"

    @classmethod
    def create(cls, *, email, report, inviter, message):
        """
        Create and send an invitation to the person with the given email address
        """
        pass
