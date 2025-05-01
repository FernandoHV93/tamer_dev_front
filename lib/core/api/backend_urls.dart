
class BackendUrls {
  static String generateArticle = '/new_roadmap';
  static String baseUrl = String.fromEnvironment('BASE_URL',
      defaultValue: 'http://localhost:8000');
}
