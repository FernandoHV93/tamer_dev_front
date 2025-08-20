type Props = {
  iconPath: string
  title: string
  description: string
  badgeText?: string
  onClick?: () => void
}

export default function FeatureButton({ iconPath, title, description, badgeText, onClick }: Props) {
  const isSearchIcon = iconPath.includes('search.svg')
  return (
    <button onClick={onClick} className="feature-btn">
      <img src={iconPath} alt="" className={`feature-icon ${isSearchIcon ? 'no-filter' : ''}`} style={{ width: 36, height: 36 }} />
      <div style={{ flex: 1 }}>
        <div className="row">
          <h3 style={{ margin: 0 }}>{title}</h3>
          {badgeText && (
            <span className="feature-badge">{badgeText}</span>
          )}
        </div>
        <p style={{ margin: '4px 0 0', color: 'var(--muted)' }}>{description}</p>
      </div>
    </button>
  )
}


