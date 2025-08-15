import { useEffect } from 'react'
import { useWebsites } from '../store/websites'
import { useContent } from '../store/content'

export default function ContentPage() {
  const { websites, selectedWebsiteId, select, load } = useWebsites()
  const { cards, selectCard, loadCards } = useContent()

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
        </div>
        <div style={{ flex: 1 }}>
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
      </div>
    </div>
  )
}


