# /workspaces/EdTech-Learning-Platform/backend/apps/accounts/urls.py

from django.urls import path

from .views import (
    RegisterView,
    LoginView,
    ProfileView,
    LeaderboardView,
    ActivityView,
    SkillView,
    NotificationView,
    DashboardStatsView
)

urlpatterns = [

    path(
        'register/',
        RegisterView.as_view(),
        name='register'
    ),

    path(
        'login/',
        LoginView.as_view(),
        name='login'
    ),

    path(
        'profile/',
        ProfileView.as_view(),
        name='profile'
    ),

    path(
        'leaderboard/',
        LeaderboardView.as_view(),
        name='leaderboard'
    ),

    path(
        'activities/',
        ActivityView.as_view(),
        name='activities'
    ),

    path(
        'skills/',
        SkillView.as_view(),
        name='skills'
    ),

    path(
        'notifications/',
        NotificationView.as_view(),
        name='notifications'
    ),

    path(
        'dashboard-stats/',
        DashboardStatsView.as_view(),
        name='dashboard-stats'
    ),
]