import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/roadmap_controller.dart';
import '../widgets/status_section.dart';

class SidebarStatus extends StatelessWidget {
  const SidebarStatus({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<RoadmapController>();
    final blocks = controller.blocks;
    final selectedBlock = controller.selectedBlock;

    final done = blocks.where((b) => b.label == "Done").toList();
    final toCheck = blocks.where((b) => b.label == "To Check").toList();
    final toFix = blocks.where((b) => b.label == "To Fix").toList();

    return Container(
      width: 220,
      color: Colors.grey[200],
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  StatusSection(
                    status: "Done (${done.length})",
                    color: Colors.green,
                    blocks: done,
                  ),
                  StatusSection(
                    status: "To Check (${toCheck.length})",
                    color: Colors.amber,
                    blocks: toCheck,
                  ),
                  StatusSection(
                    status: "To Fix (${toFix.length})",
                    color: Colors.red,
                    blocks: toFix,
                  ),
                ],
              ),
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                selectedBlock != null
                    ? Text(
                      'Selected:\n${selectedBlock.title}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    )
                    : const Text('No block selected'),
          ),
        ],
      ),
    );
  }
}
