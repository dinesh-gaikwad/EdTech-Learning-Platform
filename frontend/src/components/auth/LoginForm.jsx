import { useState } from 'react'

import {
  loginUser
} from '../../api/authApi'

function LoginForm() {

  const [credentials, setCredentials] = useState({

    email: '',

    password: ''
  })

  const handleChange = (e) => {

    setCredentials({

      ...credentials,

      [e.target.name]: e.target.value
    })
  }

  const handleSubmit = async (e) => {

    e.preventDefault()

    try {

      await loginUser(credentials)

      alert('Login successful')

    } catch (error) {

      alert('Invalid credentials')
    }
  }

  return (

    <form

      onSubmit={handleSubmit}

      style={{

        maxWidth: '500px',

        margin: '50px auto',

        background: '#0f172a',

        padding: '40px',

        borderRadius: '20px'
      }}
    >

      <h1
        style={{
          marginBottom: '30px',
          color: 'white'
        }}
      >
        Login
      </h1>

      <input

        type="email"

        name="email"

        placeholder="Email"

        onChange={handleChange}

        style={inputStyle}
      />

      <input

        type="password"

        name="password"

        placeholder="Password"

        onChange={handleChange}

        style={inputStyle}
      />

      <button

        type="submit"

        style={buttonStyle}
      >
        Login
      </button>

    </form>
  )
}

const inputStyle = {

  width: '100%',

  padding: '14px',

  marginBottom: '20px',

  borderRadius: '10px',

  border: 'none'
}

const buttonStyle = {

  width: '100%',

  padding: '14px',

  border: 'none',

  borderRadius: '10px',

  background: '#2563eb',

  color: 'white',

  cursor: 'pointer'
}

export default LoginForm
