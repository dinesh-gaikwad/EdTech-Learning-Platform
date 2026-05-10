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
