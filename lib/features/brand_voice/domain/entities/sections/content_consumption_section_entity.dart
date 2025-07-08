class ContentConsumptionSectionEntity {
  final String contentType;
  final List<String> channels;

  ContentConsumptionSectionEntity({
    required this.contentType,
    required this.channels,
  });

  factory ContentConsumptionSectionEntity.fromJson(Map<String, dynamic> json) =>
      ContentConsumptionSectionEntity(
        contentType: json['contentType'] ?? '',
        channels: List<String>.from(json['channels'] ?? []),
      );

  Map<String, dynamic> toJson() => {
        'contentType': contentType,
        'channels': channels,
      };
}
