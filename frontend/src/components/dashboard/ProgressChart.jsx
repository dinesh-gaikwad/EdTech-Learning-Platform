import {

  LineChart,

  Line,

  XAxis,

  YAxis,

  Tooltip,

  CartesianGrid,

  ResponsiveContainer

} from 'recharts'

const data = [

  { month: 'Jan', progress: 20 },

  { month: 'Feb', progress: 35 },

  { month: 'Mar', progress: 50 },

  { month: 'Apr', progress: 70 },

  { month: 'May', progress: 90 }
]

function ProgressChart() {

  return (

    <div
      style={{

        width: '100%',

        height: '420px',

        background: '#0f172a',

        borderRadius: '24px',

        padding: '30px',

        color: 'white'
      }}
    >

      <h2
        style={{
          marginBottom: '25px'
        }}
      >
        Student Progress Analytics
      </h2>

      <ResponsiveContainer
        width="100%"
        height="85%"
      >

        <LineChart data={data}>

          <CartesianGrid strokeDasharray="3 3" />

          <XAxis dataKey="month" />

          <YAxis />

          <Tooltip />

          <Line

            type="monotone"

            dataKey="progress"

            stroke="#2563eb"

            strokeWidth={4}
          />

        </LineChart>

      </ResponsiveContainer>

    </div>
  )
}

export default ProgressChart
