class FundamentalValuesSectionEntity {
  final String meaning;
  final String essential;
  final String convey;

  FundamentalValuesSectionEntity({
    required this.meaning,
    required this.essential,
    required this.convey,
  });

  factory FundamentalValuesSectionEntity.fromJson(Map<String, dynamic> json) =>
      FundamentalValuesSectionEntity(
        meaning: json['meaning'] ?? '',
        essential: json['essential'] ?? '',
        convey: json['convey'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'meaning': meaning,
        'essential': essential,
        'convey': convey,
      };
}
