class BackendUrls {
  static String saveForm = '/article_generator';
  static String generateArticle = '/run_generator';
  static String componentArticleFormat = '/component_article_format';
  static String analysisKeywords = '/analysis_keywords';
  static String titleRunAnalysis = '/title_run_analysis_first';

  static String baseUrl = 'https://10af7add859c.ngrok-free.app';
  static String saveRoadmap = '/new_roadmap';
  static String loadRoadmap = '/get_roadmap';

  // API Settings endpoints
  static String apiProvidersStatus = '/api_settings/providers_status';
  static String connectApiProvider = '/api_settings/connect_provider';
  static String disconnectApiProvider = '/api_settings/disconnect_provider';

  // Website endpoints (según Swagger)
  static String loadWebsites = '/api/websites/load'; // GET
  static String saveWebsite = '/api/websites'; // POST
  static String updateWebsite(String websiteId) =>
      '/api/websites/$websiteId'; // PUT
  static String deleteWebsite(String websiteId) =>
      '/api/websites/$websiteId'; // DELETE

  // Content Cards endpoints
  static String loadContentCards(String websiteId) =>
      '/api/websites/$websiteId/content-cards'; // GET
  static String createContentCard(String websiteId) =>
      '/api/websites/$websiteId/content-cards'; // POST
  static String updateContentCard(String contentCardId) =>
      '/api/content-cards/$contentCardId'; // PUT
  static String deleteContentCard(String contentCardId) =>
      '/api/content-cards/$contentCardId'; // DELETE

  // BrandVoice endpoints
  static String loadBrands = '/api/brand_voice'; // GET
  static String addBrand = '/api/brand_voice'; // POST
  static String updateBrand(String brandId) =>
      '/api/brand_voice/$brandId'; // PUT
  static String deleteBrand(String brandId) =>
      '/api/brand_voice/$brandId'; // DELETE
  static String generateBrandVoice = '/api/brand_voice/generate'; // POST
  static String analyzeContentAndGenerateBrandVoice =
      '/api/brand_voice/analyze_content'; // POST
  static String analyzeFileAndGenerateBrandVoice =
      '/api/brand_voice/analyze_file'; // POST
  static String analyzeFileBytesAndGenerateBrandVoice =
      '/api/brand_voice/analyze_file_bytes'; // POST

  // Topics endpoints
  static String loadTopicsByCardId(String contentCardId) =>
      '/api/content-cards/$contentCardId/topics';
  static String addTopic(String contentCardId) =>
      '/api/content-cards/$contentCardId/topics';
  static String updateTopic(String topicId) => '/api/topics/$topicId';
  static String deleteTopic(String topicId) =>
      '/api/content-cards/$topicId/topics';

  // // static String baseUrl = String.fromEnvironment('BASE_URL',
  //     defaultValue: 'https://backend.tamercode.com');
}
