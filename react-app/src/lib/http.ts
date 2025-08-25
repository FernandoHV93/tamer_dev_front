import axios from 'axios'

const BASE_URL = import.meta.env.VITE_BASE_URL ?? 'https://backend.tamercode.com'

export const http = axios.create({
  baseURL: BASE_URL,
})

export function setSessionHeaders(sessionId: string, userId: string) {
  try {
    http.defaults.headers.common['sessionID'] = sessionId
    http.defaults.headers.common['userID'] = userId
  } catch {}
}


