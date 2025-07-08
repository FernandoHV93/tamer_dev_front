class VoiceEvaluationSectionEntity {
  final String indicators;
  final String feedback;
  final String evolve;
  final String adjustments;

  VoiceEvaluationSectionEntity({
    required this.indicators,
    required this.feedback,
    required this.evolve,
    required this.adjustments,
  });

  factory VoiceEvaluationSectionEntity.fromJson(Map<String, dynamic> json) =>
      VoiceEvaluationSectionEntity(
        indicators: json['indicators'] ?? '',
        feedback: json['feedback'] ?? '',
        evolve: json['evolve'] ?? '',
        adjustments: json['adjustments'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'indicators': indicators,
        'feedback': feedback,
        'evolve': evolve,
        'adjustments': adjustments,
      };
}
