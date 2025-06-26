import 'package:flutter/material.dart';
import 'package:ia_web_front/core/providers/session_provider.dart';
import 'package:ia_web_front/features/roadmap/domain/model/roadmap_models.dart';
import 'package:ia_web_front/features/roadmap/presentation/controller/roadmap_controller.dart';
import 'package:ia_web_front/features/roadmap/presentation/widgets/roadmap_canvas.dart';
import 'package:ia_web_front/features/roadmap/presentation/widgets/side_bar.dart';

import 'package:provider/provider.dart';

class RoadmapScreen extends StatelessWidget {
  const RoadmapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sessionProvider = SessionProvider.of(context);
    context.watch<RoadmapController>();
    final double minScale = 0.5;
    final double maxScale = 2.5;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Fondo degradado
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF181A20), Color(0xFF23272F)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Column(
            children: [
              // Main content
              Expanded(
                child: Row(
                  children: [
                    // Sidebar moderno
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF23272F),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 16,
                            offset: const Offset(2, 0),
                          ),
                        ],
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(18),
                        ),
                      ),
                      child: const SidebarStatus(),
                    ),
                    // Canvas elevado y moderno
                    Expanded(
                      child: Center(
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 32, horizontal: 24),
                          decoration: BoxDecoration(
                            color: const Color(0xFF23272F),
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.18),
                                blurRadius: 24,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: InteractiveViewer(
                              constrained: false,
                              minScale: minScale,
                              maxScale: maxScale,
                              child: const RoadmapCanvas(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Speed Dial FAB moderno
          Positioned(
            bottom: 32,
            right: 32,
            child: _ModernSpeedDial(
              onExport: () {
                context.read<RoadmapController>().exportRoadmapToJson(
                    sessionProvider.sessionID, sessionProvider.userID);
              },
              onLoad: () {
                context.read<RoadmapController>().loadRoadmapfromJson(
                    sessionProvider.sessionID, sessionProvider.userID);
              },
              onAdd: () {
                final id = UniqueKey().toString();
                context.read<RoadmapController>().addBlock(
                      Block(
                        id: id,
                        title: 'New Block',
                        position: const Offset(100, 100),
                      ),
                    );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ModernSpeedDial extends StatefulWidget {
  final VoidCallback onExport;
  final VoidCallback onLoad;
  final VoidCallback onAdd;
  const _ModernSpeedDial({
    required this.onExport,
    required this.onLoad,
    required this.onAdd,
  });

  @override
  State<_ModernSpeedDial> createState() => _ModernSpeedDialState();
}

class _ModernSpeedDialState extends State<_ModernSpeedDial>
    with SingleTickerProviderStateMixin {
  bool _open = false;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _open = !_open;
      if (_open) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 32, right: 32),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_open) ...[
              _SpeedDialAction(
                icon: Icons.share,
                color: Colors.orange,
                label: 'Export',
                onTap: () {
                  widget.onExport();
                  _toggle();
                },
              ),
              const SizedBox(width: 12),
              _SpeedDialAction(
                icon: Icons.download,
                color: Colors.green,
                label: 'Load',
                onTap: () {
                  widget.onLoad();
                  _toggle();
                },
              ),
              const SizedBox(width: 12),
              _SpeedDialAction(
                icon: Icons.add,
                color: Colors.blue,
                label: 'Add Block',
                onTap: () {
                  widget.onAdd();
                  _toggle();
                },
              ),
              const SizedBox(width: 18),
            ],
            FloatingActionButton(
              backgroundColor: Colors.blueAccent,
              onPressed: _toggle,
              child: AnimatedIcon(
                icon: AnimatedIcons.menu_close,
                progress: _controller,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SpeedDialAction extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final VoidCallback onTap;
  const _SpeedDialAction({
    required this.icon,
    required this.color,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          margin: const EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.85),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 8,
                offset: const Offset(2, 2),
              ),
            ],
          ),
          child: Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
        FloatingActionButton(
          heroTag: label,
          mini: true,
          backgroundColor: color,
          onPressed: onTap,
          child: Icon(icon, color: Colors.white),
        ),
      ],
    );
  }
}
