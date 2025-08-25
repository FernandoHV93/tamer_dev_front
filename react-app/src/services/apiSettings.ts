import { http } from '../lib/http'

export async function providersStatus() {
  const res = await http.get('/api_settings/providers_status')
  return res.data
}

export async function connectProvider(provider: string, credentials: any) {
  const res = await http.post('/api_settings/connect_provider', { provider, ...credentials })
  return res.data
}

export async function disconnectProvider(provider: string) {
  const res = await http.post('/api_settings/disconnect_provider', { provider })
  return res.data
}


