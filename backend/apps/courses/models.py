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
