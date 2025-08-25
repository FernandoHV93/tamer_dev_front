import { useEffect, useState } from 'react'
import * as api from '../services/apiSettings'
import { useToast } from '../context/ToastContext'

export default function ApiSettingsPage() {
  const { showToast } = useToast()
  const [status, setStatus] = useState<any>(null)
  const [provider, setProvider] = useState('openai')
  const [apiKey, setApiKey] = useState('')

  async function load() {
    try {
      const s = await api.providersStatus()
      setStatus(s)
    } catch (e: any) {
      showToast(e?.message ?? String(e), 'error')
    }
  }

  useEffect(() => { load() }, [])

  return (
    <div className="app-container">
      <h1>API Settings</h1>
      <div className="card" style={{ display: 'grid', gap: 12, maxWidth: 560 }}>
        <div className="row">
          <input className="input" placeholder="Provider (e.g., openai)" value={provider} onChange={(e) => setProvider(e.target.value)} />
          <input className="input" placeholder="API Key" value={apiKey} onChange={(e) => setApiKey(e.target.value)} />
        </div>
        <div className="row">
          <button className="btn btn-primary" onClick={async () => { await api.connectProvider(provider, { apiKey }); showToast('Provider connected', 'success'); load() }}>Connect</button>
          <button className="btn" onClick={async () => { await api.disconnectProvider(provider); showToast('Provider disconnected', 'success'); load() }}>Disconnect</button>
        </div>
      </div>
      <h3 className="section-title" style={{ marginTop: 16 }}>Status</h3>
      <pre className="card" style={{ overflow: 'auto' }}>{status ? JSON.stringify(status, null, 2) : 'Loading...'}</pre>
    </div>
  )
}


