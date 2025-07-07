import 'package:ia_web_front/features/websites/domain/entities/website_entity.dart';

abstract class WebsiteRepository {
  Future<List<WebsiteEntity>> loadWebsites(String sessionId, String userId);
  Future<WebsiteEntity> saveWebsite(
      String sessionId, String userId, WebsiteEntity website);
  Future<void> updateWebsite(
      String sessionId, String userId, WebsiteEntity website);
  Future<void> deleteWebsite(String sessionId, String userId, String websiteId);
  Future<void> saveWebsitesData(
      String sessionId, String userId, List<WebsiteEntity> websites);
}
