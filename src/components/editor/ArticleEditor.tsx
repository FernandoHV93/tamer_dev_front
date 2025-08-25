import { useEffect, useRef } from 'react'
import Quill from 'quill'
import 'quill/dist/quill.snow.css'

type Props = {
  html?: string
  onChange?: (html: string) => void
}

export default function ArticleEditor({ html, onChange }: Props) {
  const containerRef = useRef<HTMLDivElement | null>(null)
  const quillRef = useRef<Quill | null>(null)

  useEffect(() => {
    if (!containerRef.current) return
    if (quillRef.current) return

    const editorEl = document.createElement('div')
    containerRef.current.appendChild(editorEl)
    const q = new Quill(editorEl, {
      theme: 'snow',
      modules: {
        toolbar: [
          [{ header: [1, 2, 3, false] }],
          ['bold', 'italic', 'underline', 'strike'],
          [{ list: 'ordered' }, { list: 'bullet' }],
          ['code-block', 'blockquote', 'link'],
          [{ align: [] }],
          ['clean'],
        ],
      },
    })
    quillRef.current = q

    if (html) {
      const root = q.root
      root.innerHTML = html
    }

    q.on('text-change', () => {
      onChange?.(q.root.innerHTML)
    })
  }, [])

  useEffect(() => {
    if (!quillRef.current) return
    if (html === undefined) return
    const current = quillRef.current.root.innerHTML
    if (current !== html) {
      quillRef.current.root.innerHTML = html
    }
  }, [html])

  return <div ref={containerRef} />
}
