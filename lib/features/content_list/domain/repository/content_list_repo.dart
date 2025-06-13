import 'package:ia_web_front/features/content_list/data/models/website_model.dart';

abstract class ContentListRepo {
  Future<Map<String, dynamic>> websiteInspection(
      String sessionId, String userId, Website website);
  Future<Map<String, dynamic>> loadWebsites(String sessionId, String userId);
  Future<void> saveWebsitesData(
      String sessionId, String userId, List<Website> websites);
  Future<Map<String, dynamic>> competitorAnalysis(
      String sessionId, String userId, Website website);
}
