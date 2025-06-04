import 'package:flutter/material.dart';
import 'package:ia_web_front/views/roadmap/model/roadmap_models.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/roadmap_controller.dart';

class BlockWidget extends StatelessWidget {
  final Block block;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onAddConnected;

  const BlockWidget({
    super.key,
    required this.block,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
    required this.onAddConnected,
  });

  Color getBlockColor() {
    switch (block.label) {
      case "Done":
        return const Color.fromARGB(255, 27, 55, 94);
      case "To Check":
        return const Color.fromARGB(187, 157, 112, 38);
      case "To Fix":
        return const Color.fromARGB(188, 155, 43, 9);
      default:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    final baseColor = getBlockColor();
    final controller = context.watch<RoadmapController>();
    final isSelected = controller.selectedBlock?.id == block.id;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        clipBehavior: Clip.none,
        child: Column(
          children: [
            Card(
              color: baseColor,
              elevation: 4,
              child: Container(
                width: 200,
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      block.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    ...block.comments.map(
                      (comment) => Text(
                        comment,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: Colors.white70,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 4),
                    ...block.links.map(
                      (link) => InkWell(
                        onTap: () async {
                          final uri = Uri.parse(link);
                          if (await canLaunchUrl(uri)) {
                            await launchUrl(uri);
                          }
                        },
                        child: Text(
                          link,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.lightBlueAccent,
                            decoration: TextDecoration.underline,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (isSelected)
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black26),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: onAddConnected,
                      icon: const Icon(Icons.add_box_rounded),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit, size: 17),
                      color: Colors.black,
                      onPressed: onEdit,
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, size: 17),
                      color: Colors.red,
                      onPressed: onDelete,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
