import { Link, useLocation } from 'react-router-dom'

const links = [
  { to: '/home_page', label: 'Home' },
  { to: '/content_page', label: 'Content' },
  { to: '/article_builder', label: 'Builder' },
  { to: '/article_editor_page', label: 'Editor' },
  { to: '/websites_page', label: 'Websites' },
  { to: '/roadmap_page', label: 'Roadmap' },
  { to: '/api_settings', label: 'API Settings' },
  { to: '/brand_voice', label: 'Brand Voice' },
]

export default function Navbar() {
  const { pathname } = useLocation()
  return (
    <header className="navbar flex justify-center">
      <div className="navbar-inner w-full max-w-[1220px] flex justify-between">
        <div className="navbar-brand">Article Builder</div>
        <nav className="navbar-links">
          {links.map((l) => (
            <Link key={l.to} to={l.to} className={`nav-link ${pathname === l.to ? 'active' : ''}`}>
              {l.label}
            </Link>
          ))}
        </nav>
      </div>
    </header>
  )
}


