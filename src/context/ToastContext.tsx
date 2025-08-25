// ToastContext.tsx
import { createContext, useContext, useMemo, useState, useCallback } from 'react'
import type { ReactNode } from 'react'

export type ToastType = 'success' | 'error' | 'info'
export type Toast = { id: string; message: string; type: ToastType }

type ToastCtx = {
  toasts: Toast[]
  showToast: (message: string, type?: ToastType, ttlMs?: number) => void
  removeToast: (id: string) => void
}

const Ctx = createContext<ToastCtx | null>(null)

// 👇 variable global para exponer showToast
let globalShowToast: ToastCtx["showToast"] | null = null
export function setToastHandler(handler: ToastCtx["showToast"]) {
  globalShowToast = handler
}
export function toast(message: string, type: ToastType = "info", ttlMs?: number) {
  globalShowToast?.(message, type, ttlMs)
}

export function ToastProvider({ children }: { children: ReactNode }) {
  const [toasts, setToasts] = useState<Toast[]>([])

  const removeToast = useCallback((id: string) => {
    setToasts((t) => t.filter((x) => x.id !== id))
  }, [])

  const showToast = useCallback((message: string, type: ToastType = 'info', ttlMs = 3500) => {
    const id = String(Date.now() + Math.random())
    setToasts((t) => [...t, { id, message, type }])
    window.setTimeout(() => removeToast(id), ttlMs)
  }, [removeToast])

  const value = useMemo<ToastCtx>(() => ({ toasts, showToast, removeToast }), [toasts, showToast, removeToast])

  // 👇 registrar showToast global
  setToastHandler(showToast)

  return (
    <Ctx.Provider value={value}>
      {children}
      <ToastContainer toasts={toasts} onClose={removeToast} />
    </Ctx.Provider>
  )
}

export function useToast() {
  const ctx = useContext(Ctx)
  if (!ctx) throw new Error('useToast must be used within ToastProvider')
  return ctx
}


function ToastContainer({ toasts, onClose }: { toasts: Toast[]; onClose: (id: string) => void }) {
  return (
    <div style={{ position: 'fixed', right: 16, bottom: 16, display: 'grid', gap: 8, zIndex: 9999 }}>
      {toasts.map((t) => (
        <div key={t.id} style={{
          minWidth: 260,
          maxWidth: 360,
          padding: '10px 12px',
          borderRadius: 8,
          color: 'white',
          background: t.type === 'success' ? '#16a34a' : t.type === 'error' ? '#dc2626' : '#2563eb',
          boxShadow: '0 4px 12px rgba(0,0,0,0.25)'
        }}>
          <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', gap: 12 }}>
            <span>{t.message}</span>
            <button onClick={() => onClose(t.id)} style={{ background: 'transparent', border: 'none', color: 'white', cursor: 'pointer' }}>✕</button>
          </div>
        </div>
      ))}
    </div>
  )
}


