import 'package:flutter/material.dart';
import 'package:ia_web_front/features/content/domain/entities/content_card_entity.dart';
import 'package:ia_web_front/features/content/domain/entities/topic_entity.dart';

class ContentCardEntityTableItem extends StatelessWidget {
  final ContentCardEntity contentCard;
  final List<TopicEntity> topics;
  final VoidCallback? onTap;
  const ContentCardEntityTableItem({
    super.key,
    required this.contentCard,
    required this.topics,
    this.onTap,
  });

  int? getLowestPosition(List<TopicEntity> topics) {
    if (topics.isEmpty) return null;
    return topics
        .map((t) => t.position ?? 99999)
        .reduce((a, b) => a < b ? a : b);
  }

  @override
  Widget build(BuildContext context) {
    final lowestPosition = getLowestPosition(topics);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1,
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Columna 1: Title & URL
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  contentCard.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  contentCard.url ?? 'no URL',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          // Columna 2: Keywords (topics)
          Expanded(
            child: Wrap(
              spacing: 2,
              runSpacing: 5,
              children: topics.isNotEmpty
                  ? topics.map((topic) {
                      final isLowest =
                          (topic.position ?? 99999) == lowestPosition;
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: isLowest
                              ? Colors.green.shade50
                              : Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          topic.keyWord,
                          style: TextStyle(
                            fontSize: 10,
                            color:
                                isLowest ? Colors.green : Colors.blue.shade800,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList()
                  : [
                      Text(
                        'Sin keywords',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
            ),
          ),
          // Columna 3: Position (menor posición de los topics)
          Expanded(
            child: Text(
              lowestPosition != null && lowestPosition != 99999
                  ? '$lowestPosition'
                  : '-',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
          ),
          // Columna 4: Acción
          if (onTap != null)
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.info_outline),
                    onPressed: onTap,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
