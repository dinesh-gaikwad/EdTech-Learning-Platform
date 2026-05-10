function Navbar() {

  return (

    <header
      style={{

        width: '100%',

        padding: '24px 60px',

        background:
          'rgba(2,6,23,0.9)',

        backdropFilter: 'blur(20px)',

        position: 'sticky',

        top: 0,

        zIndex: 999,

        display: 'flex',

        justifyContent: 'space-between',

        alignItems: 'center',

        borderBottom:
          '1px solid rgba(255,255,255,0.05)'
      }}
    >

      <h1
        style={{
          color: 'white'
        }}
      >
        EdTech Platform
      </h1>

      <nav
        style={{

          display: 'flex',

          gap: '30px',

          color: '#cbd5e1'
        }}
      >

        <span>Home</span>

        <span>Courses</span>

        <span>Dashboard</span>

        <span>Community</span>

      </nav>

      <button
        style={{

          padding: '12px 24px',

          borderRadius: '12px',

          border: 'none',

          background:
            'linear-gradient(135deg,#2563eb,#7c3aed)',

          color: 'white',

          cursor: 'pointer'
        }}
      >
        Login
      </button>

    </header>
  )
}

export default Navbar
