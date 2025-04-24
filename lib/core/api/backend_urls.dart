import 'package:flutter_dotenv/flutter_dotenv.dart';

class BackendUrls {
  static String generateArticle = '/new_roadmap';
  static String baseUrl = dotenv.env['BASE_URL'] ?? 'http://localhost:8000';
}
