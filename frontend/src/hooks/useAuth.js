import {

  useContext,

  useEffect

} from 'react'

import {

  AuthContext

} from '../context/AuthContext'

function useAuth() {

  const context = useContext(
    AuthContext
  )

  if (!context) {

    throw new Error(
      'useAuth must be used within AuthProvider'
    )
  }

  useEffect(() => {

    const token = localStorage.getItem(
      'access_token'
    )

    if (token && !context.user) {

      context.loadUser()
    }

  }, [])

  return context
}

export default useAuth
