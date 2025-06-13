import 'package:ia_web_front/features/roadmap/domain/repository/roadmap_repo.dart';

class SaveRoadmap {
  final RoadmapRepo repository;

  SaveRoadmap(this.repository);
  Future<void> execute(
      String sessionId, String userId, Map<String, dynamic> roadmapJson) async {
    await repository.saveRoadmap(sessionId, userId, roadmapJson);
  }
}
