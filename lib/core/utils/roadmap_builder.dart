import 'dart:math';
import 'package:ia_web_front/data/models/roadmap_model.dart';
import 'package:ia_web_front/domain/entities/block.dart';
import 'package:ia_web_front/domain/entities/connection.dart';

class RoadmapBuilder {
  RoadmapBuilder._();

  static RoadmapModel generateRoadmapJson({
    required List<Block> blocks,
    required List<Connection> connections,
  }) {
    final sessionId = Random().nextInt(1000000);

    final items = blocks.map((block) {
      final connectedTo = connections
          .where((c) => c.fromId == block.id)
          .map((c) => c.toId)
          .toList();

      return RoadmapItemModel(
        blockId: block.id,
        keyword: block.title,
        description: block.comments.join('\n'),
        connections: connectedTo,
        context: block.context,
      );
    }).toList();

    return RoadmapModel(
      sessionId: sessionId,
      roadmapDescription: items,
    );
  }
}
