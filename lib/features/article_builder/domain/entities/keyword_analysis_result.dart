class KeywordAnalysisResult {
  final Map<String, int> headings;
  final String searchIntent;
  final double keywordDifficultyPercent;
  final String keywordDifficultyLabel;
  final Map<String, int> media;
  final Map<String, int> content;

  KeywordAnalysisResult({
    required this.headings,
    required this.searchIntent,
    required this.keywordDifficultyPercent,
    required this.keywordDifficultyLabel,
    required this.media,
    required this.content,
  });

  factory KeywordAnalysisResult.fromJson(Map<String, dynamic> json) {
    return KeywordAnalysisResult(
      headings: Map<String, int>.from(json['headings']),
      searchIntent: json['searchIntent'],
      keywordDifficultyPercent: json['keywordDifficultyPercent'].toDouble(),
      keywordDifficultyLabel: json['keywordDifficultyLabel'],
      media: Map<String, int>.from(json['media']),
      content: Map<String, int>.from(json['content']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'headings': headings,
      'searchIntent': searchIntent,
      'keywordDifficultyPercent': keywordDifficultyPercent,
      'keywordDifficultyLabel': keywordDifficultyLabel,
      'media': media,
      'content': content,
    };
  }
}
