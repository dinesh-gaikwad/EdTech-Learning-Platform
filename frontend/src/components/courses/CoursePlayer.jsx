import { useState } from 'react'

function CoursePlayer() {

  const [currentLesson] = useState({

    title:
      'Microsoft-Level System Design',

    description:
      'Learn scalable backend architecture with realtime systems.',

    video:
      'https://www.youtube.com/embed/dQw4w9WgXcQ'
  })

  return (

    <div
      style={{

        maxWidth: '1200px',

        margin: '50px auto',

        color: 'white'
      }}
    >

      <h1
        style={{
          marginBottom: '30px'
        }}
      >
        Course Player
      </h1>

      <div
        style={{

          background: '#0f172a',

          padding: '30px',

          borderRadius: '24px'
        }}
      >

        <iframe

          width="100%"

          height="600"

          src={currentLesson.video}

          title="Course Video"

          allowFullScreen

          style={{

            border: 'none',

            borderRadius: '18px',

            marginBottom: '30px'
          }}
        />

        <h2
          style={{
            marginBottom: '20px'
          }}
        >
          {currentLesson.title}
        </h2>

        <p
          style={{

            color: '#cbd5e1',

            lineHeight: '32px'
          }}
        >
          {currentLesson.description}
        </p>

      </div>

    </div>
  )
}

export default CoursePlayer
