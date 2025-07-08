class ToneAndStyleSectionEntity {
  final String? selectedFormality;
  final String? selectedSeriousness;
  final String vocabulary;
  final String badNews;
  final String platformTone;

  ToneAndStyleSectionEntity({
    required this.selectedFormality,
    required this.selectedSeriousness,
    required this.vocabulary,
    required this.badNews,
    required this.platformTone,
  });

  factory ToneAndStyleSectionEntity.fromJson(Map<String, dynamic> json) =>
      ToneAndStyleSectionEntity(
        selectedFormality: json['selectedFormality'],
        selectedSeriousness: json['selectedSeriousness'],
        vocabulary: json['vocabulary'] ?? '',
        badNews: json['badNews'] ?? '',
        platformTone: json['platformTone'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'selectedFormality': selectedFormality,
        'selectedSeriousness': selectedSeriousness,
        'vocabulary': vocabulary,
        'badNews': badNews,
        'platformTone': platformTone,
      };
}
