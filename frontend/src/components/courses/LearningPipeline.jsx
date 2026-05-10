import { motion } from 'framer-motion'

const lessons = [

  'Introduction',

  'Frontend Fundamentals',

  'Backend Architecture',

  'Database Design',

  'Docker & DevOps',

  'Cloud Deployment'
]

function LearningPipeline() {

  return (

    <div
      style={{

        maxWidth: '900px',

        margin: '50px auto',

        color: 'white'
      }}
    >

      <h1
        style={{

          fontSize: '48px',

          marginBottom: '40px'
        }}
      >
        Step Locked Learning Pipeline
      </h1>

      {lessons.map((lesson, index) => (

        <motion.div

          key={lesson}

          initial={{
            opacity: 0,
            x: -50
          }}

          animate={{
            opacity: 1,
            x: 0
          }}

          transition={{
            delay: index * 0.2
          }}

          style={{

            display: 'flex',

            alignItems: 'center',

            gap: '20px',

            background: '#111827',

            padding: '24px',

            borderRadius: '18px',

            marginBottom: '20px'
          }}
        >

          <div
            style={{

              width: '50px',

              height: '50px',

              borderRadius: '50%',

              background:
                'linear-gradient(135deg,#2563eb,#7c3aed)',

              display: 'flex',

              justifyContent: 'center',

              alignItems: 'center',

              fontWeight: '700'
            }}
          >
            {index + 1}
          </div>

          <div>

            <h2>{lesson}</h2>

            <p
              style={{
                color: '#94a3b8'
              }}
            >
              Complete this module to unlock next level.
            </p>

          </div>

        </motion.div>
      ))}

    </div>
  )
}

export default LearningPipeline
