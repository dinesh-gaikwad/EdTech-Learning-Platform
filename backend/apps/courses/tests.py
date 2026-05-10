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
