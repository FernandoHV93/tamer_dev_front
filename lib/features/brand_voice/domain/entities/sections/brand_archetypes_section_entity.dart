class BrandArchetypesSectionEntity {
  final String? selectedArchetype;
  final String motivation;
  final String emotionalConnection;
  final String emotionsToEvoke;
  final String combineArchetypes;

  BrandArchetypesSectionEntity({
    required this.selectedArchetype,
    required this.motivation,
    required this.emotionalConnection,
    required this.emotionsToEvoke,
    required this.combineArchetypes,
  });

  factory BrandArchetypesSectionEntity.fromJson(Map<String, dynamic> json) =>
      BrandArchetypesSectionEntity(
        selectedArchetype: json['selectedArchetype'],
        motivation: json['motivation'] ?? '',
        emotionalConnection: json['emotionalConnection'] ?? '',
        emotionsToEvoke: json['emotionsToEvoke'] ?? '',
        combineArchetypes: json['combineArchetypes'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'selectedArchetype': selectedArchetype,
        'motivation': motivation,
        'emotionalConnection': emotionalConnection,
        'emotionsToEvoke': emotionsToEvoke,
        'combineArchetypes': combineArchetypes,
      };
}
