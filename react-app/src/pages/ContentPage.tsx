import { useEffect, useState } from 'react'
import { useWebsites } from '../store/websites'
import { useContent } from '../store/content'
import { useMemo, useState as useLocalState } from 'react'

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
            <TopicsPanel />
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

function TopicsPanel() {
  const { selectedCardId, topicsByCardId, loadTopics, addTopic, deleteTopic, isLoading } = useContent()
  const topics = useMemo(() => (selectedCardId ? topicsByCardId[selectedCardId] ?? [] : []), [topicsByCardId, selectedCardId])
  const [keyWord, setKeyWord] = useLocalState('')
  const [status, setStatus] = useLocalState<'covered' | 'draft' | 'initiated'>('initiated')

  if (!selectedCardId) {
    return <div>Selecciona una card</div>
  }

  return (
    <div>
      <div style={{ display: 'flex', gap: 8, marginBottom: 12 }}>
        <button disabled={isLoading} onClick={() => loadTopics(selectedCardId)}>Refresh</button>
        <input placeholder="Keyword" value={keyWord} onChange={(e) => setKeyWord(e.target.value)} />
        <select value={status} onChange={(e) => setStatus(e.target.value as any)}>
          <option value="initiated">initiated</option>
          <option value="draft">draft</option>
          <option value="covered">covered</option>
        </select>
        <button
          disabled={!keyWord || isLoading}
          onClick={async () => {
            await addTopic(selectedCardId, {
              keyWord,
              date: new Date().toISOString(),
              status,
            } as any)
            setKeyWord('')
          }}
        >
          Add
        </button>
      </div>
      <ul>
        {topics.map((t) => (
          <li key={t.id}>
            {t.keyWord} — {t.status}
            <button style={{ marginLeft: 8 }} disabled={isLoading} onClick={() => deleteTopic(selectedCardId, t.id)}>Delete</button>
          </li>
        ))}
      </ul>
    </div>
  )
}


