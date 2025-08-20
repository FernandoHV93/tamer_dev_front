type Props = {
  title: string
  score?: number
  date?: string
  wordCount?: number
  onOpen?: () => void
  onEdit?: () => void
  onDelete?: () => void
}

export default function ArticleCard({ title, score, date, wordCount, onOpen, onEdit, onDelete }: Props) {
  const formattedDate = date ? new Date(date).toLocaleString() : ''
  const words = typeof wordCount === 'number' ? wordCount : title.trim().split(/\s+/).filter(Boolean).length

  return (
    <div className="article-row">
      <div className="article-title">{title}</div>
      <div className="article-meta">
        {formattedDate && <span className="muted-text">{formattedDate}</span>}
        {typeof score === 'number' && (
          <span className={`score-badge ${score < 40 ? 'red' : score < 60 ? 'orange' : score < 75 ? 'yellow' : score < 90 ? 'green-soft' : 'green'}`}>{score}/100</span>
        )}
        <span className="pill">{words} words</span>
        <img src="/assets/images/icons/eye.svg" alt="view" style={{ width: 18, height: 18, cursor: 'pointer' }} onClick={onOpen} />
        <img src="/assets/images/icons/edit.svg" alt="edit" style={{ width: 18, height: 18, cursor: 'pointer' }} onClick={onEdit} />
        <img src="/assets/images/icons/delete.svg" alt="delete" style={{ width: 18, height: 18, cursor: 'pointer' }} onClick={onDelete} />
      </div>
    </div>
  )
}


