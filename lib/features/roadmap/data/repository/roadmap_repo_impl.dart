import 'package:ia_web_front/features/roadmap/domain/repository/roadmap_repo.dart';
import 'package:ia_web_front/core/api/api.dart';
import 'package:ia_web_front/core/api/backend_urls.dart';

class RoadmapRepoImpl implements RoadmapRepo {
  @override
  Future<void> saveRoadmap(
      String sessionId, String userId, Map<String, dynamic> roadmapJson) async {
    try {
      final jsonToSend = {
        "sessionID": sessionId,
        "userID": userId,
        ...roadmapJson,
      };
      final result = await api.post(BackendUrls.saveRoadmap, jsonToSend);
      if (result.containsKey('error')) {
        throw Exception("Error del servidor: \\${result['error']}");
      }
    } catch (e) {
      throw Exception("Error al guardar el roadmap: $e");
    }
  }

  @override
  Future<Map<String, dynamic>> loadRoadmap(
      String sessionId, String userId) async {
    try {
      final params = {
        "sessionID": sessionId,
        "userID": userId,
      };
      final result =
          await api.get(BackendUrls.loadRoadmap, queryParams: params);
      if (result.containsKey('error')) {
        throw Exception("Error del servidor: \\${result['error']}");
      }
      return result;
    } catch (e) {
      throw Exception("Error al cargar el roadmap: $e");
    }
  }

  @override
  Future<void> updateRoadmap(
      String sessionId, String userId, Map<String, dynamic> roadmapJson) async {
    try {
      final jsonToSend = {
        "sessionID": sessionId,
        "userID": userId,
        ...roadmapJson,
      };
      final result = await api.post(BackendUrls.saveRoadmap, jsonToSend);
      if (result.containsKey('error')) {
        throw Exception("Error del servidor: \\${result['error']}");
      }
    } catch (e) {
      throw Exception("Error al actualizar el roadmap: $e");
    }
  }
}
