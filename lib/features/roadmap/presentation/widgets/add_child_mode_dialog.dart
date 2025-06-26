import 'package:flutter/material.dart';
import 'package:ia_web_front/features/roadmap/domain/model/roadmap_models.dart';

class AddBlockDialog extends StatelessWidget {
  final Block parent;
  final VoidCallback onSingleChild;
  final VoidCallback onBulkGenerate;

  const AddBlockDialog({
    super.key,
    required this.parent,
    required this.onSingleChild,
    required this.onBulkGenerate,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF23272F),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      elevation: 16,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: const [
                  Icon(Icons.add_box, color: Colors.blueAccent, size: 28),
                  SizedBox(width: 10),
                  Text('Add Content',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ],
              ),
              const SizedBox(height: 18),
              _ModernOptionCard(
                icon: Icons.add_circle_outline,
                title: 'Single Child',
                description:
                    'Add a single article node. Best for adding individual pieces of content.',
                color: Colors.blueAccent,
                onTap: () {
                  Navigator.pop(context);
                  onSingleChild();
                },
              ),
              const SizedBox(height: 10),
              _ModernOptionCard(
                icon: Icons.auto_awesome_motion,
                title: 'Bulk Generate',
                description:
                    'Generate multiple articles at once. Perfect for planning content clusters.',
                color: Colors.pinkAccent,
                onTap: () {
                  Navigator.pop(context);
                  onBulkGenerate();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ModernOptionCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final VoidCallback onTap;
  const _ModernOptionCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    required this.onTap,
  });

  @override
  State<_ModernOptionCard> createState() => _ModernOptionCardState();
}

class _ModernOptionCardState extends State<_ModernOptionCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          decoration: BoxDecoration(
            color: _hovering
                ? widget.color.withOpacity(0.13)
                : Colors.white.withOpacity(0.02),
            borderRadius: BorderRadius.circular(12),
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
          child: Row(
            children: [
              Icon(widget.icon, color: widget.color, size: 32),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                        color: widget.color,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.description,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
