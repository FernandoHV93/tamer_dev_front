import { useMemo, useState } from 'react'
import ArticleEditor from '../components/editor/ArticleEditor'
import { articleDtoToHtml } from '../lib/articleDtoToHtml'

export default function ArticleEditorPage() {
  // Placeholder de un ArticleDto mínimo
  const dto = useMemo(() => ({
    H1: { text: 'Article Title', N: true, I: false, U: false, aligment: 'center', size: 'H1' },
    body: [
      { title: { text: 'Section 1', N: true, I: false, U: false, aligment: 'left', size: 'H2' }, text: [{ text: 'Lorem ipsum dolor sit amet.', N: false, I: false, U: false, aligment: 'left', size: 'body' }], images: [], codes: [], links: [], citations: [] },
    ],
  }), [])

  const [html, setHtml] = useState(articleDtoToHtml(dto))

  return (
    <div style={{ padding: 24, display: 'grid', gap: 12 }}>
      <h1>Article Editor</h1>
      <ArticleEditor html={html} onChange={setHtml} />
    </div>
  )
}


