import { motion } from 'framer-motion'

function CertificateViewer({

  studentName = 'Dinesh Gaikwad',

  courseName = 'Microsoft-Level Full Stack Engineering',

  issueDate = '10 May 2026'
}) {

  return (

    <motion.div

      initial={{
        opacity: 0,
        scale: 0.8
      }}

      animate={{
        opacity: 1,
        scale: 1
      }}

      transition={{
        duration: 0.8
      }}

      style={{

        minHeight: '100vh',

        display: 'flex',

        justifyContent: 'center',

        alignItems: 'center',

        background:
          'linear-gradient(135deg,#020617,#0f172a)',

        padding: '40px'
      }}
    >

      <div
        style={{

          width: '1000px',

          background: 'white',

          color: '#020617',

          borderRadius: '30px',

          padding: '80px',

          textAlign: 'center',

          position: 'relative',

          overflow: 'hidden',

          boxShadow:
            '0px 0px 60px rgba(37,99,235,0.3)'
        }}
      >

        <div
          style={{

            position: 'absolute',

            inset: '0',

            border:
              '20px solid #2563eb',

            borderRadius: '30px',

            pointerEvents: 'none'
          }}
        />

        <h1
          style={{

            fontSize: '64px',

            marginBottom: '20px',

            fontWeight: '800'
          }}
        >
          Certificate
        </h1>

        <p
          style={{

            fontSize: '24px',

            marginBottom: '60px'
          }}
        >
          This certificate is proudly presented to
        </p>

        <h2
          style={{

            fontSize: '56px',

            color: '#2563eb',

            marginBottom: '40px'
          }}
        >
          {studentName}
        </h2>

        <p
          style={{

            fontSize: '24px',

            lineHeight: '40px',

            maxWidth: '700px',

            margin: '0 auto'
          }}
        >
          For successfully completing the course
          <strong> {courseName} </strong>
          with outstanding performance and
          enterprise-level project implementation.
        </p>

        <div
          style={{

            marginTop: '80px',

            display: 'flex',

            justifyContent: 'space-between',

            alignItems: 'center'
          }}
        >

          <div>

            <h3>Issue Date</h3>

            <p>{issueDate}</p>

          </div>

          <div>

            <h3>Authorized Signature</h3>

            <p>EdTech Platform</p>

          </div>

        </div>

      </div>

    </motion.div>
  )
}

export default CertificateViewer
