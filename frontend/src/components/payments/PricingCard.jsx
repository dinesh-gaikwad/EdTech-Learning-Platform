import { motion } from 'framer-motion'

function PricingCard({

  title = 'Pro Plan',

  price = '$49',

  features = [

    'Unlimited Courses',

    'Realtime Chat',

    'AI Recommendations',

    'Certificates'
  ]
}) {

  return (

    <motion.div

      whileHover={{
        y: -10,
        scale: 1.03
      }}

      style={{

        background: '#0f172a',

        borderRadius: '24px',

        padding: '40px',

        color: 'white',

        boxShadow:
          '0px 10px 40px rgba(0,0,0,0.25)'
      }}
    >

      <h2
        style={{
          fontSize: '36px',
          marginBottom: '20px'
        }}
      >
        {title}
      </h2>

      <h1
        style={{
          fontSize: '64px',
          marginBottom: '30px',
          color: '#60a5fa'
        }}
      >
        {price}
      </h1>

      <div
        style={{
          marginBottom: '30px'
        }}
      >

        {features.map((feature) => (

          <p
            key={feature}

            style={{
              marginBottom: '14px',
              color: '#cbd5e1'
            }}
          >
            ✅ {feature}
          </p>
        ))}

      </div>

      <button
        style={{

          width: '100%',

          padding: '16px',

          borderRadius: '14px',

          border: 'none',

          background:
            'linear-gradient(135deg,#2563eb,#7c3aed)',

          color: 'white',

          fontWeight: '700',

          cursor: 'pointer'
        }}
      >
        Buy Now
      </button>

    </motion.div>
  )
}

export default PricingCard
