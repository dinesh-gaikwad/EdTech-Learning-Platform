# /workspaces/EdTech-Learning-Platform/backend/apps/accounts/admin.py

from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from .models import User, UserActivity, UserSkill


@admin.register(User)
class CustomUserAdmin(UserAdmin):

    list_display = (
        'id',
        'username',
        'email',
        'role',
        'learning_streak',
        'total_points',
        'is_verified',
        'is_premium',
        'created_at'
    )

    list_filter = (
        'role',
        'is_verified',
        'is_premium',
        'is_staff',
        'is_superuser'
    )

    search_fields = (
        'username',
        'email',
        'first_name',
        'last_name'
    )

    ordering = ('-created_at',)

    fieldsets = UserAdmin.fieldsets + (
        (
            'Platform Information',
            {
                'fields': (
                    'role',
                    'profile_picture',
                    'cover_image',
                    'bio',
                    'github_url',
                    'linkedin_url',
                    'portfolio_url',
                    'country',
                    'city',
                    'learning_streak',
                    'total_points',
                    'completed_courses',
                    'is_verified',
                    'is_premium',
                    'last_activity'
                )
            }
        ),
    )


@admin.register(UserActivity)
class UserActivityAdmin(admin.ModelAdmin):

    list_display = (
        'id',
        'user',
        'activity_type',
        'created_at'
    )

    search_fields = (
        'user__username',
        'activity_type'
    )

    ordering = ('-created_at',)


@admin.register(UserSkill)
class UserSkillAdmin(admin.ModelAdmin):

    list_display = (
        'id',
        'user',
        'skill_name',
        'level'
    )

    search_fields = (
        'user__username',
        'skill_name'
    )