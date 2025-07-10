enum TopicStatus { covered, draft, initiated }

class TopicEntity {
  final String id;
  final String cardId;
  final String keyWord;
  final String? kd;
  final String? categories;
  final String date;
  final String? tags;
  final String? score;
  final String? words;
  final String? schemas;
  final TopicStatus status;
  final int? position;
  final int? volume;

  TopicEntity({
    required this.id,
    required this.cardId,
    required this.keyWord,
    this.kd,
    this.categories,
    required this.date,
    this.tags,
    this.score,
    this.words,
    this.schemas,
    required this.status,
    this.position,
    this.volume,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cardId': cardId,
      'keyWord': keyWord,
      'kd': kd,
      'categories': categories,
      'date': date,
      'tags': tags,
      'score': score,
      'words': words,
      'schemas': schemas,
      'status': status.name,
      'position': position,
      'volume': volume,
    };
  }

  factory TopicEntity.fromJson(Map<String, dynamic> json) {
    return TopicEntity(
      id: json['id'] as String,
      cardId: json['card_id'] as String,
      keyWord: json['keyWord'] as String,
      kd: json['kd'] as String?,
      categories: json['categories'] as String?,
      date: json['date'] as String,
      tags: json['tags'] as String?,
      score: json['score'] as String?,
      words: json['words'] as String?,
      schemas: json['schemas'] as String?,
      status: TopicStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => TopicStatus.initiated,
      ),
      position: json['position'] as int?,
      volume: json['volume'] as int?,
    );
  }
}
