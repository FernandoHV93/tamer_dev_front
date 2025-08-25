export const WebRoutes = {
  home: '/home_page',
  roadmap: '/roadmap_page',
  articleEditor: '/article_editor_page',
  articleBuilder: '/article_builder',
  websites: '/websites_page',
  content: '/content_page',
  apiSettings: '/api_settings',
  brandVoice: '/brand_voice',
} as const

export type WebRoute = typeof WebRoutes[keyof typeof WebRoutes]


