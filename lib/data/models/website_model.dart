enum WebsiteStatus {
  Active,
  Inactive,
}

class Website {
  final WebsiteStatus status;
  final String url;
  final String name;
  final DateTime lastChecked;
  final List<ContentCardModel>? contentCards;

  Website({
    required this.status,
    required this.url,
    required this.name,
    required this.lastChecked,
    this.contentCards,
  });

  // Método para convertir a Map (útil para Firebase/persistencia)
  Map<String, dynamic> toMap() {
    return {
      'status': status.name,
      'url': url,
      'name': name,
      'lastChecked': lastChecked.toIso8601String(),
      'contentCards': contentCards?.map((card) => card.toMap()).toList(),
    };
  }

  // Método para crear objeto desde Map
  factory Website.fromMap(Map<String, dynamic> map) {
    return Website(
      status: WebsiteStatus.values.firstWhere(
        (e) => e.name == map['status'],
        orElse: () => WebsiteStatus.Active,
      ),
      url: map['url'] ?? '',
      name: map['name'] ?? '',
      lastChecked: DateTime.parse(map['lastChecked']),
      contentCards: (map['contentCards'] as List<dynamic>?)
              ?.map((cardMap) => ContentCardModel.fromMap(cardMap))
              .toList() ??
          [],
    );
  }

  // Método para copiar con valores modificados (opcional)
  Website copyWith({
    WebsiteStatus? status,
    String? url,
    String? name,
    DateTime? lastChecked,
    List<ContentCardModel>? contentCards,
  }) {
    return Website(
      status: status ?? this.status,
      url: url ?? this.url,
      name: name ?? this.name,
      lastChecked: lastChecked ?? this.lastChecked,
      contentCards: contentCards ?? this.contentCards,
    );
  }
}

class Topics {
  final String keyWord;
  final String date;
  final String? score;
  final String? words;
  final String? schemas;
  final TopicStatus status;

  Topics({
    required this.keyWord,
    required this.date,
    this.score,
    this.words,
    this.schemas,
    required this.status,
  });

  // Método para convertir a Map
  Map<String, dynamic> toMap() {
    return {
      'keyWord': keyWord,
      'date': date,
      'score': score,
      'words': words,
      'schemas': schemas,
      'status': status.name,
    };
  }

  // Método para crear objeto desde Map
  factory Topics.fromMap(Map<String, dynamic> map) {
    return Topics(
      keyWord: map['keyWord'] ?? '',
      date: map['date'] ?? '',
      score: map['score'],
      words: map['words'],
      schemas: map['schemas'],
      status: TopicStatus.values.firstWhere(
        (e) => e.name == map['status'],
        orElse: () => TopicStatus.Initiated,
      ),
    );
  }

  Topics copyWith({
    String? keyWord,
    String? date,
    String? score,
    String? words,
    String? schemas,
    TopicStatus? status,
  }) {
    return Topics(
      keyWord: keyWord ?? this.keyWord,
      date: date ?? this.date,
      score: score ?? this.score,
      words: words ?? this.words,
      schemas: schemas ?? this.schemas,
      status: status ?? this.status,
    );
  }
}

class ContentCardModel {
  final String title;
  final int volume;
  final int keyWordsScore;
  final List<Topics>? topics;

  ContentCardModel({
    required this.title,
    required this.volume,
    required this.keyWordsScore,
    this.topics,
  });

  // Método para convertir a Map
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'volume': volume,
      'keyWordsScore': keyWordsScore,
      'topics': topics?.map((topic) => topic.toMap()).toList() ?? [],
    };
  }

  // Método para crear objeto desde Map
  factory ContentCardModel.fromMap(Map<String, dynamic> map) {
    return ContentCardModel(
      title: map['title'] ?? '',
      volume: map['volume'] ?? 0,
      keyWordsScore: map['keyWordsScore'] ?? 0,
      topics: (map['topics'] as List<dynamic>?)
              ?.map((topicMap) => Topics.fromMap(topicMap))
              .toList() ??
          [],
    );
  }

  ContentCardModel copyWith({
    String? title,
    int? volume,
    int? keyWordsScore,
    int? completition,
    List<Topics>? topics,
  }) {
    return ContentCardModel(
      title: title ?? this.title,
      volume: volume ?? this.volume,
      keyWordsScore: keyWordsScore ?? this.keyWordsScore,
      topics: topics ?? this.topics,
    );
  }
}

enum TopicStatus {
  Covered,
  Draft,
  Initiated,
}
