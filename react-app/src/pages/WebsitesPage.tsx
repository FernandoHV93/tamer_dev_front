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
  const [showAddForm, setShowAddForm] = useState(false)
  const { sessionId, userId } = useSession()
  const { showToast } = useToast()

  useEffect(() => {
    load(userId)
  }, [load, userId])

  const selected = useMemo(() => websites.find((w: WebsiteEntity) => w.id === selectedWebsiteId) ?? null, [websites, selectedWebsiteId])

  // Calculate statistics
  const totalWebsites = websites.length
  const activeWebsites = websites.filter((w: WebsiteEntity) => w.status === 'Active').length
  const inactiveWebsites = websites.filter((w: WebsiteEntity) => w.status === 'Inactive').length

  return (
    <div className="app-container">
      {/* Header */}
      <div className="row" style={{ justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: 32 }}>
        <div>
          <h1 style={{ margin: 0, marginBottom: 8 }}>Websites</h1>
          <p style={{ margin: 0, color: 'var(--muted)', fontSize: 16 }}>Manage and organize your websites.</p>
        </div>
        <button 
          className="btn btn-primary" 
          onClick={() => setShowAddForm(true)}
          style={{ padding: '12px 24px', fontSize: 14, fontWeight: 600, boxShadow: '0 4px 6px -1px rgba(37, 99, 235, 0.2)' }}
        >
          + Add Website
        </button>
      </div>

      {error && <div style={{ color: 'red', marginBottom: 16 }}>{error}</div>}

      {/* Statistics Cards */}
      <div className="row" style={{ gap: 16, marginBottom: 32 }}>
        <div className="card" style={{ flex: 1, padding: 20, textAlign: 'center' }}>
          <div style={{ fontSize: 24, marginBottom: 8 }}>🌐</div>
          <div style={{ fontSize: 28, fontWeight: 700, marginBottom: 4 }}>{totalWebsites}</div>
          <div style={{ color: 'var(--muted)', fontSize: 14 }}>Total</div>
        </div>
        <div className="card" style={{ flex: 1, padding: 20, textAlign: 'center' }}>
          <div style={{ fontSize: 24, marginBottom: 8 }}>✅</div>
          <div style={{ fontSize: 28, fontWeight: 700, marginBottom: 4 }}>{activeWebsites}</div>
          <div style={{ color: 'var(--muted)', fontSize: 14 }}>Active</div>
        </div>
        <div className="card" style={{ flex: 1, padding: 20, textAlign: 'center' }}>
          <div style={{ fontSize: 24, marginBottom: 8 }}>⏸️</div>
          <div style={{ fontSize: 28, fontWeight: 700, marginBottom: 4 }}>{inactiveWebsites}</div>
          <div style={{ color: 'var(--muted)', fontSize: 14 }}>Inactive</div>
        </div>
      </div>

      {/* Your Websites Section */}
      <div>
        <h3 style={{ marginBottom: 16 }}>Your Websites</h3>
        
        {websites.length === 0 ? (
          <div className="card" style={{ 
            display: 'grid', 
            gap: 16, 
            alignItems: 'center', 
            justifyItems: 'center', 
            padding: 60,
            textAlign: 'center'
          }}>
            <div style={{ 
              width: 72, 
              height: 72, 
              borderRadius: 18, 
              background: 'var(--panel-contrast)', 
              display: 'grid', 
              placeItems: 'center', 
              border: '1px solid var(--border)',
              fontSize: 32
            }}>🌐</div>
            <div style={{ fontWeight: 700, fontSize: 18 }}>No websites yet</div>
            <div style={{ color: 'var(--muted)' }}>Add your first website to get started</div>
          </div>
        ) : (
          <div className="card">
            {isLoading && <div className="row" style={{ alignItems: 'center', marginBottom: 16 }}><div className="spinner"></div><span>Loading...</span></div>}
            <ul style={{ listStyle: 'none', padding: 0, margin: 0 }}>
              {websites.map((w: WebsiteEntity) => (
                <li key={w.id} style={{ 
                  padding: '16px 0', 
                  borderBottom: '1px solid var(--border)',
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'space-between'
                }}>
                  <div>
                    <div style={{ fontWeight: 600, marginBottom: 4 }}>{w.name}</div>
                    <div style={{ color: 'var(--muted)', fontSize: 14 }}>{w.url}</div>
                  </div>
                  <div className="row" style={{ gap: 8 }}>
                    <span style={{ 
                      padding: '4px 8px', 
                      borderRadius: 6, 
                      fontSize: 12,
                      fontWeight: 500,
                      background: w.status === 'Active' ? '#16a34a' : '#f59e0b',
                      color: w.status === 'Active' ? '#ffffff' : '#111318'
                    }}>
                      {w.status}
                    </span>
                    <button 
                      className="btn btn-secondary" 
                      onClick={() => { setEditId(w.id); setName(w.name); setUrl(w.url); setStatus(w.status); setShowAddForm(true) }}
                      style={{ padding: '6px 12px', fontSize: 12, fontWeight: 500 }}
                    >
                      Edit
                    </button>
                    <button 
                      className="btn btn-danger" 
                      disabled={isLoading} 
                      onClick={async () => { await remove(w.id); showToast('Website deleted', 'success') }}
                      style={{ padding: '6px 12px', fontSize: 12, fontWeight: 500 }}
                    >
                      Delete
                    </button>
                  </div>
                </li>
              ))}
            </ul>
          </div>
        )}
      </div>

      {/* Add/Edit Form Modal */}
      {showAddForm && (
        <div style={{
          position: 'fixed',
          top: 0,
          left: 0,
          right: 0,
          bottom: 0,
          background: 'rgba(0, 0, 0, 0.6)',
          display: 'grid',
          placeItems: 'center',
          zIndex: 1000,
          backdropFilter: 'blur(4px)'
        }}>
          <div className="card" style={{ width: 400, maxWidth: '90vw', boxShadow: '0 20px 25px -5px rgba(0, 0, 0, 0.3)' }}>
            <div className="row" style={{ justifyContent: 'space-between', alignItems: 'center', marginBottom: 24 }}>
              <h3 style={{ margin: 0 }}>{editId ? 'Edit Website' : 'Add Website'}</h3>
              <button 
                className="btn" 
                onClick={() => { 
                  setShowAddForm(false); 
                  setEditId(null); 
                  setName(''); 
                  setUrl(''); 
                  setStatus('Active') 
                }}
                style={{ padding: '8px', fontSize: 18 }}
              >
                ×
              </button>
            </div>
            
            <div className="col" style={{ gap: 16 }}>
              <input 
                className="input" 
                placeholder="Website name" 
                value={name} 
                onChange={(e) => setName(e.target.value)} 
              />
              <input 
                className="input" 
                placeholder="URL" 
                value={url} 
                onChange={(e) => setUrl(e.target.value)} 
              />
              <select 
                className="select" 
                value={status} 
                onChange={(e) => setStatus(e.target.value as WebsiteStatus)}
              >
                <option value="Active">Active</option>
                <option value="Inactive">Inactive</option>
              </select>
              
              <div className="row" style={{ gap: 8, marginTop: 8 }}>
                {editId ? (
                  <>
                    <button 
                      className="btn btn-primary"
                      disabled={!name || !url || isLoading}
                      onClick={async () => {
                        await edit(editId!, { name, url, status })
                        showToast('Website updated', 'success')
                        setShowAddForm(false)
                        setEditId(null)
                        setName('')
                        setUrl('')
                        setStatus('Active')
                      }}
                      style={{ flex: 1, fontWeight: 600 }}
                    >
                      Update
                    </button>
                    <button 
                      className="btn btn-secondary" 
                      onClick={() => { 
                        setShowAddForm(false); 
                        setEditId(null); 
                        setName(''); 
                        setUrl(''); 
                        setStatus('Active') 
                      }}
                    >
                      Cancel
                    </button>
                  </>
                ) : (
                  <>
                    <button 
                      className="btn btn-primary"
                      disabled={!name || !url || isLoading}
                      onClick={async () => {
                        const website: Omit<WebsiteEntity, 'id'> = { name, url, status, lastChecked: new Date().toISOString() }
                        await add(sessionId, userId, website)
                        showToast('Website added', 'success')
                        setShowAddForm(false)
                        setName('')
                        setUrl('')
                        setStatus('Active')
                      }}
                      style={{ flex: 1, fontWeight: 600 }}
                    >
                      Add Website
                    </button>
                    <button 
                      className="btn btn-secondary" 
                      onClick={() => { 
                        setShowAddForm(false); 
                        setEditId(null); 
                        setName(''); 
                        setUrl(''); 
                        setStatus('Active') 
                      }}
                    >
                      Cancel
                    </button>
                  </>
                )}
              </div>
            </div>
          </div>
        </div>
      )}
    </div>
  )
}


