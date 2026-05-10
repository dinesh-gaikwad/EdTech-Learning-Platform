from django.contrib import admin

from .models import (
    Payment,
    Subscription,
    Transaction
)

admin.site.register(Payment)
admin.site.register(Subscription)
admin.site.register(Transaction)
