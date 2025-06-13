import 'package:flutter/material.dart';
import 'package:ia_web_front/features/content_list/data/models/website_model.dart';

class ContentCardTableItem extends StatelessWidget {
  final ContentCardModel contentCard;
  final VoidCallback onTap; // Asume que tienes este modelo

  const ContentCardTableItem(
      {super.key, required this.contentCard, required this.onTap});

  @override
  Widget build(BuildContext context) {
    int? getLowestPositionKeyword(List<Topics>? topics) {
      if (topics == null || topics.isEmpty) return null;
      final lowestTopic = topics.reduce((a, b) =>
          (a.position ?? double.infinity) < (b.position ?? double.infinity)
              ? a
              : b);
      return lowestTopic.position;
    }

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

          // Columna 2: Keywords
          Expanded(
            child: Wrap(
              spacing: 2,
              runSpacing: 5,
              children: contentCard.topics
                      ?.map(
                        (topic) => Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 2),
                          decoration: BoxDecoration(
                            color: topic.position ==
                                    getLowestPositionKeyword(contentCard.topics)
                                ? Colors.green.shade50
                                : Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            topic.keyWord,
                            style: TextStyle(
                              fontSize: 10,
                              color: topic.position ==
                                      getLowestPositionKeyword(
                                          contentCard.topics)
                                  ? Colors.green // Resaltar en verde
                                  : Colors.blue.shade800,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      )
                      .toList() ??
                  [
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

          // Columna 3: Position
          Expanded(
            child: Text(
              '${getLowestPositionKeyword(contentCard.topics)}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: onTap,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: contentCard.status == InspectedWebsiteStatus.Done
                          ? Colors.green.shade100
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      contentCard.status == InspectedWebsiteStatus.Done
                          ? 'Done'
                          : 'Mark Done',
                      style: TextStyle(
                        color: contentCard.status == InspectedWebsiteStatus.Done
                            ? Colors.green
                            : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        // Implementar lógica de edición
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        // Implementar lógica de eliminación
                      },
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
