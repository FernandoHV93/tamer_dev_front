import 'package:ia_web_front/features/roadmap/domain/repository/roadmap_repo.dart';

class RoadmapRepoImpl implements RoadmapRepo {
  @override
  Future<void> saveRoadmap(
      String sessionId, String userId, Map<String, dynamic> roadmaPJson) async {
    //TO DO
  }

  @override
  Future<Map<String, dynamic>> loadRoadmap(
      String sessionId, String userId) async {
    //TO DO
    return {'roadmap': []};
  }

  @override
  Future<void> updateRoadmap(
      String sessionId, String userId, Map<String, dynamic> roadmapJson) async {
    //TO DO
  }
}
