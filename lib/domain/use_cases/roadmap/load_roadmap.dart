import 'package:ia_web_front/domain/repository/roadmap_repo.dart';

class LoadRoadmap {
  final RoadmapRepo repository;

  LoadRoadmap(this.repository);
  Future<Map<String, dynamic>> execute(String sessionId, String userId) async {
    return await repository.loadRoadmap(sessionId, userId);
  }
}
