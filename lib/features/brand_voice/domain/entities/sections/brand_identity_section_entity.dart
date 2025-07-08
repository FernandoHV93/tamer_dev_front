class BrandIdentitySectionEntity {
  final String vision;
  final String mission;
  final String coreValues;
  final String alignValues;
  final String problem;
  final String impact;

  BrandIdentitySectionEntity({
    required this.vision,
    required this.mission,
    required this.coreValues,
    required this.alignValues,
    required this.problem,
    required this.impact,
  });

  factory BrandIdentitySectionEntity.fromJson(Map<String, dynamic> json) =>
      BrandIdentitySectionEntity(
        vision: json['vision'] ?? '',
        mission: json['mission'] ?? '',
        coreValues: json['coreValues'] ?? '',
        alignValues: json['alignValues'] ?? '',
        problem: json['problem'] ?? '',
        impact: json['impact'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'vision': vision,
        'mission': mission,
        'coreValues': coreValues,
        'alignValues': alignValues,
        'problem': problem,
        'impact': impact,
      };
}
