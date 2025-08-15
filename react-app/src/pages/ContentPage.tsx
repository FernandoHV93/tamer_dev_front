import { useEffect, useState } from 'react'
import { useWebsites } from '../store/websites'
import { useContent } from '../store/content'

export default function ContentPage() {
  const { websites, selectedWebsiteId, select, load } = useWebsites()
  const { cards, selectCard, loadCards, inspected, inspectWebsite, isLoading } = useContent()
  const [tab, setTab] = useState<'overview' | 'topics' | 'performance' | 'gaps'>('overview')

  useEffect(() => {
    const userId = 'Mayo8.com'
    load(userId)
  }, [load])

  useEffect(() => {
    if (selectedWebsiteId) {
      loadCards(selectedWebsiteId)
    }
  }, [selectedWebsiteId, loadCards])

  return (
    <div style={{ padding: 24 }}>
      <h1>Content</h1>
      <div style={{ display: 'flex', gap: 24 }}>
        <div style={{ width: 320 }}>
          <h3>Websites</h3>
          <ul>
            {websites.map((w) => (
              <li key={w.id}>
                <button onClick={() => select(w.id)} style={{ marginRight: 8 }}>
                  Select
                </button>
                {w.name}
              </li>
            ))}
          </ul>
          <div style={{ marginTop: 16 }}>
            <button
              disabled={!selectedWebsiteId || isLoading}
              onClick={() => {
                const site = websites.find((x) => x.id === selectedWebsiteId)
                if (site) inspectWebsite(site)
              }}
            >
              {isLoading ? 'Inspecting…' : 'Inspect Website'}
            </button>
          </div>
        </div>
        <div style={{ flex: 1 }}>
          <div style={{ display: 'flex', gap: 12, marginBottom: 12 }}>
            <button onClick={() => setTab('overview')} disabled={tab === 'overview'}>Overview</button>
            <button onClick={() => setTab('topics')} disabled={tab === 'topics'}>Topics</button>
            <button onClick={() => setTab('performance')} disabled={tab === 'performance'}>Performance</button>
            <button onClick={() => setTab('gaps')} disabled={tab === 'gaps'}>Gaps</button>
          </div>
          {tab === 'overview' && (
            <div>
              <h3>Content Cards</h3>
              {selectedWebsiteId ? (
                <ul>
                  {cards.map((c) => (
                    <li key={c.id}>
                      <button onClick={() => selectCard(c.id)} style={{ marginRight: 8 }}>
                        Open
                      </button>
                      {c.title} — {c.status}
                    </li>
                  ))}
                </ul>
              ) : (
                <div>Selecciona un website</div>
              )}
            </div>
          )}
          {tab === 'performance' && (
            <div>
              <h3>Performance</h3>
              {inspected ? (
                <div style={{ display: 'grid', gap: 6 }}>
                  <div>Top 3 Keywords: {inspected.top3Keywords} (Δ {inspected.top3Delta})</div>
                  <div>Top 10 Keywords: {inspected.top10Keywords} (Δ {inspected.top10Delta})</div>
                  <div>Top 100 Keywords: {inspected.top100Keywords} (Δ {inspected.top100Delta})</div>
                  <div style={{ marginTop: 8 }}>
                    <strong>Cards</strong>
                    <ul>
                      {inspected.contentCards.map((c) => (
                        <li key={c.id}>{c.title} — {c.keyWordsScore}</li>
                      ))}
                    </ul>
                  </div>
                </div>
              ) : (
                <div>No data. Click "Inspect Website".</div>
              )}
            </div>
          )}
          {tab === 'topics' && (
            <div>
              <h3>Topics</h3>
              <div>Pendiente de implementación</div>
            </div>
          )}
          {tab === 'gaps' && (
            <div>
              <h3>Gaps</h3>
              <div>Pendiente de implementación</div>
            </div>
          )}
        </div>
      </div>
    </div>
  )
}


