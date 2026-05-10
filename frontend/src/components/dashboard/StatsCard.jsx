import { motion } from 'framer-motion'

function StatsCard({

  title = 'Students',

  value = '50K+',

  description = 'Active learners worldwide',

  icon = '📈'
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
          'linear-gradient(135deg,#0f172a,#111827)',

        border:
          '1px solid rgba(255,255,255,0.06)',

        borderRadius: '24px',

        padding: '35px',

        color: 'white',

        position: 'relative',

        overflow: 'hidden',

        boxShadow:
          '0px 10px 40px rgba(0,0,0,0.25)'
      }}
    >

      <div
        style={{

          position: 'absolute',

          top: '-30px',

          right: '-30px',

          fontSize: '120px',

          opacity: '0.06'
        }}
      >
        {icon}
      </div>

      <div
        style={{
          fontSize: '42px',
          marginBottom: '15px'
        }}
      >
        {icon}
      </div>

      <h2
        style={{

          fontSize: '42px',

          marginBottom: '10px',

          color: '#60a5fa'
        }}
      >
        {value}
      </h2>

      <h3
        style={{
          marginBottom: '15px'
        }}
      >
        {title}
      </h3>

      <p
        style={{

          color: '#cbd5e1',

          lineHeight: '28px'
        }}
      >
        {description}
      </p>

    </motion.div>
  )
}

export default StatsCard
