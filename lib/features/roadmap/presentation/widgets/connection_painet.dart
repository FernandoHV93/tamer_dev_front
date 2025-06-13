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

        final start = from.position + Offset(200, 40); // right-center of block
        final end = to.position + Offset(0, 40); // left-center of block

        final cp1 = Offset(start.dx + 50, start.dy);
        final cp2 = Offset(end.dx - 50, end.dy);

        final path = Path()
          ..moveTo(start.dx, start.dy)
          ..cubicTo(cp1.dx, cp1.dy, cp2.dx, cp2.dy, end.dx, end.dy);

        canvas.drawPath(path, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
