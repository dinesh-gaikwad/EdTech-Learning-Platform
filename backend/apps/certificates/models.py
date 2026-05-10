from django.db import models
from django.contrib.auth import get_user_model
import uuid

User = get_user_model()


class Certificate(models.Model):

    student = models.ForeignKey(
        User,
        on_delete=models.CASCADE
    )

    course_name = models.CharField(max_length=255)

    certificate_id = models.UUIDField(
        default=uuid.uuid4,
        editable=False,
        unique=True
    )

    issued_date = models.DateTimeField(
        auto_now_add=True
    )

    pdf_file = models.FileField(
        upload_to='certificates/',
        blank=True,
        null=True
    )

    is_verified = models.BooleanField(default=True)

    def __str__(self):
        return f'{self.student.username} - {self.course_name}'
