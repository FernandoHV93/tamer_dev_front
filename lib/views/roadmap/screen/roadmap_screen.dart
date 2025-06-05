import 'package:flutter/material.dart';
import 'package:ia_web_front/core/providers/session_provider.dart';
import 'package:ia_web_front/views/roadmap/model/roadmap_models.dart';
import 'package:ia_web_front/views/roadmap/widgets/side_bar.dart';
import 'package:provider/provider.dart';

import '../controller/roadmap_controller.dart';
import '../widgets/roadmap_canvas.dart';

class RoadmapScreen extends StatelessWidget {
  const RoadmapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sessionProvider = SessionProvider.of(context);
    context.watch<RoadmapController>();
    final double minScale = 0.5;
    final double maxScale = 2.5;

    return Scaffold(
      body: Row(
        children: [
          SidebarStatus(),
          Expanded(
            child: InteractiveViewer(
              constrained: false,
              minScale: minScale,
              maxScale: maxScale,
              child: const RoadmapCanvas(),
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'export',
            backgroundColor: Colors.orange,
            onPressed: () {
              context.read<RoadmapController>().exportRoadmapToJson(
                  sessionProvider.sessionID, sessionProvider.userID);
            },
            child: const Icon(Icons.share),
          ),
          const SizedBox(height: 12),
          FloatingActionButton(
            heroTag: 'load',
            backgroundColor: Colors.green,
            onPressed: () {
              context.read<RoadmapController>().loadRoadmapfromJson(
                  sessionProvider.sessionID, sessionProvider.userID);
            },
            child: const Icon(Icons.download),
          ),
          const SizedBox(height: 12),
          FloatingActionButton(
            heroTag: 'add',
            onPressed: () {
              final id = UniqueKey().toString();
              context.read<RoadmapController>().addBlock(
                    Block(
                      id: id,
                      title: 'Nuevo Bloque',
                      position: const Offset(100, 100),
                    ),
                  );
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
