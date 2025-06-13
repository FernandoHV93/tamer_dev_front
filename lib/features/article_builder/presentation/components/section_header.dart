import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String tooltip;

  const SectionHeader({
    super.key,
    required this.title,
    required this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.w800, color: Colors.white),
        ),
        const SizedBox(width: 8),
        Tooltip(
          message: tooltip,
          child: Icon(Icons.info_outline, size: 18, color: Colors.white),
        ),
      ],
    );
  }
}
