function Sidebar() {

  const items = [

    'Dashboard',

    'Courses',

    'Certificates',

    'Analytics',

    'Community',

    'Settings'
  ]

  return (

    <aside
      style={{

        width: '280px',

        height: '100vh',

        background: '#020617',

        color: 'white',

        padding: '40px',

        position: 'fixed',

        left: 0,

        top: 0,

        borderRight:
          '1px solid rgba(255,255,255,0.05)'
      }}
    >

      <h1
        style={{
          marginBottom: '50px'
        }}
      >
        EdTech
      </h1>

      <nav>

        {items.map((item) => (

          <div

            key={item}

            style={{

              padding: '16px',

              marginBottom: '12px',

              borderRadius: '12px',

              cursor: 'pointer',

              transition: '0.3s ease'
            }}
          >
            {item}
          </div>
        ))}

      </nav>

    </aside>
  )
}

export default Sidebar
