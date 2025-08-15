import { useEffect, useState } from 'react'
import * as api from '../services/roadmap'
import { useToast } from '../context/ToastContext'

export default function RoadmapPage() {
  const { showToast } = useToast()
  const [data, setData] = useState<any>(null)
  const [json, setJson] = useState('{"items": []}')

  async function load() {
    try {
      const r = await api.getRoadmap()
      setData(r)
    } catch (e: any) {
      showToast(e?.message ?? String(e), 'error')
    }
  }

  useEffect(() => { load() }, [])

  return (
    <div className="app-container">
      <h1>Roadmap</h1>
      <div className="row" style={{ alignItems: 'stretch' }}>
        <textarea className="textarea" style={{ width: 440 }} value={json} onChange={(e) => setJson(e.target.value)} />
        <div className="col" style={{ flex: 1 }}>
          <button className="btn btn-primary" onClick={async () => { try { const payload = JSON.parse(json); await api.saveRoadmap(payload); showToast('Roadmap saved', 'success'); load() } catch (e: any) { showToast(e?.message ?? String(e), 'error') } }}>Save</button>
          <pre className="card" style={{ overflow: 'auto' }}>{data ? JSON.stringify(data, null, 2) : 'Loading...'}</pre>
        </div>
      </div>
    </div>
  )
}


