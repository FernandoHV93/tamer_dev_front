enum WebsiteStatus {
  Active,
  Inactive,
}

class Website {
  final WebsiteStatus status;
  final String url;
  final String name;
  final DateTime? lastChecked;
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
      'lastChecked': lastChecked?.toIso8601String(),
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
      lastChecked: map['lastChecked'] != null
          ? DateTime.parse(map['lastChecked'])
          : null,
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

  Topics({
    this.position,
    this.volume,
    this.kd,
    this.categories,
    this.tags,
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
      'kd': kd,
      'categories': categories,
      'tags': tags,
      'date': date,
      'score': score,
      'words': words,
      'schemas': schemas,
      'status': status.name,
      'position': position,
      'volume': volume
    };
  }

  // Método para crear objeto desde Map
  factory Topics.fromMap(Map<String, dynamic> map) {
    return Topics(
      keyWord: map['keyWord'] ?? '',
      position: map['position'] ?? 0,
      volume: map['volume'] ?? 0,
      kd: map['kd'] ?? '',
      categories: map['categories'] ?? '',
      tags: map['tags'] ?? '',
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

  Topics copyWith(
      {String? keyWord,
      String? date,
      String? score,
      String? words,
      String? schemas,
      int? volume,
      TopicStatus? status,
      int? position}) {
    return Topics(
        keyWord: keyWord ?? this.keyWord,
        date: date ?? this.date,
        score: score ?? this.score,
        words: words ?? this.words,
        schemas: schemas ?? this.schemas,
        status: status ?? this.status,
        position: position ?? this.position,
        volume: volume ?? this.volume);
  }
}

class ContentCardModel {
  final String title;
  final String? url;
  final InspectedWebsiteStatus? status;
  final int keyWordsScore;
  final List<Topics>? topics;

  ContentCardModel({
    required this.title,
    this.url,
    this.status,
    required this.keyWordsScore,
    this.topics,
  });

  // Método para convertir a Map
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'keyWordsScore': keyWordsScore,
      'url': url,
      'status': status.toString(),
      'topics': topics?.map((topic) => topic.toMap()).toList() ?? [],
    };
  }

  // Método para crear objeto desde Map
  factory ContentCardModel.fromMap(Map<String, dynamic> map) {
    return ContentCardModel(
      title: map['title'] ?? '',
      url: map['url'] ?? '',
      status: map['status'] != null ? _statusFromString(map['status']) : null,
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
      keyWordsScore: keyWordsScore ?? this.keyWordsScore,
      topics: topics ?? this.topics,
    );
  }

  static InspectedWebsiteStatus _statusFromString(String value) {
    switch (value) {
      case 'Done':
        return InspectedWebsiteStatus.Done;
      case 'NoDone':
        return InspectedWebsiteStatus.NoDone;
      default:
        throw Exception("Unknown InspectedWebsiteStatus: $value");
    }
  }
}

enum TopicStatus {
  Covered,
  Draft,
  Initiated,
}

enum InspectedWebsiteStatus { Done, NoDone }

class InspectedWebsite {
  final Website website;
  final int rankTop10Keywords;
  final int top10PositionScaled;
  final int rankTop3Keywords;
  final int top3PositionScaled;
  final int rankTop100Keywords;
  final int top100PositionScaled;

  InspectedWebsite({
    required this.website,
    required this.rankTop10Keywords,
    required this.rankTop100Keywords,
    required this.rankTop3Keywords,
    required this.top10PositionScaled,
    required this.top3PositionScaled,
    required this.top100PositionScaled,
  });

  factory InspectedWebsite.fromMap(Map<String, dynamic> map) {
    return InspectedWebsite(
      website: Website.fromMap(map['root']),
      rankTop10Keywords: map['rankTop10Keywords'],
      top10PositionScaled: map['top10PositionScaled'],
      rankTop3Keywords: map['rankTop3Keywords'],
      rankTop100Keywords: map['rankTop100Keywords'],
      top3PositionScaled: map['top3PositionScaled'],
      top100PositionScaled: map['top100PositionScaled'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'inspectedWebsite': website.toMap(),
      'rankTop10Keywords': rankTop10Keywords,
      'rankTop3Keywords': rankTop3Keywords,
      'rankTop100Keywords': rankTop100Keywords,
      'top3PositionScaled': top3PositionScaled,
      'top10PositionScaled': top10PositionScaled,
      'top100PositionScaled': top100PositionScaled,
    };
  }
}

enum TypeSearchIntent { I, C, T }

class CompetitorWebsiteAnalysis {
  final List<KeywordsCompetitor> keywords;

  CompetitorWebsiteAnalysis({
    required this.keywords,
  });

  factory CompetitorWebsiteAnalysis.fromMap(Map<String, dynamic> map) {
    return CompetitorWebsiteAnalysis(
      keywords: (map['keywords'] as List<dynamic>?)
              ?.map((keywordMap) => KeywordsCompetitor.fromMap(keywordMap))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'keywords': keywords.map((keyword) => keyword.toMap()).toList(),
    };
  }
}

class KeywordsCompetitor {
  final List<String> keyword;
  final int volume;
  final int kd;
  final TypeSearchIntent typeSearchIntent;

  KeywordsCompetitor({
    required this.keyword,
    required this.volume,
    required this.kd,
    required this.typeSearchIntent,
  });

  factory KeywordsCompetitor.fromMap(Map<String, dynamic> map) {
    return KeywordsCompetitor(
      keyword: List<String>.from(map['keyword'] ?? []),
      volume: map['volume'] ?? 0,
      kd: map['kd'] ?? 0,
      typeSearchIntent: _intentFromString(map['typeSearchIntent']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'keyword': keyword,
      'volume': volume,
      'kd': kd,
      'typeSearchIntent': typeSearchIntent.name,
    };
  }

  static TypeSearchIntent _intentFromString(String value) {
    switch (value) {
      case 'I':
        return TypeSearchIntent.I;
      case 'C':
        return TypeSearchIntent.C;
      case 'T':
        return TypeSearchIntent.T;
      default:
        throw Exception("Unknown TypeSearchIntent: $value");
    }
  }
}
