class CompetitorAnalysisSectionEntity {
  final String communication;
  final String selectedTone;
  final List<String> personality;
  final String brandDifference;
  final String brandPerception;
  final String voiceStrategy;

  CompetitorAnalysisSectionEntity({
    required this.communication,
    required this.selectedTone,
    required this.personality,
    required this.brandDifference,
    required this.brandPerception,
    required this.voiceStrategy,
  });

  factory CompetitorAnalysisSectionEntity.fromJson(Map<String, dynamic> json) =>
      CompetitorAnalysisSectionEntity(
        communication: json['communication'] ?? '',
        selectedTone: json['selectedTone'] ?? '',
        personality: List<String>.from(json['personality'] ?? []),
        brandDifference: json['brandDifference'] ?? '',
        brandPerception: json['brandPerception'] ?? '',
        voiceStrategy: json['voiceStrategy'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'communication': communication,
        'selectedTone': selectedTone,
        'personality': personality,
        'brandDifference': brandDifference,
        'brandPerception': brandPerception,
        'voiceStrategy': voiceStrategy,
      };
}
