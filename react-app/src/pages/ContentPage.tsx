import { useEffect, useState } from 'react'
import { useWebsites } from '../store/websites'
import { useContent } from '../store/content'
import { useSession } from '../context/SessionContext'
import { useToast } from '../context/ToastContext'
import { useMemo, useState as useLocalState } from 'react'

export default function ContentPage() {
  const { websites, selectedWebsiteId, select, load } = useWebsites()
  const { cards, selectCard, loadCards, inspected, inspectWebsite, isLoading, addCard, updateCard, deleteCard } = useContent()
  const [tab, setTab] = useState<'overview' | 'topics' | 'performance' | 'gaps'>('overview')
  const [newCardTitle, setNewCardTitle] = useState('')
  const [newCardUrl, setNewCardUrl] = useState('')
  const { showToast } = useToast()

  const { userId, sessionId } = useSession()
  useEffect(() => {
    load(userId)
  }, [load, userId])

  useEffect(() => {
    if (selectedWebsiteId) {
      loadCards(selectedWebsiteId)
    }
  }, [selectedWebsiteId, loadCards])

  return (
    <div className="app-container">
      <h1>Content</h1>
      <div style={{ display: 'flex', gap: 24 }}>
        <div style={{ width: 320 }}>
          <h3>Websites</h3>
          <ul className="card">
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
          <div className="row" style={{ marginBottom: 12 }}>
            <button className="btn" onClick={() => setTab('overview')} disabled={tab === 'overview'}>Overview</button>
            <button className="btn" onClick={() => setTab('topics')} disabled={tab === 'topics'}>Topics</button>
            <button className="btn" onClick={() => setTab('performance')} disabled={tab === 'performance'}>Performance</button>
            <button className="btn" onClick={() => setTab('gaps')} disabled={tab === 'gaps'}>Gaps</button>
          </div>
          {tab === 'overview' && (
            <div>
              <h3>Content Cards</h3>
              {selectedWebsiteId ? (
                <ul className="card">
                  {cards.map((c) => (
                    <li key={c.id}>
                      <button onClick={() => selectCard(c.id)} style={{ marginRight: 8 }}>
                        Open
                      </button>
                      {c.title} — {c.status}
                      <button style={{ marginLeft: 8 }} onClick={async () => { await updateCard(c.id, { title: c.title + ' (updated)' }, sessionId, userId); showToast('Card updated', 'success') }} disabled={isLoading}>Quick Update</button>
                      <button style={{ marginLeft: 8 }} onClick={async () => { await deleteCard(c.id, sessionId, userId); showToast('Card deleted', 'success') }} disabled={isLoading}>Delete</button>
                    </li>
                  ))}
                </ul>
              ) : (
                <div>Selecciona un website</div>
              )}
              {isLoading && (
                <div className="card" style={{ display: 'grid', gap: 8 }}>
                  <div className="skeleton line"></div>
                  <div className="skeleton line" style={{ width: '80%' }}></div>
                  <div className="skeleton line" style={{ width: '60%' }}></div>
                </div>
              )}
              <div className="row" style={{ marginTop: 12 }}>
                <input className="input" placeholder="New card title" value={newCardTitle} onChange={(e) => setNewCardTitle(e.target.value)} />
                <input className="input" placeholder="URL (opcional)" value={newCardUrl} onChange={(e) => setNewCardUrl(e.target.value)} />
                <button className="btn btn-primary" disabled={!newCardTitle || !selectedWebsiteId || isLoading} onClick={async () => {
                  await addCard(selectedWebsiteId!, { title: newCardTitle, url: newCardUrl || undefined, keyWordsScore: 0, status: 'no_done' }, sessionId, userId)
                  showToast('Card added', 'success')
                  setNewCardTitle(''); setNewCardUrl('')
                }}>Add Card</button>
              </div>
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
  const { selectedCardId, topicsByCardId, loadTopics, addTopic, deleteTopic, updateTopic, isLoading } = useContent()
  const { sessionId, userId } = useSession()
  const { showToast } = useToast()
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
            } as any, sessionId, userId)
            showToast('Topic added', 'success')
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
            <button style={{ marginLeft: 8 }} disabled={isLoading} onClick={async () => { await updateTopic(t.id, { status: 'covered' }, sessionId, userId); showToast('Topic updated', 'success') }}>Mark Covered</button>
            <button style={{ marginLeft: 8 }} disabled={isLoading} onClick={async () => { await deleteTopic(selectedCardId, t.id, sessionId, userId); showToast('Topic deleted', 'success') }}>Delete</button>
          </li>
        ))}
      </ul>
    </div>
  )
}


