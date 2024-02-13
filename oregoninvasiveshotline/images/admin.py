from django.contrib import admin

from .models import Image


class ImageAdmin(admin.ModelAdmin):
    list_display = ['image_id', '__str__', 'created_by', 'created_on']
    list_display_links = ['__str__']
    list_filter = ['species', 'visibility']

    date_hierarchy = 'created_on'

    fieldsets = (
        (None, {
            'fields': (
                'name', 'image', 'visibility',
                'image_id', 'created_by', 'created_on'
            )
        }),
        ('Associations', {
            'fields': ('species', 'report', 'comment')
        }),
    )

    def has_add_permission(self, request):
        return False

    def has_change_permission(self, request, obj=None):
        return False

    def has_delete_permission(self, request, obj=None):
        return False


admin.site.register(Image, ImageAdmin)
