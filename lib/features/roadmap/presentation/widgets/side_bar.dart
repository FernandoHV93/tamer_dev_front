import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/roadmap_controller.dart';
import 'package:ia_web_front/features/roadmap/domain/model/roadmap_models.dart';

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
      width: 240,
      margin: const EdgeInsets.only(top: 16, left: 8, bottom: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF23272F), Color(0xFF181A20)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.18),
            blurRadius: 16,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
      child: Column(
        children: [
          Expanded(
            child: Scrollbar(
              thumbVisibility: true,
              thickness: 6,
              radius: const Radius.circular(8),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _StatusSectionCard(
                      icon: Icons.check_circle,
                      status: "Done (${done.length})",
                      color: const Color(0xFF4ADE80),
                      blocks: done,
                    ),
                    const SizedBox(height: 12),
                    _StatusSectionCard(
                      icon: Icons.visibility,
                      status: "To Check (${toCheck.length})",
                      color: const Color(0xFFFACC15),
                      blocks: toCheck,
                    ),
                    const SizedBox(height: 12),
                    _StatusSectionCard(
                      icon: Icons.error_outline,
                      status: "To Fix (${toFix.length})",
                      color: const Color(0xFFF87171),
                      blocks: toFix,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Divider(color: Colors.white24, thickness: 1, height: 24),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: selectedBlock != null
                ? Row(
                    children: [
                      const Icon(Icons.label_important,
                          color: Colors.blueAccent, size: 22),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Selected:\n${selectedBlock.title}',
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  )
                : Row(
                    children: const [
                      Icon(Icons.label_off, color: Colors.white54, size: 22),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'No block selected',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.white54,
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

class _StatusSectionCard extends StatelessWidget {
  final IconData icon;
  final String status;
  final Color color;
  final List<Block> blocks;
  const _StatusSectionCard({
    required this.icon,
    required this.status,
    required this.color,
    required this.blocks,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white.withOpacity(0.04),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 22),
                const SizedBox(width: 8),
                Text(
                  status,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ...blocks
                .map((block) => _ModernBlockCard(block: block, color: color))
                .toList(),
          ],
        ),
      ),
    );
  }
}

class _ModernBlockCard extends StatefulWidget {
  final Block block;
  final Color color;
  const _ModernBlockCard({required this.block, required this.color});

  @override
  State<_ModernBlockCard> createState() => _ModernBlockCardState();
}

class _ModernBlockCardState extends State<_ModernBlockCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: _hovering
              ? widget.color.withOpacity(0.18)
              : Colors.white.withOpacity(0.02),
          borderRadius: BorderRadius.circular(10),
          boxShadow: _hovering
              ? [
                  BoxShadow(
                    color: widget.color.withOpacity(0.18),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [],
          border: Border.all(
            color: widget.color.withOpacity(_hovering ? 0.5 : 0.18),
            width: 1.2,
          ),
        ),
        child: ListTile(
          dense: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          title: Text(
            widget.block.title,
            style: TextStyle(
              color: widget.color,
              fontWeight: FontWeight.w600,
              fontSize: 15,
              letterSpacing: 0.2,
            ),
          ),
          subtitle: widget.block.label != null
              ? Text(
                  widget.block.label!,
                  style: TextStyle(
                    color: widget.color.withOpacity(0.7),
                    fontSize: 12,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
