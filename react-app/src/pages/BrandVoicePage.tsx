import { useEffect, useState } from 'react'
import { useSession } from '../context/SessionContext'
import { useToast } from '../context/ToastContext'
import * as api from '../services/brandVoice'

export default function BrandVoicePage() {
  const { sessionId, userId } = useSession()
  const { showToast } = useToast()
  const [brands, setBrands] = useState<api.Brand[]>([])
  const [name, setName] = useState('')
  const [loading, setLoading] = useState(false)

  async function load() {
    setLoading(true)
    try {
      const list = await api.listBrands(sessionId, userId)
      setBrands(list)
    } catch (e: any) {
      showToast(e?.message ?? String(e), 'error')
    } finally {
      setLoading(false)
    }
  }

  useEffect(() => { load() }, [])

  return (
    <div className="app-container">
      <h1>Brand Voice</h1>
      <div className="row" style={{ margin: '12px 0' }}>
        <input className="input" placeholder="Brand name" value={name} onChange={(e) => setName(e.target.value)} />
        <button className="btn btn-primary" disabled={!name || loading} onClick={async () => {
          try {
            await api.addBrand(sessionId, userId, { brandName: name })
            setName('')
            showToast('Brand added', 'success')
            load()
          } catch (e: any) {
            showToast(e?.message ?? String(e), 'error')
          }
        }}>Add</button>
        <button className="btn" onClick={load} disabled={loading}>{loading ? '...' : 'Refresh'}</button>
      </div>
      <ul className="card">
        {brands.map((b) => (
          <li key={b.id}>
            {b.brandName}
            <button className="btn" style={{ marginLeft: 8 }} onClick={async () => { await api.deleteBrand(sessionId, userId, b.id); showToast('Brand deleted', 'success'); load() }}>Delete</button>
          </li>
        ))}
      </ul>
    </div>
  )
}


