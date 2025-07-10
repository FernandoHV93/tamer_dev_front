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
    // print('Loading websites for user: $userId');
    // try {
    //   final response = await api.get(
    //     BackendUrls.loadWebsites,
    //     queryParams: {
    //       'user_id': userId, // query param
    //     },
    //   );
    //   print(response);
    //   if (response['error'] != null) {
    //     throw Exception('Failed to load websites: ${response['error']}');
    //   }
    //   final List<dynamic> websitesData =
    //       response is List ? response : (response['websites'] ?? []);
    //   return websitesData.map((data) => WebsiteEntity.fromJson(data)).toList();
    // } catch (e) {
    //   print('Error loading websites: $e');
    //   rethrow;
    // }
    await Future.delayed(const Duration(milliseconds: 400));
    return [
      WebsiteEntity(
        id: 'w1',
        name: 'Dummy Website 1',
        url: 'https://dummy1.com',
        status: WebsiteStatus.Active,
        lastChecked: DateTime.now().subtract(const Duration(days: 1)),
      ),
      WebsiteEntity(
        id: 'w2',
        name: 'Dummy Website 2',
        url: 'https://dummy2.com',
        status: WebsiteStatus.Inactive,
        lastChecked: DateTime.now().subtract(const Duration(days: 2)),
      ),
    ];
  }

  @override
  Future<WebsiteEntity> saveWebsite(
      String sessionId, String userId, WebsiteEntity website) async {
    // print('Saving website: \\${website.name}');
    // try {
    //   final body = {
    //     'sessionID': sessionId,
    //     'userId': userId,
    //     'name': website.name,
    //     'url': website.url,
    //     'status': website.status.name.toLowerCase()
    //   };
    //   final response = await api.post(
    //     BackendUrls.saveWebsite,
    //     body,
    //   );
    //   if (response['error'] != null) {
    //     throw Exception('Failed to save website: \\${response['error']}');
    //   }
    //   // El backend debe devolver el website creado con el ID generado
    //   final savedWebsiteData =
    //       response is Map<String, dynamic> && response['website'] != null
    //           ? response['website']
    //           : response;
    //   if (savedWebsiteData == null) {
    //     throw Exception('Backend did not return the created website');
    //   }
    //   final savedWebsite = WebsiteEntity.fromJson(savedWebsiteData);
    //   print('Website saved successfully with ID: \\${savedWebsite.id}');
    //   return savedWebsite;
    // } catch (e) {
    //   print('Error saving website: $e');
    //   rethrow;
    // }
    await Future.delayed(const Duration(milliseconds: 300));
    return WebsiteEntity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: website.name,
      url: website.url,
      status: website.status,
      lastChecked: DateTime.now(),
    );
  }

  @override
  Future<void> updateWebsite(
      String sessionId, String userId, WebsiteEntity website) async {
    // print('Updating website: \\${website.name}');
    // try {
    //   final body = {
    //     'name': website.name,
    //     'url': website.url,
    //     'status': website.status.name,
    //     'lastChecked': website.lastChecked.toString()
    //   };
    //   final response = await api.put(
    //     BackendUrls.updateWebsite(website.id),
    //     body,
    //   );
    //   if (response['error'] != null) {
    //     throw Exception('Failed to update website: \\${response['error']}');
    //   }
    //   print('Website updated successfully');
    // } catch (e) {
    //   print('Error updating website: $e');
    //   rethrow;
    // }
    await Future.delayed(const Duration(milliseconds: 300));
    return;
  }

  @override
  Future<void> deleteWebsite(
      String sessionId, String userId, String websiteId) async {
    // print('Deleting website with ID: \\${websiteId}');
    // try {
    //   final body = {
    //     'sessionID': sessionId,
    //     'userID': userId,
    //   };
    //   final response = await api.delete(
    //     BackendUrls.deleteWebsite(websiteId),
    //   );
    //   if (response['error'] != null) {
    //     throw Exception('Failed to delete website: \\${response['error']}');
    //   }
    //   print('Website deleted successfully');
    // } catch (e) {
    //   print('Error deleting website: $e');
    //   rethrow;
    // }
    await Future.delayed(const Duration(milliseconds: 300));
    return;
  }

  @override
  Future<void> saveWebsitesData(
      String sessionId, String userId, List<WebsiteEntity> websites) async {
    // Este método no está en Swagger, así que lo dejamos vacío o lanzamos un error.
    throw UnimplementedError(
        'saveWebsitesData no está soportado por el backend actual');
  }
}
