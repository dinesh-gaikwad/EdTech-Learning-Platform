#!/bin/bash

set -e

BASE="/workspaces/EdTech-Learning-Platform/backend/apps/payments"

mkdir -p $BASE/migrations

touch $BASE/migrations/__init__.py

# __init__.py
cat > $BASE/__init__.py << 'PY'
default_app_config = 'payments.apps.PaymentsConfig'
PY

# apps.py
cat > $BASE/apps.py << 'PY'
from django.apps import AppConfig


class PaymentsConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'payments'
    verbose_name = 'Payments & Billing'
PY

# admin.py
cat > $BASE/admin.py << 'PY'
from django.contrib import admin

from .models import (
    Payment,
    Subscription,
    Transaction
)

admin.site.register(Payment)
admin.site.register(Subscription)
admin.site.register(Transaction)
PY

# models.py
cat > $BASE/models.py << 'PY'
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
PY

# serializers.py
cat > $BASE/serializers.py << 'PY'
from rest_framework import serializers

from .models import (
    Payment,
    Subscription,
    Transaction
)


class PaymentSerializer(serializers.ModelSerializer):

    class Meta:
        model = Payment
        fields = '__all__'


class SubscriptionSerializer(serializers.ModelSerializer):

    class Meta:
        model = Subscription
        fields = '__all__'


class TransactionSerializer(serializers.ModelSerializer):

    class Meta:
        model = Transaction
        fields = '__all__'
PY

# stripe_service.py
cat > $BASE/stripe_service.py << 'PY'
class StripeService:

    @staticmethod
    def create_payment_intent(
        amount,
        currency='usd'
    ):

        return {
            'client_secret': 'demo_secret_key',
            'amount': amount,
            'currency': currency
        }

    @staticmethod
    def verify_payment(payment_id):

        return True
PY

# webhooks.py
cat > $BASE/webhooks.py << 'PY'
from .models import Transaction


def handle_payment_success(
    payment,
    response
):

    transaction = Transaction.objects.create(
        payment=payment,
        gateway_response=response,
        success=True
    )

    payment.status = 'completed'
    payment.save()

    return transaction
PY

# views.py
cat > $BASE/views.py << 'PY'
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import (
    IsAuthenticated
)

from .models import (
    Payment,
    Subscription
)

from .serializers import (
    PaymentSerializer,
    SubscriptionSerializer
)

from .stripe_service import StripeService


class PaymentListView(APIView):

    permission_classes = [IsAuthenticated]

    def get(self, request):

        payments = Payment.objects.filter(
            student=request.user
        )

        serializer = PaymentSerializer(
            payments,
            many=True
        )

        return Response(serializer.data)


class CreatePaymentView(APIView):

    permission_classes = [IsAuthenticated]

    def post(self, request):

        course_name = request.data.get(
            'course_name'
        )

        amount = request.data.get(
            'amount'
        )

        payment = Payment.objects.create(
            student=request.user,
            course_name=course_name,
            amount=amount
        )

        intent = StripeService.create_payment_intent(
            amount
        )

        serializer = PaymentSerializer(payment)

        return Response({
            'payment': serializer.data,
            'intent': intent
        })


class SubscriptionView(APIView):

    permission_classes = [IsAuthenticated]

    def get(self, request):

        subscriptions = Subscription.objects.filter(
            user=request.user
        )

        serializer = SubscriptionSerializer(
            subscriptions,
            many=True
        )

        return Response(serializer.data)
PY

# urls.py
cat > $BASE/urls.py << 'PY'
from django.urls import path

from .views import (
    PaymentListView,
    CreatePaymentView,
    SubscriptionView
)

urlpatterns = [

    path(
        '',
        PaymentListView.as_view(),
        name='payment-list'
    ),

    path(
        'create/',
        CreatePaymentView.as_view(),
        name='payment-create'
    ),

    path(
        'subscriptions/',
        SubscriptionView.as_view(),
        name='subscriptions'
    ),
]
PY

# tests.py
cat > $BASE/tests.py << 'PY'
from django.test import TestCase
from django.contrib.auth import get_user_model

from .models import Payment

User = get_user_model()


class PaymentTestCase(TestCase):

    def setUp(self):

        self.user = User.objects.create_user(
            username='dinesh',
            password='StrongPassword123'
        )

        self.payment = Payment.objects.create(
            student=self.user,
            course_name='Python Mastery',
            amount=499
        )

    def test_payment_created(self):

        self.assertEqual(
            self.payment.course_name,
            'Python Mastery'
        )

    def test_payment_status(self):

        self.assertEqual(
            self.payment.status,
            'pending'
        )
PY

chmod +x $BASE/setup_payments.sh

echo "✅ Payments module generated successfully"
