class MotivationsAndValuesSectionEntity {
  final String motivation;

  MotivationsAndValuesSectionEntity({
    required this.motivation,
  });

  factory MotivationsAndValuesSectionEntity.fromJson(
          Map<String, dynamic> json) =>
      MotivationsAndValuesSectionEntity(
        motivation: json['motivation'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'motivation': motivation,
      };
}
