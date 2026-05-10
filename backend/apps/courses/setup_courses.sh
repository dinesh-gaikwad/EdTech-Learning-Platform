#!/bin/bash

set -e

BASE="/workspaces/EdTech-Learning-Platform/backend/apps/courses"

mkdir -p $BASE/migrations

touch $BASE/migrations/__init__.py

# __init__.py
cat > $BASE/__init__.py << 'PY'
default_app_config = 'courses.apps.CoursesConfig'
PY

# apps.py
cat > $BASE/apps.py << 'PY'
from django.apps import AppConfig


class CoursesConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'courses'
    verbose_name = 'Courses & Learning Platform'

    def ready(self):
        try:
            import courses.signals
        except Exception:
            pass
PY

# admin.py
cat > $BASE/admin.py << 'PY'
from django.contrib import admin

from .models import (
    Category,
    Course,
    Module,
    Lesson,
    Enrollment,
    LessonProgress,
    Review
)

admin.site.register(Category)
admin.site.register(Course)
admin.site.register(Module)
admin.site.register(Lesson)
admin.site.register(Enrollment)
admin.site.register(LessonProgress)
admin.site.register(Review)
PY

# models.py
cat > $BASE/models.py << 'PY'
from django.db import models
from django.contrib.auth import get_user_model
from django.utils.text import slugify

User = get_user_model()


class Category(models.Model):

    name = models.CharField(max_length=255)

    slug = models.SlugField(unique=True)

    description = models.TextField(blank=True)

    created_at = models.DateTimeField(auto_now_add=True)

    def save(self, *args, **kwargs):

        if not self.slug:
            self.slug = slugify(self.name)

        super().save(*args, **kwargs)

    def __str__(self):
        return self.name


class Course(models.Model):

    instructor = models.ForeignKey(
        User,
        on_delete=models.CASCADE
    )

    category = models.ForeignKey(
        Category,
        on_delete=models.SET_NULL,
        null=True
    )

    title = models.CharField(max_length=255)

    slug = models.SlugField(unique=True)

    description = models.TextField()

    thumbnail = models.ImageField(
        upload_to='courses/',
        blank=True,
        null=True
    )

    price = models.DecimalField(
        max_digits=10,
        decimal_places=2,
        default=0
    )

    level = models.CharField(
        max_length=50,
        default='Beginner'
    )

    is_published = models.BooleanField(default=False)

    created_at = models.DateTimeField(auto_now_add=True)

    def save(self, *args, **kwargs):

        if not self.slug:
            self.slug = slugify(self.title)

        super().save(*args, **kwargs)

    def __str__(self):
        return self.title


class Module(models.Model):

    course = models.ForeignKey(
        Course,
        on_delete=models.CASCADE,
        related_name='modules'
    )

    title = models.CharField(max_length=255)

    order = models.IntegerField(default=0)

    def __str__(self):
        return self.title


class Lesson(models.Model):

    module = models.ForeignKey(
        Module,
        on_delete=models.CASCADE,
        related_name='lessons'
    )

    title = models.CharField(max_length=255)

    video_url = models.URLField()

    notes = models.TextField(blank=True)

    duration_minutes = models.IntegerField(default=0)

    order = models.IntegerField(default=0)

    def __str__(self):
        return self.title


class Enrollment(models.Model):

    student = models.ForeignKey(
        User,
        on_delete=models.CASCADE
    )

    course = models.ForeignKey(
        Course,
        on_delete=models.CASCADE
    )

    progress = models.FloatField(default=0)

    completed = models.BooleanField(default=False)

    enrolled_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f'{self.student} - {self.course}'


class LessonProgress(models.Model):

    student = models.ForeignKey(
        User,
        on_delete=models.CASCADE
    )

    lesson = models.ForeignKey(
        Lesson,
        on_delete=models.CASCADE
    )

    watched = models.BooleanField(default=False)

    watched_duration = models.IntegerField(default=0)


class Review(models.Model):

    student = models.ForeignKey(
        User,
        on_delete=models.CASCADE
    )

    course = models.ForeignKey(
        Course,
        on_delete=models.CASCADE
    )

    rating = models.IntegerField(default=5)

    comment = models.TextField()

    created_at = models.DateTimeField(auto_now_add=True)
PY

# serializers.py
cat > $BASE/serializers.py << 'PY'
from rest_framework import serializers

from .models import (
    Category,
    Course,
    Module,
    Lesson,
    Enrollment,
    LessonProgress,
    Review
)


class CategorySerializer(serializers.ModelSerializer):

    class Meta:
        model = Category
        fields = '__all__'


class LessonSerializer(serializers.ModelSerializer):

    class Meta:
        model = Lesson
        fields = '__all__'


class ModuleSerializer(serializers.ModelSerializer):

    lessons = LessonSerializer(
        many=True,
        read_only=True
    )

    class Meta:
        model = Module
        fields = '__all__'


class CourseSerializer(serializers.ModelSerializer):

    modules = ModuleSerializer(
        many=True,
        read_only=True
    )

    class Meta:
        model = Course
        fields = '__all__'


class EnrollmentSerializer(serializers.ModelSerializer):

    class Meta:
        model = Enrollment
        fields = '__all__'


class ReviewSerializer(serializers.ModelSerializer):

    class Meta:
        model = Review
        fields = '__all__'
PY

# services.py
cat > $BASE/services.py << 'PY'
from .models import Enrollment


class CourseService:

    @staticmethod
    def enroll_student(student, course):

        enrollment, created = Enrollment.objects.get_or_create(
            student=student,
            course=course
        )

        return enrollment

    @staticmethod
    def complete_course(enrollment):

        enrollment.completed = True
        enrollment.progress = 100
        enrollment.save()

        return enrollment
PY

# pipeline.py
cat > $BASE/pipeline.py << 'PY'
class LearningPipeline:

    @staticmethod
    def unlock_next_lesson(progress):

        if progress >= 80:
            return True

        return False

    @staticmethod
    def calculate_progress(total_lessons, completed_lessons):

        if total_lessons == 0:
            return 0

        return (completed_lessons / total_lessons) * 100
PY

# views.py
cat > $BASE/views.py << 'PY'
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import (
    IsAuthenticated,
    AllowAny
)

from .models import (
    Course,
    Enrollment,
    Review
)

from .serializers import (
    CourseSerializer,
    EnrollmentSerializer,
    ReviewSerializer
)


class CourseListView(APIView):

    permission_classes = [AllowAny]

    def get(self, request):

        courses = Course.objects.filter(
            is_published=True
        )

        serializer = CourseSerializer(
            courses,
            many=True
        )

        return Response(serializer.data)


class CourseDetailView(APIView):

    permission_classes = [AllowAny]

    def get(self, request, pk):

        course = Course.objects.get(pk=pk)

        serializer = CourseSerializer(course)

        return Response(serializer.data)


class EnrollView(APIView):

    permission_classes = [IsAuthenticated]

    def post(self, request, pk):

        course = Course.objects.get(pk=pk)

        enrollment, created = Enrollment.objects.get_or_create(
            student=request.user,
            course=course
        )

        serializer = EnrollmentSerializer(enrollment)

        return Response(serializer.data)


class ReviewView(APIView):

    permission_classes = [IsAuthenticated]

    def post(self, request, pk):

        course = Course.objects.get(pk=pk)

        review = Review.objects.create(
            student=request.user,
            course=course,
            rating=request.data.get('rating'),
            comment=request.data.get('comment')
        )

        serializer = ReviewSerializer(review)

        return Response(serializer.data)
PY

# urls.py
cat > $BASE/urls.py << 'PY'
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
PY

# tests.py
cat > $BASE/tests.py << 'PY'
from django.test import TestCase
from django.contrib.auth import get_user_model

from .models import (
    Category,
    Course
)

User = get_user_model()


class CourseTestCase(TestCase):

    def setUp(self):

        self.user = User.objects.create_user(
            username='dinesh',
            password='StrongPassword123'
        )

        self.category = Category.objects.create(
            name='Programming'
        )

        self.course = Course.objects.create(
            instructor=self.user,
            category=self.category,
            title='Python Mastery',
            description='Complete Python Course'
        )

    def test_course_created(self):

        self.assertEqual(
            self.course.title,
            'Python Mastery'
        )

    def test_category_created(self):

        self.assertEqual(
            self.category.name,
            'Programming'
        )
PY

chmod +x $BASE/setup_courses.sh

echo "✅ Courses module full source code generated successfully"
