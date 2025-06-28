import 'package:ia_web_front/features/websites/domain/entities/website_entity.dart';
import 'package:ia_web_front/features/websites/domain/repository/website_repository.dart';

class WebsiteUseCases {
  final WebsiteRepository repository;

  WebsiteUseCases(this.repository);

  Future<List<WebsiteEntity>> loadWebsites(
      String sessionId, String userId) async {
    return await repository.loadWebsites(sessionId, userId);
  }

  Future<void> saveWebsite(
      String sessionId, String userId, WebsiteEntity website) async {
    return await repository.saveWebsite(sessionId, userId, website);
  }

  Future<void> updateWebsite(
      String sessionId, String userId, WebsiteEntity website) async {
    return await repository.updateWebsite(sessionId, userId, website);
  }

  Future<void> deleteWebsite(
      String sessionId, String userId, String websiteId) async {
    return await repository.deleteWebsite(sessionId, userId, websiteId);
  }

  Future<void> saveWebsitesData(
      String sessionId, String userId, List<WebsiteEntity> websites) async {
    return await repository.saveWebsitesData(sessionId, userId, websites);
  }
}
