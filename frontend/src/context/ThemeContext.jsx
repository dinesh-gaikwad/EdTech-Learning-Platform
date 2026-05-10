import {

  createContext,

  useState,

  useEffect

} from 'react'

export const ThemeContext =
  createContext()

export function ThemeProvider({

  children
}) {

  const [theme, setTheme] =
    useState('dark')

  useEffect(() => {

    document.body.style.background =
      theme === 'dark'
        ? '#020617'
        : '#f8fafc'

    document.body.style.color =
      theme === 'dark'
        ? 'white'
        : '#020617'

  }, [theme])

  const toggleTheme = () => {

    setTheme((prev) =>

      prev === 'dark'
        ? 'light'
        : 'dark'
    )
  }

  return (

    <ThemeContext.Provider

      value={{

        theme,

        toggleTheme
      }}
    >

      {children}

    </ThemeContext.Provider>
  )
}
