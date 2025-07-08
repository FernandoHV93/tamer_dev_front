class BrandVoiceGuideSectionEntity {
  final String expressions;
  final String avoid;
  final String criticism;
  final String gratitude;
  final String digitalVsPrint;

  BrandVoiceGuideSectionEntity({
    required this.expressions,
    required this.avoid,
    required this.criticism,
    required this.gratitude,
    required this.digitalVsPrint,
  });

  factory BrandVoiceGuideSectionEntity.fromJson(Map<String, dynamic> json) =>
      BrandVoiceGuideSectionEntity(
        expressions: json['expressions'] ?? '',
        avoid: json['avoid'] ?? '',
        criticism: json['criticism'] ?? '',
        gratitude: json['gratitude'] ?? '',
        digitalVsPrint: json['digitalVsPrint'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'expressions': expressions,
        'avoid': avoid,
        'criticism': criticism,
        'gratitude': gratitude,
        'digitalVsPrint': digitalVsPrint,
      };
}
