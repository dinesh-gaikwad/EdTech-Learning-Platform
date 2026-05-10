from django.contrib import admin

from .models import (
    DiscussionPost,
    Comment,
    Like,
    CommunityGroup
)

admin.site.register(DiscussionPost)
admin.site.register(Comment)
admin.site.register(Like)
admin.site.register(CommunityGroup)
