import { motion } from 'framer-motion'

function Loader({

  text = 'Loading Platform...'
}) {

  return (

    <div
      style={{

        height: '100vh',

        display: 'flex',

        justifyContent: 'center',

        alignItems: 'center',

        flexDirection: 'column',

        background: '#020617',

        color: 'white',

        gap: '25px'
      }}
    >

      <motion.div

        animate={{
          rotate: 360
        }}

        transition={{
          repeat: Infinity,
          duration: 1,
          ease: 'linear'
        }}

        style={{

          width: '90px',

          height: '90px',

          border:
            '8px solid rgba(255,255,255,0.1)',

          borderTop:
            '8px solid #2563eb',

          borderRadius: '50%'
        }}
      />

      <h2
        style={{
          fontSize: '28px'
        }}
      >
        {text}
      </h2>

    </div>
  )
}

export default Loader
