type Props = {
  iconPath: string
  title: string
  description: string
  badgeText?: string
  onClick?: () => void
}

export default function FeatureButton({ iconPath, title, description, badgeText, onClick }: Props) {
  return (
    <button onClick={onClick} style={{
      display: 'flex', gap: 16, alignItems: 'center',
      background: '#202225', color: 'white', border: '1px solid #333',
      padding: 16, borderRadius: 12, margin: '8px 16px', textAlign: 'left'
    }}>
      <img src={iconPath} alt="" style={{ width: 36, height: 36 }} />
      <div style={{ flex: 1 }}>
        <div style={{ display: 'flex', alignItems: 'center', gap: 8 }}>
          <h3 style={{ margin: 0 }}>{title}</h3>
          {badgeText && (
            <span style={{ fontSize: 12, background: '#2563EB', padding: '2px 8px', borderRadius: 8 }}>
              {badgeText}
            </span>
          )}
        </div>
        <p style={{ margin: '4px 0 0', color: '#b0b0b0' }}>{description}</p>
      </div>
    </button>
  )
}


