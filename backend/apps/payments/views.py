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
