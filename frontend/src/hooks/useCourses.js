import { useEffect, useState } from 'react'

import {

  getAllCourses,

  enrollCourse

} from '../api/courseApi'

function useCourses() {

  const [courses, setCourses] = useState([])

  const [loading, setLoading] = useState(true)

  const [error, setError] = useState(null)

  const fetchCourses = async () => {

    try {

      setLoading(true)

      const data = await getAllCourses()

      setCourses(data)

      setError(null)

    } catch (err) {

      console.error(
        'Fetch courses failed:',
        err
      )

      setError(
        'Unable to fetch courses'
      )

    } finally {

      setLoading(false)
    }
  }

  const handleEnroll = async (
    courseId
  ) => {

    try {

      await enrollCourse(courseId)

      alert(
        'Successfully enrolled'
      )

    } catch (err) {

      console.error(
        'Enrollment failed:',
        err
      )

      alert(
        'Enrollment failed'
      )
    }
  }

  useEffect(() => {

    fetchCourses()

  }, [])

  return {

    courses,

    loading,

    error,

    refetch: fetchCourses,

    enroll: handleEnroll
  }
}

export default useCourses
