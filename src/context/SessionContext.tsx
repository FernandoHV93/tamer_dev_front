import { createContext, useContext, useMemo, useState, useEffect } from 'react'
import type { ReactNode } from 'react'

export type Session = {
  sessionId: string
  userId: string
}

type SessionCtx = Session & {
  setSession: (s: Session) => void
}

const Ctx = createContext<SessionCtx | null>(null)

export function SessionProvider({ children }: { children: ReactNode }) {
  const [session, setSessionState] = useState<Session>(() => {
    const stored = typeof localStorage !== 'undefined' ? localStorage.getItem('session') : null
    if (stored) return JSON.parse(stored)
    return { sessionId: 'Mayo8.com', userId: 'Mayo8.com' }
  })

  useEffect(() => {
    try {
      localStorage.setItem('session', JSON.stringify(session))
    } catch (error) {
      console.error('Error saving session to localStorage:', error)
    }
  }, [session])

  const value = useMemo<SessionCtx>(() => ({
    sessionId: session.sessionId,
    userId: session.userId,
    setSession: (s: Session) => setSessionState(s),
  }), [session])

  return <Ctx.Provider value={value}>{children}</Ctx.Provider>
}

export function useSession() {
  const ctx = useContext(Ctx)
  if (!ctx) throw new Error('useSession must be used within SessionProvider')
  return ctx
}


