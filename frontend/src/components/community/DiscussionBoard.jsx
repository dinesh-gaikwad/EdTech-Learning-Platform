import { useState } from 'react'

import { motion } from 'framer-motion'

function DiscussionBoard() {

  const [posts, setPosts] = useState([

    {

      id: 1,

      author: 'Dinesh Gaikwad',

      title: 'How to become Microsoft-level engineer?',

      content:
        'Focus on system design, DSA, cloud, backend scalability, and real-world projects.'
    },

    {

      id: 2,

      author: 'Mentor',

      title: 'Best backend architecture',

      content:
        'Use modular monolithic architecture with scalable service layers.'
    }
  ])

  const [formData, setFormData] = useState({

    title: '',

    content: ''
  })

  const handleChange = (e) => {

    setFormData({

      ...formData,

      [e.target.name]: e.target.value
    })
  }

  const addPost = () => {

    if (
      !formData.title ||
      !formData.content
    ) {
      return
    }

    const newPost = {

      id: Date.now(),

      author: 'Student',

      title: formData.title,

      content: formData.content
    }

    setPosts([
      newPost,
      ...posts
    ])

    setFormData({

      title: '',

      content: ''
    })
  }

  return (

    <div
      style={{

        maxWidth: '1000px',

        margin: '40px auto',

        padding: '20px',

        color: 'white'
      }}
    >

      <motion.h1

        initial={{
          opacity: 0,
          y: -30
        }}

        animate={{
          opacity: 1,
          y: 0
        }}

        style={{

          fontSize: '48px',

          marginBottom: '30px'
        }}
      >
        Community Discussion Board
      </motion.h1>

      <div
        style={{

          background: '#0f172a',

          padding: '30px',

          borderRadius: '20px',

          marginBottom: '40px'
        }}
      >

        <input

          type="text"

          name="title"

          placeholder="Discussion title"

          value={formData.title}

          onChange={handleChange}

          style={inputStyle}
        />

        <textarea

          name="content"

          placeholder="Write your discussion..."

          value={formData.content}

          onChange={handleChange}

          rows="6"

          style={textareaStyle}
        />

        <button

          onClick={addPost}

          style={buttonStyle}
        >
          Post Discussion
        </button>

      </div>

      {posts.map((post) => (

        <motion.div

          key={post.id}

          initial={{
            opacity: 0,
            y: 30
          }}

          animate={{
            opacity: 1,
            y: 0
          }}

          whileHover={{
            scale: 1.02
          }}

          style={{

            background: '#111827',

            padding: '30px',

            borderRadius: '20px',

            marginBottom: '25px',

            border:
              '1px solid rgba(255,255,255,0.05)'
          }}
        >

          <h2
            style={{

              marginBottom: '15px',

              color: '#60a5fa'
            }}
          >
            {post.title}
          </h2>

          <p
            style={{

              color: '#cbd5e1',

              lineHeight: '30px',

              marginBottom: '20px'
            }}
          >
            {post.content}
          </p>

          <small
            style={{
              color: '#94a3b8'
            }}
          >
            Posted by {post.author}
          </small>

        </motion.div>
      ))}

    </div>
  )
}

const inputStyle = {

  width: '100%',

  padding: '16px',

  marginBottom: '20px',

  borderRadius: '12px',

  border: 'none',

  outline: 'none',

  fontSize: '16px'
}

const textareaStyle = {

  width: '100%',

  padding: '16px',

  marginBottom: '20px',

  borderRadius: '12px',

  border: 'none',

  outline: 'none',

  fontSize: '16px',

  resize: 'vertical'
}

const buttonStyle = {

  padding: '14px 30px',

  borderRadius: '12px',

  border: 'none',

  background:
    'linear-gradient(135deg,#2563eb,#7c3aed)',

  color: 'white',

  fontWeight: '600',

  cursor: 'pointer'
}

export default DiscussionBoard
