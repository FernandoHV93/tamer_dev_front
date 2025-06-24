class KeywordAnalysisResult {
  final Map<String, int> headings; // Ej: {'H2': 5, 'H3': 8}
  final String searchIntent; // 'T', 'N', 'C', 'I'
  final double keywordDifficultyPercent; // Ej: 0.0, 20.0, 40.0, etc.
  final String keywordDifficultyLabel; // 'Very Easy', 'Easy', etc.
  final Map<String, int> media; // {'Images': 6, 'Videos': 1}
  final Map<String, int> content; // {'Words': 1500, 'Paragraphs': 15}

  KeywordAnalysisResult({
    required this.headings,
    required this.searchIntent,
    required this.keywordDifficultyPercent,
    required this.keywordDifficultyLabel,
    required this.media,
    required this.content,
  });
}
