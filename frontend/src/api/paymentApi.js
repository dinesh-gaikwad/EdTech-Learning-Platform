import axios from 'axios'

const BASE_URL = 'http://localhost:8000/api/payments'

const paymentApi = axios.create({

  baseURL: BASE_URL,

  headers: {

    'Content-Type': 'application/json'
  }
})

paymentApi.interceptors.request.use(

  (config) => {

    const token = localStorage.getItem(
      'access_token'
    )

    if (token) {

      config.headers.Authorization =
        `Bearer ${token}`
    }

    return config
  },

  (error) => {

    return Promise.reject(error)
  }
)

export const createCheckoutSession = async (
  paymentData
) => {

  try {

    const response = await paymentApi.post(
      '/checkout/',
      paymentData
    )

    return response.data

  } catch (error) {

    console.error(
      'Checkout error:',
      error
    )

    throw error
  }
}

export const verifyPayment = async (
  paymentId
) => {

  try {

    const response = await paymentApi.post(
      '/verify/',
      {

        payment_id: paymentId
      }
    )

    return response.data

  } catch (error) {

    console.error(
      'Verify payment error:',
      error
    )

    throw error
  }
}

export const getPaymentHistory = async () => {

  try {

    const response = await paymentApi.get(
      '/history/'
    )

    return response.data

  } catch (error) {

    console.error(
      'Payment history error:',
      error
    )

    throw error
  }
}

export const cancelSubscription = async (
  subscriptionId
) => {

  try {

    const response = await paymentApi.post(
      '/cancel-subscription/',
      {

        subscription_id:
          subscriptionId
      }
    )

    return response.data

  } catch (error) {

    console.error(
      'Cancel subscription error:',
      error
    )

    throw error
  }
}

export default paymentApi
