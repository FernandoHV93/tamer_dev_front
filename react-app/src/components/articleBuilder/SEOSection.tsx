import { useState } from 'react'
import { useArticleBuilder } from '../../store/articleBuilder'
import { Input } from '../ui/input'

export default function SEOSection() {
  const { model, setSEO } = useArticleBuilder()
  const [value, setValue] = useState(model.articleSEO.keywords.join(', '))
  return (
    <div style={{ display: 'grid', gap: 12 }}>
      <div className="muted-text">Keywords will be used to generate relevant content. Add them manually or generate them automatically.</div>
      <label>
        <div className="row" style={{ justifyContent: 'space-between', alignItems: 'center' }}>
          <span>Keywords to include in the text</span>
          <button className="btn btn-primary">NLP keywords generation</button>
        </div>
        <Input
          placeholder="Write keywords and press Enter"
          value={value}
          onChange={(e) => setValue(e.target.value)}
          onBlur={() => setSEO(value.split(',').map((s) => s.trim()).filter(Boolean))}
        />
        <div className="muted-text" style={{ marginTop: 6 }}>Keywords will be used to generate relevant content. You can add them manually or generate them automatically.</div>
      </label>
    </div>
  )
}


