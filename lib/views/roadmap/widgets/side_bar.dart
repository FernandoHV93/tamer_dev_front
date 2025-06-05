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
      color: const Color.fromARGB(255, 24, 48, 82),
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  StatusSection(
                    status: "Done (${done.length})",
                    color: const Color.fromARGB(255, 133, 255, 137),
                    blocks: done,
                  ),
                  StatusSection(
                    status: "To Check (${toCheck.length})",
                    color: const Color.fromARGB(255, 252, 214, 102),
                    blocks: toCheck,
                  ),
                  StatusSection(
                    status: "To Fix (${toFix.length})",
                    color: const Color.fromARGB(255, 253, 114, 104),
                    blocks: toFix,
                  ),
                ],
              ),
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: selectedBlock != null
                ? Text(
                    'Selected:\n${selectedBlock.title}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.white),
                  )
                : const Text(
                    'No block selected',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.white),
                  ),
          ),
        ],
      ),
    );
  }
}
