import { motion } from 'framer-motion'

function Card({

  title,

  description,

  children
}) {

  return (

    <motion.div

      whileHover={{
        y: -8,
        scale: 1.02
      }}

      transition={{
        duration: 0.3
      }}

      style={{

        background:
          'rgba(15,23,42,0.95)',

        border:
          '1px solid rgba(255,255,255,0.05)',

        borderRadius: '24px',

        padding: '30px',

        color: 'white',

        backdropFilter: 'blur(20px)',

        boxShadow:
          '0px 0px 30px rgba(0,0,0,0.2)'
      }}
    >

      {title && (

        <h2
          style={{

            marginBottom: '15px',

            color: '#60a5fa'
          }}
        >
          {title}
        </h2>
      )}

      {description && (

        <p
          style={{

            color: '#cbd5e1',

            lineHeight: '28px',

            marginBottom: '20px'
          }}
        >
          {description}
        </p>
      )}

      {children}

    </motion.div>
  )
}

export default Card
