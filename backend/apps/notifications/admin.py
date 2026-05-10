from django.contrib import admin

from .models import (
    Notification,
    EmailNotification,
    PushNotification
)

admin.site.register(Notification)
admin.site.register(EmailNotification)
admin.site.register(PushNotification)
