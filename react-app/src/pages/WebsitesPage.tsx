import { useEffect, useMemo, useState } from 'react'
import { useWebsites } from '../store/websites'
import type { WebsiteEntity, WebsiteStatus } from '../types/website'
import { useSession } from '../context/SessionContext'
import { useToast } from '../context/ToastContext'

export default function WebsitesPage() {
  const { websites, isLoading, error, load, add, select, selectedWebsiteId, edit, remove } = useWebsites() as any
  const [name, setName] = useState('')
  const [url, setUrl] = useState('')
  const [status, setStatus] = useState<WebsiteStatus>('Active')
  const [editId, setEditId] = useState<string | null>(null)
  const { sessionId, userId } = useSession()
  const { showToast } = useToast()

  useEffect(() => {
    load(userId)
  }, [load, userId])

  const selected = useMemo(() => websites.find((w: WebsiteEntity) => w.id === selectedWebsiteId) ?? null, [websites, selectedWebsiteId])

  return (
    <div className="app-container">
      <h1>Websites</h1>
      {error && <div style={{ color: 'red' }}>{error}</div>}
      <div style={{ display: 'flex', gap: 24 }}>
        <div style={{ flex: 1 }}>
          <h3>Listado</h3>
          {isLoading && <div>Cargando...</div>}
          <ul className="card">
            {websites.map((w: WebsiteEntity) => (
              <li key={w.id}>
                <button onClick={() => select(w.id)} style={{ marginRight: 8 }}>
                  Seleccionar
                </button>
                <strong>{w.name}</strong> — {w.url} — {w.status}
                <button style={{ marginLeft: 8 }} onClick={() => { setEditId(w.id); setName(w.name); setUrl(w.url); setStatus(w.status) }}>Editar</button>
                <button style={{ marginLeft: 8 }} disabled={isLoading} onClick={async () => { await remove(w.id); showToast('Website deleted', 'success') }}>Eliminar</button>
              </li>
            ))}
          </ul>
        </div>
        <div style={{ width: 360 }}>
          <h3 className="section-title">{editId ? 'Editar sitio' : 'Añadir sitio'}</h3>
          <div className="col card">
            <input className="input" placeholder="Nombre" value={name} onChange={(e) => setName(e.target.value)} />
            <input className="input" placeholder="URL" value={url} onChange={(e) => setUrl(e.target.value)} />
            <select className="select" value={status} onChange={(e) => setStatus(e.target.value as WebsiteStatus)}>
              <option value="Active">Active</option>
              <option value="Inactive">Inactive</option>
            </select>
            {editId ? (
              <>
                <button className="btn btn-success"
                  disabled={!name || !url || isLoading}
                  onClick={async () => {
                    await edit(editId!, { name, url, status })
                    showToast('Website updated', 'success')
                    setEditId(null); setName(''); setUrl(''); setStatus('Active')
                  }}
                >
                  Actualizar
                </button>
                <button className="btn" style={{ marginLeft: 8 }} onClick={() => { setEditId(null); setName(''); setUrl(''); setStatus('Active') }}>Cancelar</button>
              </>
            ) : (
              <button className="btn btn-primary"
                disabled={!name || !url || isLoading}
                onClick={async () => {
                  const website: Omit<WebsiteEntity, 'id'> = { name, url, status, lastChecked: new Date().toISOString() }
                  await add(sessionId, userId, website)
                  showToast('Website added', 'success')
                  setName('')
                  setUrl('')
                  setStatus('Active')
                }}
              >
                Guardar
              </button>
            )}
          </div>
          <div style={{ marginTop: 24 }}>
            <h4>Seleccionado</h4>
            {selected ? (
              <pre style={{ background: '#111', color: 'white', padding: 12, borderRadius: 8 }}>
                {JSON.stringify(selected, null, 2)}
              </pre>
            ) : (
              <div>Ninguno</div>
            )}
          </div>
        </div>
      </div>
    </div>
  )
}


