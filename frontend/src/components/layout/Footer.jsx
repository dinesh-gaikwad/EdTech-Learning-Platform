function Footer() {

  return (

    <footer
      style={{

        background: '#020617',

        color: 'white',

        padding: '80px 60px',

        marginTop: '80px',

        borderTop:
          '1px solid rgba(255,255,255,0.05)'
      }}
    >

      <div
        style={{

          display: 'grid',

          gridTemplateColumns:
            'repeat(auto-fit,minmax(250px,1fr))',

          gap: '40px'
        }}
      >

        <div>

          <h2
            style={{
              marginBottom: '20px'
            }}
          >
            EdTech Platform
          </h2>

          <p
            style={{
              color: '#94a3b8',
              lineHeight: '30px'
            }}
          >
            Microsoft-level AI learning platform
            powered by React, Django, Docker,
            Redis, Celery, and Three.js.
          </p>

        </div>

        <div>

          <h3
            style={{
              marginBottom: '20px'
            }}
          >
            Platform
          </h3>

          <p>Courses</p>

          <p>Community</p>

          <p>Certificates</p>

          <p>Analytics</p>

        </div>

        <div>

          <h3
            style={{
              marginBottom: '20px'
            }}
          >
            Company
          </h3>

          <p>About</p>

          <p>Careers</p>

          <p>Contact</p>

          <p>Support</p>

        </div>

        <div>

          <h3
            style={{
              marginBottom: '20px'
            }}
          >
            Legal
          </h3>

          <p>Privacy Policy</p>

          <p>Terms of Service</p>

          <p>Cookies</p>

        </div>

      </div>

      <div
        style={{

          marginTop: '60px',

          textAlign: 'center',

          color: '#64748b'
        }}
      >

        © 2026 Microsoft-Level EdTech Platform.
        Built by Dinesh Gaikwad.

      </div>

    </footer>
  )
}

export default Footer
