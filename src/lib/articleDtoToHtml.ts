// Converts a Flutter-like ArticleDto (H1/body or h1/body) into simple HTML

type TextFmt = { text?: string; N?: boolean; I?: boolean; U?: boolean; aligment?: string; size?: string }

function escapeHtml(s: string) {
  return s
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
}

function renderText(t: TextFmt): string {
  let inner = escapeHtml(t.text ?? '')
  if (t.N) inner = `<strong>${inner}</strong>`
  if (t.I) inner = `<em>${inner}</em>`
  if (t.U) inner = `<u>${inner}</u>`
  return inner
}

export function articleDtoToHtml(article: any): string {
  if (!article) return ''
  const h1 = article.H1 ?? article.h1
  let html = ''
  if (h1?.text) {
    html += `<h1 style="text-align:${h1.aligment ?? 'left'}">${renderText(h1)}</h1>`
  }
  const body = Array.isArray(article.body) ? article.body : []
  for (const section of body) {
    if (section?.title?.text) {
      html += `<h2 style="text-align:${section.title.aligment ?? 'left'}">${renderText(section.title)}</h2>`
    }
    if (Array.isArray(section?.text)) {
      for (const p of section.text) {
        if (!p?.text) continue
        html += `<p style="text-align:${p.aligment ?? 'left'}">${renderText(p)}</p>`
      }
    }
    if (Array.isArray(section?.images)) {
      for (const img of section.images) {
        if (img?.url) {
          const alt = escapeHtml(img.text ?? '')
          html += `<figure><img src="${img.url}" alt="${alt}" /><figcaption>${alt}</figcaption></figure>`
        }
      }
    }
    if (Array.isArray(section?.codes)) {
      for (const code of section.codes) {
        if (code?.code) {
          html += `<pre><code>${escapeHtml(code.code)}</code></pre>`
        }
      }
    }
    if (Array.isArray(section?.links)) {
      for (const link of section.links) {
        if (link?.url && link?.text) {
          html += `<p><a href="${link.url}" target="_blank" rel="noopener noreferrer">${escapeHtml(link.text)}</a></p>`
        }
      }
    }
    if (Array.isArray(section?.citations)) {
      for (const c of section.citations) {
        if (c?.citation || c?.text) {
          const txt = c.citation ?? c.text
          html += `<blockquote>${escapeHtml(txt)}</blockquote>`
        }
      }
    }
  }
  return html
}


