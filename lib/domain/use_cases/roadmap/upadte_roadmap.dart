import 'package:ia_web_front/domain/repository/roadmap_repo.dart';

class UpadteRoadmap {
  final RoadmapRepo repository;

  UpadteRoadmap(this.repository);
  Future<void> execute(
      String sessionId, String userId, Map<String, dynamic> roadmapJson) async {
    await repository.updateRoadmap(sessionId, userId, roadmapJson);
  }
}
