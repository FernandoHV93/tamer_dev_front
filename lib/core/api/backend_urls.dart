class BackendUrls {
  static String saveForm = '/article_generator';
  static String generateArticle = '/run_generator';
  static String componentArticleFormat = '/component_article_format';
  static String baseUrl =
      String.fromEnvironment('BASE_URL', defaultValue: 'http://localhost:8000');
}
