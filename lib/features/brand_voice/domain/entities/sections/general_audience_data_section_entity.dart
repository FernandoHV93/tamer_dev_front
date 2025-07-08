class GeneralAudienceDataSectionEntity {
  final String? averageAge;
  final List<String> generations;
  final String? predominantGender;
  final String? educationLevel;
  final String occupation;

  GeneralAudienceDataSectionEntity({
    this.averageAge,
    required this.generations,
    this.predominantGender,
    this.educationLevel,
    required this.occupation,
  });

  factory GeneralAudienceDataSectionEntity.fromJson(
          Map<String, dynamic> json) =>
      GeneralAudienceDataSectionEntity(
        averageAge: json['averageAge'] as String?,
        generations: List<String>.from(json['generations'] ?? []),
        predominantGender: json['predominantGender'] as String?,
        educationLevel: json['educationLevel'] as String?,
        occupation: json['occupation'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'averageAge': averageAge,
        'generations': generations,
        'predominantGender': predominantGender,
        'educationLevel': educationLevel,
        'occupation': occupation,
      };
}
