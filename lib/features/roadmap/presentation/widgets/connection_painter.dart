import 'package:flutter/material.dart';
import 'package:ia_web_front/features/roadmap/domain/model/roadmap_models.dart';

class ConnectionPainter extends CustomPainter {
  final List<Block> blocks;

  ConnectionPainter({required this.blocks});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey[600]!
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    for (final block in blocks) {
      for (final conn in block.connections) {
        final from = block;
        final to = blocks.firstWhere(
          (b) => b.id == conn.toId,
          orElse: () => Block(id: '', position: Offset.zero, title: ''),
        );

        if (to.id.isEmpty) continue;

        // Calculate connection points
        final start = from.position +
            const Offset(100, 40); // bottom-center of parent block
        final end =
            to.position + const Offset(100, 0); // top-center of child block

        // Create a curved path for the connection
        final path = Path()
          ..moveTo(start.dx, start.dy)
          ..cubicTo(
            start.dx, start.dy + 50, // First control point
            end.dx, end.dy - 50, // Second control point
            end.dx, end.dy, // End point
          );

        canvas.drawPath(path, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
