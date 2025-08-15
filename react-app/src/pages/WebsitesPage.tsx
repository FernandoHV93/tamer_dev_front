import { useEffect, useMemo, useState } from 'react'
import { useWebsites } from '../store/websites'
import type { WebsiteEntity, WebsiteStatus } from '../types/website'

export default function WebsitesPage() {
  const { websites, isLoading, error, load, add, select, selectedWebsiteId } = useWebsites()
  const [name, setName] = useState('')
  const [url, setUrl] = useState('')
  const [status, setStatus] = useState<WebsiteStatus>('Active')

  useEffect(() => {
    // TODO: session/user from context when available
    const userId = 'Mayo8.com'
    load(userId)
  }, [load])

  const selected = useMemo(() => websites.find(w => w.id === selectedWebsiteId) ?? null, [websites, selectedWebsiteId])

  return (
    <div style={{ padding: 24 }}>
      <h1>Websites</h1>
      {error && <div style={{ color: 'red' }}>{error}</div>}
      <div style={{ display: 'flex', gap: 24 }}>
        <div style={{ flex: 1 }}>
          <h3>Listado</h3>
          {isLoading && <div>Cargando...</div>}
          <ul>
            {websites.map((w) => (
              <li key={w.id}>
                <button onClick={() => select(w.id)} style={{ marginRight: 8 }}>
                  Seleccionar
                </button>
                <strong>{w.name}</strong> — {w.url} — {w.status}
              </li>
            ))}
          </ul>
        </div>
        <div style={{ width: 360 }}>
          <h3>Añadir sitio</h3>
          <div style={{ display: 'grid', gap: 12 }}>
            <input placeholder="Nombre" value={name} onChange={(e) => setName(e.target.value)} />
            <input placeholder="URL" value={url} onChange={(e) => setUrl(e.target.value)} />
            <select value={status} onChange={(e) => setStatus(e.target.value as WebsiteStatus)}>
              <option value="Active">Active</option>
              <option value="Inactive">Inactive</option>
            </select>
            <button
              disabled={!name || !url || isLoading}
              onClick={async () => {
                const sessionId = 'Mayo8.com'
                const userId = 'Mayo8.com'
                const website: Omit<WebsiteEntity, 'id'> = { name, url, status, lastChecked: new Date().toISOString() }
                await add(sessionId, userId, website)
                setName('')
                setUrl('')
                setStatus('Active')
              }}
            >
              Guardar
            </button>
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


