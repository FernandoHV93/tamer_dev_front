class ToneAndLanguageSectionEntity {
  final String tone;
  final String describeProblems;
  final String brandHelp;

  ToneAndLanguageSectionEntity({
    required this.tone,
    required this.describeProblems,
    required this.brandHelp,
  });

  factory ToneAndLanguageSectionEntity.fromJson(Map<String, dynamic> json) =>
      ToneAndLanguageSectionEntity(
        tone: json['tone'] ?? '',
        describeProblems: json['describeProblems'] ?? '',
        brandHelp: json['brandHelp'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'tone': tone,
        'describeProblems': describeProblems,
        'brandHelp': brandHelp,
      };
}
