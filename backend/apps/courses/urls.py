from django.urls import path

from .views import (
    CourseListView,
    CourseDetailView,
    EnrollView,
    ReviewView
)

urlpatterns = [

    path(
        '',
        CourseListView.as_view(),
        name='course-list'
    ),

    path(
        '<int:pk>/',
        CourseDetailView.as_view(),
        name='course-detail'
    ),

    path(
        '<int:pk>/enroll/',
        EnrollView.as_view(),
        name='course-enroll'
    ),

    path(
        '<int:pk>/review/',
        ReviewView.as_view(),
        name='course-review'
    ),
]
