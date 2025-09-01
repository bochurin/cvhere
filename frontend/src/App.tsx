import { useState, useEffect } from 'react'
import yaml from 'js-yaml'

interface HealthStatus {
  status: string
  timestamp: string
  environment: string
}

interface Config {
  backendUrl: string
}

function App() {
  const [health, setHealth] = useState<HealthStatus | null>(null)
  const [connected, setConnected] = useState(false)
  const [config, setConfig] = useState<Config | null>(null)

  useEffect(() => {
    // Load environment-specific config
    const loadConfig = async () => {
      try {
        // Load config (pipeline determines which config is deployed)
        const configUrl = '/config.yaml'
        
        const response = await fetch(configUrl)
        const yamlText = await response.text()
        const configData = yaml.load(yamlText) as Config
        setConfig(configData)
      } catch (error) {
        console.error('Failed to load config:', error)
        // Fallback to default
        setConfig({ backendUrl: 'http://localhost:3001' })
      }
    }
    
    loadConfig()
  }, [])

  useEffect(() => {
    if (!config) return

    const checkHealth = async () => {
      try {
        const response = await fetch(`${config.backendUrl}/health`)
        const data = await response.json()
        setHealth(data)
        setConnected(true)
        // Update browser tab title with environment
        document.title = `CVHere - ${data.environment}`
      } catch (error) {
        setConnected(false)
        document.title = 'CVHere - disconnected'
      }
    }

    checkHealth()
    const interval = setInterval(checkHealth, 5000)
    return () => clearInterval(interval)
  }, [config])

  return (
    <div style={{ padding: '20px', fontFamily: 'Arial, sans-serif' }}>
      <h1>CVHere - {health?.environment || 'Unknown'}</h1>
      
      <div style={{ 
        padding: '10px', 
        backgroundColor: connected ? '#d4edda' : '#f8d7da',
        border: `1px solid ${connected ? '#c3e6cb' : '#f5c6cb'}`,
        borderRadius: '4px',
        marginBottom: '20px'
      }}>
        <strong>Backend Status:</strong> {connected ? 'Connected' : 'Disconnected'}
      </div>

      {health && (
        <div>
          <h3>Health Check</h3>
          <p><strong>Status:</strong> {health.status}</p>
          <p><strong>Environment:</strong> {health.environment}</p>
          <p><strong>Last Check:</strong> {new Date(health.timestamp).toLocaleString()}</p>
        </div>
      )}
    </div>
  )
}

export default App