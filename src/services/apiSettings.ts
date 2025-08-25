import { http, setSessionHeaders } from '../lib/http'

export async function providersStatus(sessionId: string, userId: string) {
  setSessionHeaders(sessionId, userId)
  const res = await http.get('/api_settings/providers_status', {
    params: {
      session_id: sessionId,
      user_id: userId,
    }
  })
  return res.data
}

export async function connectProvider(sessionId: string, userId: string, apiKey: string, providerName: string) {
  setSessionHeaders(sessionId, userId)
  const res = await http.post('/api_settings/connect_provider', {
    sessionId,
    userID: userId,
    apiKey,
    providerName,
  })
  return res.data
}

export async function disconnectProvider(sessionId: string, userId: string, providerName: string) {
  setSessionHeaders(sessionId, userId)
  const res = await http.post('/api_settings/disconnect_provider', {
    sessionId,
    userID: userId,
    providerName,
  })
  return res.data
}


