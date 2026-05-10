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
