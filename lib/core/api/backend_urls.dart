class BackendUrls {
  static String saveForm = '/article_generator';
  static String generateArticle = '/run_generator';
  static String componentArticleFormat = '/component_article_format';
  static String analysisKeywords = '/analysis_keywords';
  static String titleRunAnalysis = '/title_run_analysis_first';

  // static String baseUrl = 'http://18.223.187.238:8000';

  static String baseUrl = String.fromEnvironment('BASE_URL',
      defaultValue: 'http://18.223.187.238:8000');
}
