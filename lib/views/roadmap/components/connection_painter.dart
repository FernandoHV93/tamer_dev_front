import 'package:flutter/material.dart';
import 'package:ia_web_front/domain/entities/block.dart';
import 'package:ia_web_front/domain/entities/connection.dart';

class ConnectionPainter extends CustomPainter {
  final List<Block> blocks;
  final List<Connection> connections;

  ConnectionPainter({required this.blocks, required this.connections});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    for (var connection in connections) {
      final from = blocks.firstWhere((b) => b.id == connection.fromId);
      final to = blocks.firstWhere((b) => b.id == connection.toId);

      final fromCenter = from.position + const Offset(60, 40);
      final toCenter = to.position + const Offset(60, 40);

      final path = Path();

      final midPointX = (fromCenter.dx + toCenter.dx) / 2;

      path.moveTo(fromCenter.dx, fromCenter.dy);
      path.cubicTo(
        midPointX,
        fromCenter.dy,
        midPointX,
        toCenter.dy,
        toCenter.dx,
        toCenter.dy,
      );

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
