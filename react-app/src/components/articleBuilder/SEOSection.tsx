import { useState } from 'react'
import { useArticleBuilder } from '../../store/articleBuilder'

export default function SEOSection() {
  const { model, setSEO } = useArticleBuilder()
  const [value, setValue] = useState(model.articleSEO.keywords.join(', '))
  return (
    <div style={{ display: 'grid', gap: 12 }}>
      <h3>SEO</h3>
      <label>
        <div>Keywords (comma separated)</div>
        <input
          value={value}
          onChange={(e) => setValue(e.target.value)}
          onBlur={() => setSEO(value.split(',').map((s) => s.trim()).filter(Boolean))}
        />
      </label>
    </div>
  )
}


