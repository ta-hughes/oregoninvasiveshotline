from django.db import models

from oregoninvasiveshotline.visibility import Visibility


class Image(Visibility, models.Model):
    image_id = models.AutoField(primary_key=True)
    image = models.ImageField(upload_to="images")
    name = models.CharField(max_length=255, blank=True)
    created_by = models.ForeignKey("users.User", on_delete=models.CASCADE)
    created_on = models.DateTimeField(auto_now_add=True)
    visibility = models.IntegerField(choices=Visibility.choices, default=Visibility.PROTECTED)

    # create a nullable FK to every object that can have images
    report = models.ForeignKey("reports.Report", null=True, default=None, on_delete=models.SET_NULL)
    comment = models.ForeignKey("comments.Comment", null=True, default=None, on_delete=models.SET_NULL)
    species = models.ForeignKey("species.Species", null=True, default=None, on_delete=models.SET_NULL)

    class Meta:
        db_table = "image"
        ordering = ['pk']

    def __str__(self):
        if self.name:
            return self.name
        return self.image.path
