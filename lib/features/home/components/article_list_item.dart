import 'package:flutter/material.dart';
import '../entities/preview_article_entity.dart';

class ArticleListItem extends StatelessWidget {
  final PreviewArticleEntity preview;
  final VoidCallback onView;
  final bool isGenerating;

  const ArticleListItem({
    super.key,
    required this.preview,
    required this.onView,
    this.isGenerating = false,
  });

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        '${_monthAbbr(preview.date.month)} ${preview.date.day}, ${_formatHour(preview.date)}';
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF232733),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Título
          Expanded(
            child: Text(
              preview.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          // Score
          Container(
            margin: const EdgeInsets.only(left: 8, right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.greenAccent),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              preview.score.toString(),
              style: const TextStyle(
                color: Colors.greenAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Fecha
          Text(
            formattedDate,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(width: 16),
          // Palabras
          Text(
            '${preview.wordCount} words',
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(width: 16),
          // Botón View
          ElevatedButton(
            onPressed: isGenerating ? null : onView,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2563EB),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              isGenerating ? 'Generating...' : 'View',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  String _monthAbbr(int month) {
    const months = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month];
  }

  String _formatHour(DateTime date) {
    int hour = date.hour;
    String ampm = hour >= 12 ? 'pm' : 'am';
    hour = hour % 12;
    if (hour == 0) hour = 12;
    String minute = date.minute.toString().padLeft(2, '0');
    return '$hour:$minute $ampm';
  }
}
