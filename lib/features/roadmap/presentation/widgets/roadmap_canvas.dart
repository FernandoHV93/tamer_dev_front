import 'package:flutter/material.dart';
import 'package:ia_web_front/features/roadmap/domain/model/roadmap_models.dart';
import 'package:ia_web_front/features/roadmap/presentation/widgets/add_child_mode_dialog.dart';
import 'package:ia_web_front/features/roadmap/presentation/widgets/bulk_generate_dialog.dart';
import 'package:ia_web_front/features/roadmap/presentation/widgets/connection_painter.dart';
import 'package:ia_web_front/features/roadmap/presentation/widgets/edit_block_dialog.dart';

import 'package:provider/provider.dart';

import '../controller/roadmap_controller.dart';

import '../widgets/block_widget.dart';

class RoadmapCanvas extends StatelessWidget {
  const RoadmapCanvas({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<RoadmapController>();
    final blocks = controller.blocks;

    return Stack(
      children: [
        // Pinta conexiones entre bloques
        CustomPaint(
          size: Size.square(5000),
          painter: ConnectionPainter(blocks: blocks),
        ),
        // Pinta cada bloque
        ...blocks.map((block) {
          return Positioned(
            left: block.position.dx,
            top: block.position.dy,
            child: GestureDetector(
              onPanUpdate: (details) {
                final newPosition = block.position + details.delta;
                controller.moveBlock(block.id, newPosition);
              },
              child: BlockWidget(
                block: block,
                onTap: () => controller.setSelectedBlock(block),
                onEdit: () async {
                  final updated = await showDialog<Block>(
                    context: context,
                    builder: (_) => EditBlockDialog(block: block),
                  );
                  if (updated != null) {
                    controller.updateBlock(updated);
                  }
                },
                onDelete: () => controller.removeBlock(block.id),
                onAddConnected: () {
                  showDialog(
                    context: context,
                    builder: (_) => AddBlockDialog(
                      parent: block,
                      onSingleChild: () => controller.addConnectedBlock(block),
                      onBulkGenerate: () {
                        showDialog(
                          context: context,
                          builder: (_) => BulkGenerateDialog(
                            parent: block,
                            onGenerate: (niveles) {
                              controller.bulkGenerateBlocksFromNiveles(
                                block,
                                niveles,
                              );
                            },
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          );
        }),
      ],
    );
  }
}
