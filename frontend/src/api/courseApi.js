import axios from 'axios'

const BASE_URL = 'http://localhost:8000/api/courses'

const api = axios.create({

  baseURL: BASE_URL,

  headers: {

    'Content-Type': 'application/json'
  }
})

api.interceptors.request.use(

  (config) => {

    const token = localStorage.getItem('access_token')

    if (token) {

      config.headers.Authorization = `Bearer ${token}`
    }

    return config
  },

  (error) => {

    return Promise.reject(error)
  }
)

export const getAllCourses = async () => {

  try {

    const response = await api.get('/')

    return response.data

  } catch (error) {

    console.error(
      'Get courses error:',
      error
    )

    throw error
  }
}

export const getCourseById = async (
  courseId
) => {

  try {

    const response = await api.get(
      `/${courseId}/`
    )

    return response.data

  } catch (error) {

    console.error(
      'Get course error:',
      error
    )

    throw error
  }
}

export const createCourse = async (
  courseData
) => {

  try {

    const response = await api.post(
      '/create/',
      courseData
    )

    return response.data

  } catch (error) {

    console.error(
      'Create course error:',
      error
    )

    throw error
  }
}

export const updateCourse = async (
  courseId,
  courseData
) => {

  try {

    const response = await api.put(
      `/${courseId}/update/`,
      courseData
    )

    return response.data

  } catch (error) {

    console.error(
      'Update course error:',
      error
    )

    throw error
  }
}

export const deleteCourse = async (
  courseId
) => {

  try {

    const response = await api.delete(
      `/${courseId}/delete/`
    )

    return response.data

  } catch (error) {

    console.error(
      'Delete course error:',
      error
    )

    throw error
  }
}

export const enrollCourse = async (
  courseId
) => {

  try {

    const response = await api.post(
      `/${courseId}/enroll/`
    )

    return response.data

  } catch (error) {

    console.error(
      'Enroll error:',
      error
    )

    throw error
  }
}

export const getEnrolledCourses = async () => {

  try {

    const response = await api.get(
      '/enrolled/'
    )

    return response.data

  } catch (error) {

    console.error(
      'Enrolled courses error:',
      error
    )

    throw error
  }
}

export default api
