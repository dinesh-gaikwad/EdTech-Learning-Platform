import { motion } from 'framer-motion'

function Button({

  text = 'Click',

  onClick,

  type = 'button',

  variant = 'primary',

  fullWidth = false
}) {

  const getBackground = () => {

    if (variant === 'secondary') {

      return 'transparent'
    }

    return 'linear-gradient(135deg,#2563eb,#7c3aed)'
  }

  const getBorder = () => {

    if (variant === 'secondary') {

      return '1px solid #334155'
    }

    return 'none'
  }

  return (

    <motion.button

      whileHover={{
        scale: 1.05
      }}

      whileTap={{
        scale: 0.95
      }}

      type={type}

      onClick={onClick}

      style={{

        width:
          fullWidth ? '100%' : 'auto',

        padding: '14px 28px',

        borderRadius: '14px',

        border: getBorder(),

        background: getBackground(),

        color: 'white',

        cursor: 'pointer',

        fontWeight: '600',

        fontSize: '16px',

        transition: '0.3s ease'
      }}
    >
      {text}
    </motion.button>
  )
}

export default Button
