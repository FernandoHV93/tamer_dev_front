class AudienceExpectationsSectionEntity {
  final String expectations;

  AudienceExpectationsSectionEntity({
    required this.expectations,
  });

  factory AudienceExpectationsSectionEntity.fromJson(
          Map<String, dynamic> json) =>
      AudienceExpectationsSectionEntity(
        expectations: json['expectations'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'expectations': expectations,
      };
}
