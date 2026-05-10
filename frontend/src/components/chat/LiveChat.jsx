import { useState } from 'react'

function LiveChat() {

  const [messages, setMessages] = useState([

    {

      user: 'Mentor',

      text: 'Welcome to realtime classroom!'
    }
  ])

  const [input, setInput] = useState('')

  const sendMessage = () => {

    if (!input.trim()) return

    setMessages([

      ...messages,

      {

        user: 'Student',

        text: input
      }
    ])

    setInput('')
  }

  return (

    <div
      style={{

        width: '100%',

        maxWidth: '700px',

        margin: '50px auto',

        background: '#0f172a',

        borderRadius: '20px',

        padding: '30px',

        color: 'white'
      }}
    >

      <h1
        style={{
          marginBottom: '20px'
        }}
      >
        Live Classroom Chat
      </h1>

      <div
        style={{

          height: '400px',

          overflowY: 'auto',

          background: '#020617',

          padding: '20px',

          borderRadius: '14px'
        }}
      >

        {messages.map((msg, index) => (

          <div
            key={index}

            style={{
              marginBottom: '15px'
            }}
          >

            <strong>
              {msg.user}
            </strong>

            <p>
              {msg.text}
            </p>

          </div>
        ))}

      </div>

      <div
        style={{

          marginTop: '20px',

          display: 'flex',

          gap: '10px'
        }}
      >

        <input

          type="text"

          value={input}

          onChange={(e) =>
            setInput(e.target.value)
          }

          placeholder="Type message..."

          style={{

            flex: 1,

            padding: '14px',

            borderRadius: '10px',

            border: 'none',

            outline: 'none'
          }}
        />

        <button

          onClick={sendMessage}

          style={{

            padding: '14px 24px',

            border: 'none',

            borderRadius: '10px',

            background: '#2563eb',

            color: 'white',

            cursor: 'pointer'
          }}
        >
          Send
        </button>

      </div>

    </div>
  )
}

export default LiveChat
