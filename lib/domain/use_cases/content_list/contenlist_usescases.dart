import 'package:ia_web_front/data/models/website_model.dart';
import 'package:ia_web_front/domain/repository/content_list_repo.dart';

class ContentListUseCases {
  final ContentListRepo repository;

  ContentListUseCases(this.repository);

  Future<Map<String, dynamic>> loadWebsites(
      String sessionId, String userId) async {
    return await repository.loadWebsites(sessionId, userId);
  }

  Future<Map<String, dynamic>> inspectWebsite(
      String sessionId, String userId, Website website) async {
    return await repository.websiteInspection(sessionId, userId, website);
  }

  Future<void> saveWebsitesData(
      String sessionId, String userId, List<Website> websites) async {
    return await repository.saveWebsitesData(sessionId, userId, websites);
  }

  Future<Map<String, dynamic>> analyzeCompetitor(
      String sessionId, String userId, Website website) async {
    return await repository.competitorAnalysis(sessionId, userId, website);
  }
}
