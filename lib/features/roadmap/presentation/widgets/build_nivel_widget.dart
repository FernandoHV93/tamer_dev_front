import 'package:flutter/material.dart';
import 'package:ia_web_front/features/roadmap/domain/model/roadmap_models.dart';

class BuildNivelWidget extends StatelessWidget {
  final NivelData nivel;
  final int index;
  final List<String> availableParents;
  final VoidCallback onToggleExpanded;
  final void Function(String parentId, String title) onAddChildTitle;
  final void Function(String?) onChangeParent;

  const BuildNivelWidget({
    super.key,
    required this.nivel,
    required this.index,
    required this.availableParents,
    required this.onToggleExpanded,
    required this.onAddChildTitle,
    required this.onChangeParent,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController textController = TextEditingController();
    return Container(
      width: 500,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey, width: 0.6),
        color: const Color.fromARGB(173, 235, 246, 255),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                nivel.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              IconButton(
                icon: Icon(
                  nivel.expanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                ),
                onPressed: onToggleExpanded,
              ),
            ],
          ),
          if (nivel.expanded)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (index > 0)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      const Text("Selecciona un padre"),
                      const SizedBox(height: 4),
                      DropdownButton<String>(
                        isExpanded: true,
                        value: nivel.parentId,
                        hint: const Text('Selecciona bloque padre'),
                        items: availableParents
                            .map(
                              (parentTitle) => DropdownMenuItem<String>(
                                value: parentTitle,
                                child: Text(parentTitle),
                              ),
                            )
                            .toList(),
                        onChanged: onChangeParent,
                      ),
                    ],
                  ),
                const SizedBox(height: 8),
                // Add TextEditingController for the TextField
                if (nivel.parentId != null || index == 0) ...[
                  Text(
                    "Keywords for ${nivel.parentId ?? 'root'}",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: textController,
                    onSubmitted: (value) {
                      if (value.trim().isEmpty) return;
                      onAddChildTitle(nivel.parentId ?? '', value.trim());
                      textController.clear();
                    },
                    decoration: const InputDecoration(
                      hintText: 'Write a title and press Enter to add',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
                if (nivel.childrenPerParent.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: nivel.childrenPerParent.entries.expand((entry) {
                      return entry.value.map(
                        (title) => Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 4,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.lightBlueAccent.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(title),
                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: () {
                                  nivel.childrenPerParent[entry.key]!
                                      .remove(title);
                                  (context as Element).markNeedsBuild();
                                },
                                child: const Icon(
                                  Icons.close,
                                  size: 16,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
