class FearsFrustrationsObstaclesSectionEntity {
  final String fears;
  final String frustrations;
  final String obstacles;

  FearsFrustrationsObstaclesSectionEntity({
    required this.fears,
    required this.frustrations,
    required this.obstacles,
  });

  factory FearsFrustrationsObstaclesSectionEntity.fromJson(
          Map<String, dynamic> json) =>
      FearsFrustrationsObstaclesSectionEntity(
        fears: json['fears'] ?? '',
        frustrations: json['frustrations'] ?? '',
        obstacles: json['obstacles'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'fears': fears,
        'frustrations': frustrations,
        'obstacles': obstacles,
      };
}
