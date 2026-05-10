from django.db import models
from django.contrib.auth import get_user_model
import uuid

User = get_user_model()


class Payment(models.Model):

    PAYMENT_STATUS = (
        ('pending', 'Pending'),
        ('completed', 'Completed'),
        ('failed', 'Failed'),
    )

    student = models.ForeignKey(
        User,
        on_delete=models.CASCADE
    )

    course_name = models.CharField(max_length=255)

    amount = models.DecimalField(
        max_digits=10,
        decimal_places=2
    )

    payment_id = models.UUIDField(
        default=uuid.uuid4,
        editable=False,
        unique=True
    )

    status = models.CharField(
        max_length=20,
        choices=PAYMENT_STATUS,
        default='pending'
    )

    payment_method = models.CharField(
        max_length=100,
        default='Stripe'
    )

    created_at = models.DateTimeField(
        auto_now_add=True
    )

    def __str__(self):
        return f'{self.student.username} - {self.course_name}'


class Subscription(models.Model):

    PLAN_CHOICES = (
        ('basic', 'Basic'),
        ('pro', 'Pro'),
        ('enterprise', 'Enterprise'),
    )

    user = models.ForeignKey(
        User,
        on_delete=models.CASCADE
    )

    plan = models.CharField(
        max_length=50,
        choices=PLAN_CHOICES,
        default='basic'
    )

    active = models.BooleanField(default=True)

    start_date = models.DateTimeField(
        auto_now_add=True
    )

    expiry_date = models.DateTimeField()

    def __str__(self):
        return f'{self.user.username} - {self.plan}'


class Transaction(models.Model):

    payment = models.ForeignKey(
        Payment,
        on_delete=models.CASCADE
    )

    transaction_id = models.UUIDField(
        default=uuid.uuid4,
        editable=False,
        unique=True
    )

    gateway_response = models.TextField()

    success = models.BooleanField(default=False)

    created_at = models.DateTimeField(
        auto_now_add=True
    )

    def __str__(self):
        return str(self.transaction_id)
