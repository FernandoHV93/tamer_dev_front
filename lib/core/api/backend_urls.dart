class BackendUrls {
  static String saveForm = '/article_generator';
  static String generateArticle = '/run_generator';
  static String componentArticleFormat = '/component_article_format';
  static String analysisKeywords = '/analysis_keywords';
  static String titleRunAnalysis = '/title_run_analysis_first';

  static String baseUrl = 'https://4c9d-95-173-217-67.ngrok-free.app';
  static String saveRoadmap = '/new_roadmap';
  static String loadRoadmap = '/get_roadmap';

  // API Settings endpoints
  static String apiProvidersStatus = '/api_settings/providers_status';
  static String connectApiProvider = '/api_settings/connect_provider';
  static String disconnectApiProvider = '/api_settings/disconnect_provider';

  // Website endpoints (según Swagger)
  static String loadWebsites = '/api/websites'; // GET
  static String saveWebsite = '/api/websites'; // POST
  static String updateWebsite(String websiteId) =>
      '/api/websites/$websiteId'; // PUT
  static String deleteWebsite(String websiteId) =>
      '/api/websites/$websiteId'; // DELETE

  // // static String baseUrl = String.fromEnvironment('BASE_URL',
  //     defaultValue: 'https://backend.tamercode.com');
}
