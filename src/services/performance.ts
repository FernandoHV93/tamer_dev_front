import type { WebsiteEntity } from '../types/website'
import type { InspectedWebsite } from '../types/performance'

// Mock server-side inspect, similar to Flutter's PerformanceRepositoryImpl
export async function inspectWebsite(website: WebsiteEntity): Promise<InspectedWebsite> {
  await new Promise((r) => setTimeout(r, 800))
  return {
    website,
    contentCards: [
      {
        id: `card_${website.id}_1`,
        websiteId: website.id,
        title: 'SEO Optimization Guide',
        url: `${website.url}/seo-guide`,
        keyWordsScore: 85,
        status: 'done',
      },
      {
        id: `card_${website.id}_2`,
        websiteId: website.id,
        title: 'Content Marketing Strategy',
        url: `${website.url}/content-strategy`,
        keyWordsScore: 92,
        status: 'done',
      },
    ],
    top3Keywords: 12,
    top10Keywords: 34,
    top100Keywords: 120,
    top3Delta: 2,
    top10Delta: 5,
    top100Delta: 10,
  }
}


