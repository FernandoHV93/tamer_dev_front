class DesiredUserBehaviorSectionEntity {
  final String honest;
  final String friendly;
  final String valued;

  DesiredUserBehaviorSectionEntity({
    required this.honest,
    required this.friendly,
    required this.valued,
  });

  factory DesiredUserBehaviorSectionEntity.fromJson(
          Map<String, dynamic> json) =>
      DesiredUserBehaviorSectionEntity(
        honest: json['honest'] ?? '',
        friendly: json['friendly'] ?? '',
        valued: json['valued'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'honest': honest,
        'friendly': friendly,
        'valued': valued,
      };
}
