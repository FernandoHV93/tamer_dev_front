class BrandDimensionsSectionEntity {
  final String sincerity;
  final String emotional;
  final String competence;
  final String sophistication;
  final String robust;

  BrandDimensionsSectionEntity({
    required this.sincerity,
    required this.emotional,
    required this.competence,
    required this.sophistication,
    required this.robust,
  });

  factory BrandDimensionsSectionEntity.fromJson(Map<String, dynamic> json) =>
      BrandDimensionsSectionEntity(
        sincerity: json['sincerity'] ?? '',
        emotional: json['emotional'] ?? '',
        competence: json['competence'] ?? '',
        sophistication: json['sophistication'] ?? '',
        robust: json['robust'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'sincerity': sincerity,
        'emotional': emotional,
        'competence': competence,
        'sophistication': sophistication,
        'robust': robust,
      };
}
