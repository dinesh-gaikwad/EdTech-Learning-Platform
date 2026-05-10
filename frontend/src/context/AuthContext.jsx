import {

  createContext,

  useState

} from 'react'

import {

  loginUser,

  logoutUser,

  getCurrentUser

} from '../api/authApi'

export const AuthContext =
  createContext()

export function AuthProvider({

  children
}) {

  const [user, setUser] =
    useState(null)

  const [loading, setLoading] =
    useState(false)

  const login = async (
    credentials
  ) => {

    try {

      setLoading(true)

      await loginUser(
        credentials
      )

      await loadUser()

    } catch (error) {

      console.error(
        'Login failed:',
        error
      )

      throw error

    } finally {

      setLoading(false)
    }
  }

  const logout = () => {

    logoutUser()

    setUser(null)
  }

  const loadUser = async () => {

    try {

      const userData =
        await getCurrentUser()

      setUser(userData)

    } catch (error) {

      console.error(
        'Load user failed:',
        error
      )
    }
  }

  return (

    <AuthContext.Provider

      value={{

        user,

        loading,

        login,

        logout,

        loadUser
      }}
    >

      {children}

    </AuthContext.Provider>
  )
}
