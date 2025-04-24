class RoadmapModel {
  final int sessionId;
  final List<RoadmapItemModel> roadmapDescription;

  RoadmapModel({
    required this.sessionId,
    required this.roadmapDescription,
  });

  Map<String, dynamic> toJson() {
    return {
      'session_id': sessionId,
      'roadmap_description':
          roadmapDescription.map((item) => item.toJson()).toList(),
    };
  }
}

class RoadmapItemModel {
  final String blockId;
  final String keyword;
  final String description;
  final List<String> connections;
  final Map<String, String> context;

  RoadmapItemModel(
      {required this.blockId,
      required this.keyword,
      required this.description,
      required this.connections,
      required this.context});

  Map<String, dynamic> toJson() {
    return {
      'id': blockId,
      'title': keyword,
      'description': description,
      'parameters': context,
      'connections': connections,
    };
  }
}
