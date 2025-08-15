export type WebsiteStatus = 'Active' | 'Inactive'

export type WebsiteEntity = {
  id: string
  status: WebsiteStatus
  url: string
  name: string
  lastChecked?: string | null
}


