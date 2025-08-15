# Mock Backend

Servidor Express para probar la app React localmente.

## Uso

```
cd mock-backend
npm i
npm start
```

- URL: `http://localhost:4000`
- Ajusta `VITE_BASE_URL` en `react-app/.env.local` a `http://localhost:4000`.

## Endpoints cubiertos

- Websites: `/api/websites/*`
- Content Cards: `/api/websites/:id/content-cards`, `/api/content-cards/:id`
- Topics: `/api/content-cards/:id/topics`, `/api/topics/:id`
- Brand Voice: `/api/brand-voice*`
- API Settings: `/api_settings/*`
- Article Builder: `/component_article_format`, `/run_generator`, `/article_generator`
- Analysis: `/analysis_keywords`, `/title_run_analysis_first`
- Roadmap: `/get_roadmap`, `/save_roadmap`

Datos en memoria; se reinician al reiniciar el servidor.
