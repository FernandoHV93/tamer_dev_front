import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import { BrowserRouter } from 'react-router-dom'
import { SessionProvider } from './context/SessionContext'
import { useEffect } from 'react'
import { setSessionHeaders } from './lib/http'
import './index.css'
import App from './App'

createRoot(document.getElementById('root')!).render(
  <StrictMode>
    <SessionProvider>
      <BrowserRouter>
        <SessionHeadersGate>
          <App />
        </SessionHeadersGate>
      </BrowserRouter>
    </SessionProvider>
  </StrictMode>
)

function SessionHeadersGate({ children }: { children: React.ReactNode }) {
  const stored = typeof localStorage !== 'undefined' ? localStorage.getItem('session') : null
  useEffect(() => {
    try {
      const s = stored ? JSON.parse(stored) : { sessionId: 'Mayo8.com', userId: 'Mayo8.com' }
      setSessionHeaders(s.sessionId, s.userId)
    } catch {}
  }, [stored])
  return children as any
}
