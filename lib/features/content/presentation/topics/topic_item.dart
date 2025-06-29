import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ia_web_front/features/content/domain/entities/topic_entity.dart';

class TopicItem extends StatelessWidget {
  final TopicEntity topic;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const TopicItem({
    super.key,
    required this.topic,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey[200]!),
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              topic.keyWord,
              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
            ),
          ),
          Expanded(
            child: Text(
              topic.kd ?? '-',
              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12),
            ),
          ),
          Expanded(
            child: Text(
              topic.date,
              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12),
            ),
          ),
          Expanded(
            child: Text(
              topic.score ?? '-',
              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12),
            ),
          ),
          Expanded(
            child: Text(
              topic.words ?? '-',
              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12),
            ),
          ),
          Expanded(
            child: Text(
              topic.schemas ?? '-',
              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12),
            ),
          ),
          Expanded(
            child: Text(
              topic.categories ?? '-',
              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12),
            ),
          ),
          Expanded(
            child: Text(
              topic.tags ?? '-',
              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                    color: topic.status == TopicStatus.covered
                        ? const Color.fromARGB(168, 202, 255, 204)
                        : topic.status == TopicStatus.draft
                            ? const Color.fromARGB(255, 255, 236, 204)
                            : const Color.fromARGB(255, 255, 204, 204),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Text(
                    topic.status.name,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 12,
                      color: topic.status == TopicStatus.covered
                          ? const Color.fromARGB(255, 8, 65, 10)
                          : topic.status == TopicStatus.draft
                              ? const Color.fromARGB(255, 155, 135, 4)
                              : const Color.fromARGB(255, 134, 9, 61),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: SvgPicture.asset(
                    'assets/images/icons/save_draft.svg',
                    height: 24,
                    width: 24,
                    color: const Color.fromARGB(255, 38, 64, 254),
                  ),
                  onPressed: onEdit,
                ),
                IconButton(
                  icon: SvgPicture.asset(
                    'assets/images/icons/delete.svg',
                    height: 24,
                    width: 24,
                    color: const Color.fromARGB(255, 254, 38, 38),
                  ),
                  onPressed: onDelete,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
