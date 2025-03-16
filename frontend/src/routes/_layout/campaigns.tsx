import { Container, Heading, Box, Flex } from "@chakra-ui/react"
import { createFileRoute } from "@tanstack/react-router"

const data = [
  { name: "Summer Sale", impressions: 4000, clicks: 2400, conversions: 300 },
  { name: "Holiday Deals", impressions: 3000, clicks: 1398, conversions: 250 },
  { name: "Black Friday", impressions: 2000, clicks: 9800, conversions: 400 },
  { name: "Spring Collection", impressions: 2780, clicks: 3908, conversions: 280 },
  { name: "Cyber Monday", impressions: 1890, clicks: 4800, conversions: 320 },
  { name: "New Year Special", impressions: 2390, clicks: 3800, conversions: 290 },
  { name: "Back to School", impressions: 3490, clicks: 4300, conversions: 310 },
]

const maxValue = 10000
const chartWidth = 600
const chartHeight = 300
const barWidth = 20
const gap = 15

function Campaigns() {
  return (
    <Container maxW="container.xl" py={8}>
      <Heading mb={6} textAlign="center">Campaigns Analytics</Heading>
      
      <Flex direction="column" gap={10} alignItems="center">
        {/* Bar Chart */}
        <Box border="1px solid #e2e8f0" p={6} borderRadius="md" shadow="md" w="full">
          <Heading size="md" mb={4} textAlign="center">Impressions vs Clicks</Heading>
          <svg width={chartWidth} height={chartHeight}>
            <line x1={0} y1={chartHeight} x2={chartWidth} y2={chartHeight} stroke="#aaa" />
            {data.map((d, i) => {
              const x = i * (2 * barWidth + gap) + gap
              const impressionsHeight = (d.impressions / maxValue) * chartHeight
              const clicksHeight = (d.clicks / maxValue) * chartHeight
              return (
                <g key={d.name} transform={`translate(${x}, 0)`}>
                  <rect x={0} y={chartHeight - impressionsHeight} width={barWidth} height={impressionsHeight} fill="#8884d8" />
                  <rect x={barWidth + 5} y={chartHeight - clicksHeight} width={barWidth} height={clicksHeight} fill="#82ca9d" />
                  <text x={(2 * barWidth + 5) / 2} y={chartHeight + 15} textAnchor="middle" fontSize="10">{d.name}</text>
                </g>
              )
            })}
          </svg>
        </Box>

        {/* Pie Chart */}
        <Box border="1px solid #e2e8f0" p={6} borderRadius="md" shadow="md" w="full">
          <Heading size="md" mb={4} textAlign="center">Conversions Share</Heading>
          <svg width={chartWidth} height={chartHeight} viewBox="0 0 200 200">
            {data.map((d, i) => {
              const radius = 80
              const totalConversions = data.reduce((sum, item) => sum + item.conversions, 0)
              const sliceAngle = (d.conversions / totalConversions) * 360
              const offset = data.slice(0, i).reduce((sum, item) => sum + (item.conversions / totalConversions) * 360, 0)
              const x = 100 + radius * Math.cos((offset * Math.PI) / 180)
              const y = 100 + radius * Math.sin((offset * Math.PI) / 180)
              return (
                <g key={d.name}>
                  <path d={`M100,100 L${x},${y} A${radius},${radius} 0 ${sliceAngle > 180 ? 1 : 0},1 100,20 Z`} fill={`hsl(${(i * 60) % 360}, 70%, 50%)`} stroke="#fff" strokeWidth={1} />
                  <text x={x} y={y} fontSize="10" fill="#333">{d.name}</text>
                </g>
              )
            })}
          </svg>
        </Box>

        {/* Line Chart (Click-through rate) */}
        <Box border="1px solid #e2e8f0" p={6} borderRadius="md" shadow="md" w="full">
          <Heading size="md" mb={4} textAlign="center">Click-through Rate Trend</Heading>
          <svg width={chartWidth} height={chartHeight}>
            <polyline
              fill="none"
              stroke="#ff7300"
              strokeWidth="2"
              points={data.map((d, i) => `${i * (chartWidth / data.length)},${chartHeight - (d.clicks / maxValue) * chartHeight}`).join(" ")}
            />
            {data.map((d, i) => (
              <circle
                key={d.name}
                cx={i * (chartWidth / data.length)}
                cy={chartHeight - (d.clicks / maxValue) * chartHeight}
                r={4}
                fill="#ff7300"
              />
            ))}
          </svg>
        </Box>
      </Flex>
    </Container>
  )
}

export const Route = createFileRoute("/_layout/campaigns")({
  component: Campaigns,
})

export { Campaigns }
