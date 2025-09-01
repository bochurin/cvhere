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
      console.log('Checking health at:', config.backendUrl)
      try {
        const controller = new AbortController()
        const timeoutId = setTimeout(() => controller.abort(), 3000) // 3 second timeout
        
        const response = await fetch(`${config.backendUrl}/health`, {
          signal: controller.signal
        })
        clearTimeout(timeoutId)
        
        if (!response.ok) {
          throw new Error(`HTTP ${response.status}`);
        }
        const data = await response.json()
        console.log('Health check success:', data)
        setHealth(data)
        setConnected(true)
        // Update browser tab title with environment
        document.title = `CVHere (env: ${data.environment})`
      } catch (error) {
        console.log('Health check failed:', error)
        setHealth(null)
        setConnected(false)
        document.title = 'CVHere (env: disconnected)'
      }
    }

    checkHealth()
    const interval = setInterval(checkHealth, 5000)
    return () => clearInterval(interval)
  }, [config])

  return (
    <div style={{ padding: '20px', fontFamily: 'Arial, sans-serif' }}>
      <h1>CVHere (env: {health?.environment || 'Unknown'})</h1>
      
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