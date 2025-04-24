import 'package:flutter/material.dart';
import 'package:ia_web_front/domain/entities/block.dart';

class StatusSection extends StatefulWidget {
  final String status;
  final Color color;
  final List<Block> blocks;

  const StatusSection({
    super.key,
    required this.status,
    required this.color,
    required this.blocks,
  });

  @override
  State<StatusSection> createState() => _StatusSectionState();
}

class _StatusSectionState extends State<StatusSection> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: IconButton(
            icon: Icon(
              expanded ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_right,
              color: widget.color,
            ),
            onPressed: () {
              setState(() {
                expanded = !expanded;
              });
            },
          ),
          title: Text(
            widget.status,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: widget.color,
            ),
          ),
          onTap: () {
            setState(() {
              expanded = !expanded;
            });
          },
        ),
        if (expanded)
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.blocks.map((block) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Text(
                    block.title,
                    style: const TextStyle(fontSize: 14),
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}
