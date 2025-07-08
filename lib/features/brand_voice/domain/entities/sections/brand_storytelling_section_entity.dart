class BrandStorytellingSectionEntity {
  final String centralStory;
  final String narrativeElements;
  final String humanRelatable;

  BrandStorytellingSectionEntity({
    required this.centralStory,
    required this.narrativeElements,
    required this.humanRelatable,
  });

  factory BrandStorytellingSectionEntity.fromJson(Map<String, dynamic> json) =>
      BrandStorytellingSectionEntity(
        centralStory: json['centralStory'] ?? '',
        narrativeElements: json['narrativeElements'] ?? '',
        humanRelatable: json['humanRelatable'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'centralStory': centralStory,
        'narrativeElements': narrativeElements,
        'humanRelatable': humanRelatable,
      };
}
