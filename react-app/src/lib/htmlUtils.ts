export function extractTitleFromHtml(html: string): string {
  try {
    const match = /<h1[^>]*>([\s\S]*?)<\/h1>/i.exec(html)
    if (!match) return ''
    const tmp = document.createElement('div')
    tmp.innerHTML = match[1]
    return tmp.textContent || tmp.innerText || ''
  } catch {
    return ''
  }
}

export function cn(...classes: Array<string | undefined | false | null>) {
  return classes.filter(Boolean).join(' ')
}


