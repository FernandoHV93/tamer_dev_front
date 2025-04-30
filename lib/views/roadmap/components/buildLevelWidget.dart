import 'package:flutter/material.dart';
import 'package:ia_web_front/domain/entities/block.dart';
import 'package:ia_web_front/domain/entities/leveldata.dart';

class BuildNivelWidget extends StatelessWidget {
  const BuildNivelWidget({
    super.key,
    required this.nivel,
    required this.index,
    required this.availableParents,
    required this.onToggleExpanded,
    required this.onAddChildTitle,
    required this.onChangeParent,
  });

  final NivelData nivel;
  final int index;
  final List<Block> availableParents;
  final VoidCallback onToggleExpanded;
  final Function(String newTitle) onAddChildTitle;
  final Function(String? parentId) onChangeParent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(
          vertical: 8), // 👈 Espacio automático entre niveles
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey,
          width: 0.6,
        ),
        color: const Color.fromARGB(255, 252, 252, 252),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(nivel.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20)),
              const Spacer(),
              IconButton(
                icon: Icon(
                  nivel.expanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                ),
                onPressed: onToggleExpanded, // 👈 ahora viene de fuera
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
                      const Text("Select Parent"),
                      const SizedBox(height: 4),
                      DropdownButton<String>(
                        isExpanded: true,
                        value: nivel.parentId,
                        hint: const Text('Select parent block'),
                        items: availableParents
                            .map((parentBlock) => DropdownMenuItem<String>(
                                  value: parentBlock.id,
                                  child: Text(parentBlock.title),
                                ))
                            .toList(),
                        onChanged: onChangeParent, // 👈 ahora viene de fuera
                      ),
                    ],
                  ),
                const SizedBox(height: 8),
                const Text(
                  "Keyword of blog:",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                TextField(
                  onSubmitted: onAddChildTitle, // 👈 ahora viene de fuera
                  decoration: const InputDecoration(
                    hintText: 'Enter child title',
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.grey),
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                if (nivel.childTitles.isNotEmpty)
                  Column(
                    children: nivel.childTitles
                        .map((title) => ListTile(
                              title: Text(title),
                              dense: true,
                            ))
                        .toList(),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
