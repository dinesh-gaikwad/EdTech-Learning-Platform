import axios from 'axios'

const BASE_URL = 'http://localhost:8000/api/accounts'

const authApi = axios.create({

  baseURL: BASE_URL,

  headers: {

    'Content-Type': 'application/json'
  }
})

export const registerUser = async (
  userData
) => {

  try {

    const response = await authApi.post(
      '/register/',
      userData
    )

    return response.data

  } catch (error) {

    console.error(
      'Registration error:',
      error
    )

    throw error
  }
}

export const loginUser = async (
  credentials
) => {

  try {

    const response = await authApi.post(
      '/login/',
      credentials
    )

    if (
      response.data.access
    ) {

      localStorage.setItem(
        'access_token',
        response.data.access
      )

      localStorage.setItem(
        'refresh_token',
        response.data.refresh
      )
    }

    return response.data

  } catch (error) {

    console.error(
      'Login error:',
      error
    )

    throw error
  }
}

export const logoutUser = () => {

  localStorage.removeItem(
    'access_token'
  )

  localStorage.removeItem(
    'refresh_token'
  )
}

export const getCurrentUser = async () => {

  try {

    const token = localStorage.getItem(
      'access_token'
    )

    const response = await authApi.get(
      '/profile/',
      {

        headers: {

          Authorization:
            `Bearer ${token}`
        }
      }
    )

    return response.data

  } catch (error) {

    console.error(
      'Current user error:',
      error
    )

    throw error
  }
}

export const refreshAccessToken = async () => {

  try {

    const refresh = localStorage.getItem(
      'refresh_token'
    )

    const response = await authApi.post(
      '/token/refresh/',
      {

        refresh
      }
    )

    localStorage.setItem(
      'access_token',
      response.data.access
    )

    return response.data.access

  } catch (error) {

    console.error(
      'Refresh token error:',
      error
    )

    logoutUser()

    throw error
  }
}

export default authApi
