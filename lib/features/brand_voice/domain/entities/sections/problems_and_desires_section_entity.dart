class ProblemsAndDesiresSectionEntity {
  final String problems;
  final String desires;

  ProblemsAndDesiresSectionEntity({
    required this.problems,
    required this.desires,
  });

  factory ProblemsAndDesiresSectionEntity.fromJson(Map<String, dynamic> json) =>
      ProblemsAndDesiresSectionEntity(
        problems: json['problems'] ?? '',
        desires: json['desires'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'problems': problems,
        'desires': desires,
      };
}
