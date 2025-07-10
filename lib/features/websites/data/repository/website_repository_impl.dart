import 'package:ia_web_front/features/websites/domain/entities/website_entity.dart';
import 'package:ia_web_front/features/websites/domain/repository/website_repository.dart';
import 'package:ia_web_front/core/api/backend_urls.dart';
import 'package:ia_web_front/core/api/api.dart';

class WebsiteRepositoryImpl implements WebsiteRepository {
  WebsiteRepositoryImpl();

  // Map<String, String> _buildHeaders(String sessionId, String userId) => {
  //       'Authorization': 'Bearer $sessionId',
  //       'X-User-ID': userId,
  //     };

  @override
  Future<List<WebsiteEntity>> loadWebsites(
      String sessionId, String userId) async {
    try {
      final response = await api.get(
        BackendUrls.loadWebsites,
        queryParams: {
          'user_id': userId,
        },
      );

      if (response['error'] != null) {
        throw Exception('Failed to load websites: ${response['error']}');
      }
      final List<dynamic> websitesData =
          response is List ? response : (response['websites'] ?? []);
      return websitesData.map((data) => WebsiteEntity.fromJson(data)).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<WebsiteEntity> saveWebsite(
      String sessionId, String userId, WebsiteEntity website) async {
    try {
      final body = {
        'sessionID': sessionId,
        'userId': userId,
        'name': website.name,
        'url': website.url,
        'status': website.status.name.toLowerCase()
      };
      final response = await api.post(
        BackendUrls.saveWebsite,
        body,
      );
      if (response['error'] != null) {
        throw Exception('Failed to save website: ${response['error']}');
      }

      final savedWebsiteData =
          response is Map<String, dynamic> && response['website'] != null
              ? response['website']
              : response;
      if (savedWebsiteData == null) {
        throw Exception('Backend did not return the created website');
      }
      final savedWebsite = WebsiteEntity.fromJson(savedWebsiteData);

      return savedWebsite;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateWebsite(
      String sessionId, String userId, WebsiteEntity website) async {
    try {
      final body = {
        'name': website.name,
        'url': website.url,
        'status': website.status.name,
        'lastChecked': website.lastChecked.toString()
      };
      final response = await api.put(
        BackendUrls.updateWebsite(website.id),
        body,
      );
      if (response['error'] != null) {
        throw Exception('Failed to update website: ${response['error']}');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteWebsite(
      String sessionId, String userId, String websiteId) async {
    try {
      final response = await api.delete(
        BackendUrls.deleteWebsite(websiteId),
      );
      if (response['error'] != null) {
        throw Exception('Failed to delete website: ${response['error']}');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> saveWebsitesData(
      String sessionId, String userId, List<WebsiteEntity> websites) async {
    // Este método no está en Swagger, así que lo dejamos vacío o lanzamos un error.
    throw UnimplementedError(
        'saveWebsitesData no está soportado por el backend actual');
  }
}
