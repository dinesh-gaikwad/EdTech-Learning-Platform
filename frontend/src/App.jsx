import { Canvas } from '@react-three/fiber';
import { OrbitControls, Text, Box, Sphere } from '@react-three/drei';
export default function App(){
  return(<div style={{width:'100vw',height:'100vh',background:'#0f172a'}}>
    <Canvas camera={{position:[0,5,12]}}>
      <ambientLight intensity={0.5}/><pointLight position={[10,10,10]}/>
      <Box position={[0,0,0]} args={[3,3,3]}><meshStandardMaterial color="#667eea"/></Box>
      <Sphere position={[0,3,4]} args={[0.8,32,32]}><meshStandardMaterial color="#fbbf24"/></Sphere>
      <Text position={[0,4.5,4]} fontSize={0.6} color="#fbbf24">AI Mentor</Text>
      <OrbitControls/>
    </Canvas>
  </div>)
}
