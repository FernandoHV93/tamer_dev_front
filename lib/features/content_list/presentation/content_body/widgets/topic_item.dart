import 'package:flutter/material.dart';
import 'package:ia_web_front/features/content_list/data/models/website_model.dart';
import 'package:ia_web_front/features/content_list/presentation/websites_body/widgets/svg_icon_button.dart';

class TopicItem extends StatelessWidget {
  final Topics topic;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  const TopicItem(
      {super.key,
      required this.topic,
      required this.onEdit,
      required this.onDelete});

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
            child: Text(topic.keyWord,
                style:
                    const TextStyle(fontWeight: FontWeight.w800, fontSize: 14)),
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
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12),
            ),
          ),
          Expanded(
            child: Text(
              topic.score.toString(),
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12),
            ),
          ),
          Expanded(
            child: Text(
              topic.words ?? '-',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12),
            ),
          ),
          Expanded(
            child: Text(
              topic.schemas ?? '-',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12),
            ),
          ),
          Expanded(
            child: Text(topic.categories ?? '-',
                style:
                    const TextStyle(fontWeight: FontWeight.w800, fontSize: 12)),
          ),
          Expanded(
            child: Text(topic.tags ?? '-',
                style:
                    const TextStyle(fontWeight: FontWeight.w800, fontSize: 12)),
          ),
          Expanded(
            child: Row(children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                    color: topic.status == TopicStatus.Covered
                        ? const Color.fromARGB(168, 202, 255, 204)
                        : topic.status == TopicStatus.Draft
                            ? const Color.fromARGB(255, 255, 236, 204)
                            : const Color.fromARGB(255, 255, 204, 204),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: Text(topic.status.toString().split('.').last,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 12,
                      color: topic.status == TopicStatus.Covered
                          ? const Color.fromARGB(255, 8, 65, 10)
                          : topic.status == TopicStatus.Draft
                              ? const Color.fromARGB(255, 155, 135, 4)
                              : const Color.fromARGB(255, 134, 9, 61),
                    )),
              ),
            ]),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SvgIconButton(
                  assetPath: 'assets/images/icons/save_draft.svg',
                  color: const Color.fromARGB(255, 38, 64, 254),
                  size: 24,
                  onPressed: onEdit,
                ),
                SvgIconButton(
                  assetPath: 'assets/images/icons/delete.svg',
                  color: const Color.fromARGB(255, 254, 38, 38),
                  size: 24,
                  onPressed: onDelete,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
