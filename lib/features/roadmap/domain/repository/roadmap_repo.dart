abstract class RoadmapRepo {
  Future<void> saveRoadmap(
      String sessionId, String userId, Map<String, dynamic> roadmapJson);

  Future<Map<String, dynamic>> loadRoadmap(String sessionId, String userId);

  Future<void> updateRoadmap(
      String sessionId, String userId, Map<String, dynamic> roadmapJson);
}
