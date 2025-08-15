type Props = {
  title: string
  score?: number
  date?: string
  onOpen?: () => void
}

export default function ArticleCard({ title, score, date, onOpen }: Props) {
  const formatted = date ? new Date(date).toLocaleString() : ''
  return (
    <div className="card" style={{ display: 'grid', gap: 8 }}>
      <div style={{ fontWeight: 700 }}>{title}</div>
      <div style={{ display: 'flex', gap: 12, color: 'var(--muted)', fontSize: 12 }}>
        {typeof score === 'number' && <span>Score: {score}</span>}
        {date && <span>{formatted}</span>}
      </div>
      <div>
        <button className="btn" onClick={onOpen}>Open</button>
      </div>
    </div>
  )
}


