import 'package:flutter/material.dart';
import 'package:ia_web_front/features/article_builder/domain/entities/keyword_analysis_result.dart';

class KeywordAnalysisResultCard extends StatelessWidget {
  final KeywordAnalysisResult result;
  const KeywordAnalysisResultCard({super.key, required this.result});

  Color _getIntentBgColor(String intent) {
    switch (intent.toLowerCase()) {
      case 'c':
        return const Color(0xFFFFE0B2); // naranja claro
      case 'i':
        return const Color(0xFFB3E5FC); // azul claro
      case 'n':
        return const Color(0xFFE1BEE7); // morado claro
      case 't':
        return const Color(0xFFC8E6C9); // verde claro
      default:
        return Colors.grey.shade300;
    }
  }

  Color _getIntentTextColor(String intent) {
    switch (intent.toLowerCase()) {
      case 'c':
        return const Color(0xFFF57C00); // naranja oscuro
      case 'i':
        return const Color(0xFF0288D1); // azul oscuro
      case 'n':
        return const Color(0xFF8E24AA); // morado oscuro
      case 't':
        return const Color(0xFF388E3C); // verde oscuro
      default:
        return Colors.black87;
    }
  }

  @override
  Widget build(BuildContext context) {
    final headings = result.headings.entries.where((e) => e.value > 0).toList();
    final media = result.media.entries.where((e) => e.value > 0).toList();
    final content = result.content.entries.where((e) => e.value > 0).toList();
    Color kwColor = Colors.tealAccent;
    if (result.keywordDifficultyPercent < 20)
      kwColor = Colors.tealAccent;
    else if (result.keywordDifficultyPercent < 40)
      kwColor = Colors.greenAccent;
    else if (result.keywordDifficultyPercent < 60)
      kwColor = Colors.yellowAccent;
    else if (result.keywordDifficultyPercent < 80)
      kwColor = Colors.orangeAccent;
    else
      kwColor = Colors.redAccent;

    // Obtener la letra de search intent (C, I, N, T)
    String intentLetter = result.searchIntent.isNotEmpty
        ? result.searchIntent[0].toUpperCase()
        : '?';
    Color intentBgColor = _getIntentBgColor(intentLetter);
    Color intentTextColor = _getIntentTextColor(intentLetter);

    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF232733),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          // Primera fila: Search Intent y KW Difficulty
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text('Search Intent:',
                      style: TextStyle(
                          color: Colors.white70, fontWeight: FontWeight.w600)),
                  const SizedBox(width: 6),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: intentBgColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      intentLetter,
                      style: TextStyle(
                        color: intentTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text('KW Difficulty: ',
                      style: TextStyle(
                          color: Colors.white70, fontWeight: FontWeight.w600)),
                  Text(
                    result.keywordDifficultyLabel +
                        ' (${result.keywordDifficultyPercent.toStringAsFixed(0)}%)',
                    style:
                        TextStyle(color: kwColor, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 18),
          // Segunda fila: Headings, Media, Content
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Headings
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Headings',
                      style: TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.w700,
                          fontSize: 15),
                    ),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 12,
                      children: headings
                          .map((e) => Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '${e.key}: ',
                                    style: const TextStyle(
                                        color: Color(0xFF40C4FF), // Azul claro
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '${e.value}',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              // Media
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Media',
                      style: TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.w700,
                          fontSize: 15),
                    ),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 12,
                      children: media
                          .map((e) => Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '${e.key}: ',
                                    style: const TextStyle(
                                        color: Color(0xFF40C4FF),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '${e.value}',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Content',
                      style: TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.w700,
                          fontSize: 15),
                    ),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 12,
                      children: content
                          .map((e) => Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '${e.key}: ',
                                    style: const TextStyle(
                                        color: Color(0xFF40C4FF),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '${e.value}',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
