import { Routes, Route, Navigate } from 'react-router-dom'
import HomePage from './pages/HomePage'
import AllArticlesPage from './pages/AllArticlesPage'
import RoadmapPage from './pages/RoadmapPage'
import ArticleEditorPage from './pages/ArticleEditorPage'
import ArticleBuilderPage from './pages/ArticleBuilderPage'
import WebsitesPage from './pages/WebsitesPage'
import ContentPage from './pages/ContentPage'
import ApiSettingsPage from './pages/ApiSettingsPage'
import BrandVoicePage from './pages/BrandVoicePage'
import Navbar from './components/Navbar'

function App() {
  return (
    <div>
      <Navbar />
      <Routes>
        <Route path="/home_page" element={<HomePage />} />
        <Route path="/all_articles" element={<AllArticlesPage />} />
        <Route path="/roadmap_page" element={<RoadmapPage />} />
        <Route path="/article_editor_page" element={<ArticleEditorPage />} />
        <Route path="/article_builder" element={<ArticleBuilderPage />} />
        <Route path="/websites_page" element={<WebsitesPage />} />
        <Route path="/content_page" element={<ContentPage />} />
        <Route path="/api_settings" element={<ApiSettingsPage />} />
        <Route path="/brand_voice" element={<BrandVoicePage />} />
        <Route path="/" element={<Navigate to="/home_page" replace />} />
        <Route path="*" element={<Navigate to="/home_page" replace />} />
      </Routes>
    </div>
  )
}

export default App
