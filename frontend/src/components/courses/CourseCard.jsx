import { motion } from 'framer-motion'

function CourseCard({

  title = 'Full Stack Engineering',

  instructor = 'Dinesh Gaikwad',

  students = '12,500',

  level = 'Advanced',

  thumbnail =
    'https://images.unsplash.com/photo-1516321318423-f06f85e504b3'
}) {

  return (

    <motion.div

      whileHover={{
        y: -10,
        scale: 1.02
      }}

      transition={{
        duration: 0.3
      }}

      style={{

        background: '#0f172a',

        borderRadius: '24px',

        overflow: 'hidden',

        color: 'white',

        boxShadow:
          '0px 12px 40px rgba(0,0,0,0.25)'
      }}
    >

      <img

        src={thumbnail}

        alt={title}

        style={{

          width: '100%',

          height: '240px',

          objectFit: 'cover'
        }}
      />

      <div
        style={{
          padding: '25px'
        }}
      >

        <span
          style={{

            background: '#2563eb',

            padding: '6px 14px',

            borderRadius: '20px',

            fontSize: '14px'
          }}
        >
          {level}
        </span>

        <h2
          style={{
            marginTop: '20px',
            marginBottom: '15px'
          }}
        >
          {title}
        </h2>

        <p
          style={{
            color: '#94a3b8',
            marginBottom: '10px'
          }}
        >
          Instructor: {instructor}
        </p>

        <p
          style={{
            color: '#94a3b8',
            marginBottom: '20px'
          }}
        >
          Students Enrolled: {students}
        </p>

        <button
          style={{

            width: '100%',

            padding: '14px',

            borderRadius: '12px',

            border: 'none',

            background:
              'linear-gradient(135deg,#2563eb,#7c3aed)',

            color: 'white',

            fontWeight: '600',

            cursor: 'pointer'
          }}
        >
          Enroll Now
        </button>

      </div>

    </motion.div>
  )
}

export default CourseCard
