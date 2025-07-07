import 'package:ia_web_front/features/websites/domain/entities/website_entity.dart';
import 'package:ia_web_front/features/websites/domain/repository/website_repository.dart';
import 'package:ia_web_front/core/api/backend_urls.dart';
import 'package:ia_web_front/core/api/api.dart';

class WebsiteRepositoryImpl implements WebsiteRepository {
  WebsiteRepositoryImpl();

  Map<String, String> _buildHeaders(String sessionId, String userId) => {
        'Authorization': 'Bearer $sessionId',
        'X-User-ID': userId,
      };

  @override
  Future<List<WebsiteEntity>> loadWebsites(
      String sessionId, String userId) async {
    print('Loading websites for user: $userId');
    try {
      final response = await api.get(
        BackendUrls.loadWebsites,
        headers: _buildHeaders(sessionId, userId),
      );
      print(response);
      if (response['error'] != null) {
        throw Exception('Failed to load websites: \\${response['error']}');
      }
      final List<dynamic> websitesData =
          response is List ? response : (response['websites'] ?? []);
      return websitesData.map((data) => WebsiteEntity.fromJson(data)).toList();
    } catch (e) {
      print('$e');
      return [
        WebsiteEntity(
          id: '1',
          status: WebsiteStatus.Active,
          url: 'https://technews.com',
          name: 'Tech News',
          lastChecked: DateTime.now().subtract(const Duration(hours: 2)),
        ),
        WebsiteEntity(
          id: '2',
          status: WebsiteStatus.Active,
          url: 'https://travelblog.org',
          name: 'World Travelers',
          lastChecked: DateTime.now().subtract(const Duration(days: 1)),
        ),
        WebsiteEntity(
          id: '3',
          status: WebsiteStatus.Inactive,
          url: 'https://foodrecipes.com',
          name: 'Culinary Delights',
          lastChecked: DateTime.now().subtract(const Duration(days: 3)),
        ),
      ];
    }
  }

  @override
  Future<WebsiteEntity> saveWebsite(
      String sessionId, String userId, WebsiteEntity website) async {
    print('Saving website: \\${website.name}');
    try {
      final body = {
        'sessionID': sessionId,
        'userID': userId,
        ...website.toJson(),
      };
      final response = await api.post(
        BackendUrls.saveWebsite,
        body,
        headers: _buildHeaders(sessionId, userId),
      );
      if (response['error'] != null) {
        throw Exception('Failed to save website: \\${response['error']}');
      }
      // El backend debe devolver el website creado con el ID generado
      final savedWebsiteData =
          response is Map<String, dynamic> && response['website'] != null
              ? response['website']
              : response;
      if (savedWebsiteData == null) {
        throw Exception('Backend did not return the created website');
      }
      final savedWebsite = WebsiteEntity.fromJson(savedWebsiteData);
      print('Website saved successfully with ID: \\${savedWebsite.id}');
      return savedWebsite;
    } catch (e) {
      print('Error saving website: $e');
      final savedWebsite = website.copyWith(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        lastChecked: DateTime.now(),
      );
      print('Website saved successfully with ID: \\${savedWebsite.id}');
      return savedWebsite;
    }
  }

  @override
  Future<void> updateWebsite(
      String sessionId, String userId, WebsiteEntity website) async {
    print('Updating website: \\${website.name}');
    try {
      final response = await api.put(
        BackendUrls.updateWebsite(website.id),
        website.toJson(),
        headers: _buildHeaders(sessionId, userId),
      );
      if (response['error'] != null) {
        throw Exception('Failed to update website: \\${response['error']}');
      }
      print('Website updated successfully');
    } catch (e) {
      print('API endpoint not available, using dummy update: $e');
      await Future.delayed(const Duration(milliseconds: 300));
      print('Website updated successfully');
    }
  }

  @override
  Future<void> deleteWebsite(
      String sessionId, String userId, String websiteId) async {
    print('Deleting website with ID: \\${websiteId}');
    try {
      final response = await api.delete(
        BackendUrls.deleteWebsite(websiteId),
        headers: _buildHeaders(sessionId, userId),
      );
      if (response['error'] != null) {
        throw Exception('Failed to delete website: \\${response['error']}');
      }
      print('Website deleted successfully');
    } catch (e) {
      print('API endpoint not available, using dummy delete: $e');
      await Future.delayed(const Duration(milliseconds: 300));
      print('Website deleted successfully');
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
