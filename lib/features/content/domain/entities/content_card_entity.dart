enum ContentCardStatus { ready, notReady }

class ContentCardEntity {
  final String id;
  final String websiteId;
  final String title;
  final String? url;
  final int keyWordsScore;
  final ContentCardStatus status;

  ContentCardEntity({
    required this.id,
    required this.websiteId,
    required this.title,
    this.url,
    required this.keyWordsScore,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'websiteId': websiteId,
      'title': title,
      'url': url,
      'keyWordsScore': keyWordsScore,
      'status': status.name,
    };
  }

  factory ContentCardEntity.fromJson(Map<String, dynamic> json) {
    return ContentCardEntity(
      id: json['id'] as String,
      websiteId: json['websiteId'] as String,
      title: json['title'] as String,
      url: json['url'] as String?,
      keyWordsScore: json['keyWordsScore'] as int,
      status: ContentCardStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => ContentCardStatus.notReady,
      ),
    );
  }
}
