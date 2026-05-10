import { Canvas } from '@react-three/fiber'

import { OrbitControls } from '@react-three/drei'

function FloatingCube() {

  return (

    <mesh rotation={[10, 20, 0]}>

      <boxGeometry args={[2, 2, 2]} />

      <meshStandardMaterial color="#2563eb" />

    </mesh>
  )
}

function HeroScene() {

  return (

    <div
      style={{

        width: '100%',

        height: '600px',

        background:
          'linear-gradient(135deg,#020617,#0f172a)'
      }}
    >

      <Canvas>

        <ambientLight intensity={1.2} />

        <directionalLight
          position={[5, 5, 5]}
        />

        <FloatingCube />

        <OrbitControls />

      </Canvas>

    </div>
  )
}

export default HeroScene
