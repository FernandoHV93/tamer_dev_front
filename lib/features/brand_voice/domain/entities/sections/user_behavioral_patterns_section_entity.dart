class UserBehavioralPatternsSectionEntity {
  final String patterns;

  UserBehavioralPatternsSectionEntity({
    required this.patterns,
  });

  factory UserBehavioralPatternsSectionEntity.fromJson(
          Map<String, dynamic> json) =>
      UserBehavioralPatternsSectionEntity(
        patterns: json['patterns'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'patterns': patterns,
      };
}
