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
