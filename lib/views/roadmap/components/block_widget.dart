import 'package:flutter/material.dart';
import 'package:ia_web_front/domain/entities/block.dart';

class BlockWidget extends StatelessWidget {
  final Block block;
  final bool isSelected;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onAddConnected;

  const BlockWidget({
    super.key,
    required this.block,
    required this.isSelected,
    required this.onEdit,
    required this.onDelete,
    required this.onAddConnected,
  });

  Color getBlockColor() {
    switch (block.label) {
      case "Done":
        return Colors.green.shade900;
      case "To Check":
        return Colors.yellow.shade800;
      case "To Fix":
        return Colors.deepOrange.shade900;
      default:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    final baseColor = getBlockColor();
    final color = isSelected ? baseColor : baseColor;

    return Container(
      clipBehavior: Clip.none,
      child: Column(
        children: [
          Card(
            color: color,
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
                  ...block.comments.map((comment) => Text(
                        comment,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: Colors.white70,
                        ),
                        textAlign: TextAlign.center,
                      )),
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
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  IconButton(
                      onPressed: onAddConnected,
                      icon: const Icon(Icons.add_box_rounded)),
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
    );
  }
}
