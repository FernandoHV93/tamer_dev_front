import 'package:flutter/material.dart';
import 'package:ia_web_front/features/roadmap/domain/model/roadmap_models.dart';

import '../widgets/build_nivel_widget.dart'; // Modelo NivelData

class BulkGenerateDialog extends StatefulWidget {
  final Block parent;
  final void Function(List<NivelData> niveles) onGenerate;

  const BulkGenerateDialog({
    super.key,
    required this.parent,
    required this.onGenerate,
  });

  @override
  State<BulkGenerateDialog> createState() => _BulkGenerateDialogState();
}

class _BulkGenerateDialogState extends State<BulkGenerateDialog> {
  final List<NivelData> niveles = [];

  // padre => lista de hijos agregados por usuario
  final Map<int, List<String>> createdTitlesPerLevel = {0: []};

  @override
  void initState() {
    super.initState();
    niveles.add(NivelData(title: 'Nivel 1', parentId: widget.parent.title));
    createdTitlesPerLevel[0] = [widget.parent.title];
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF23272F),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      elevation: 16,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 540),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Icon(Icons.auto_awesome_motion,
                        color: Colors.purpleAccent, size: 28),
                    SizedBox(width: 10),
                    Text('Bulk Generator',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ],
                ),
                const SizedBox(height: 18),
                ...niveles.asMap().entries.map((entry) {
                  final index = entry.key;
                  final nivel = entry.value;
                  final availableParents = createdTitlesPerLevel[index] ?? [];
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: BuildNivelWidget(
                      nivel: nivel,
                      index: index,
                      availableParents: availableParents,
                      onToggleExpanded: () {
                        setState(() {
                          nivel.expanded = !nivel.expanded;
                        });
                      },
                      onChangeParent: (value) {
                        setState(() {
                          nivel.parentId = value;
                        });
                      },
                      onAddChildTitle: (parentId, title) {
                        if (title.trim().isEmpty) return;
                        setState(() {
                          nivel.childrenPerParent[parentId] ??= [];
                          nivel.childrenPerParent[parentId]!.add(title);
                          createdTitlesPerLevel.putIfAbsent(
                              index + 1, () => []);
                          createdTitlesPerLevel[index + 1]!.add(title);
                        });
                      },
                    ),
                  );
                }),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          final newLevel =
                              NivelData(title: "Nivel \\${niveles.length + 1}");
                          niveles.add(newLevel);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purpleAccent,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      icon: const Icon(Icons.add),
                      label: const Text("Agregar Nivel",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () {
                        widget.onGenerate(niveles);
                        Navigator.pop(context);
                      },
                      child: const Text('Generar',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white70,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 10),
                      ),
                      child: const Text('Cancelar',
                          style: TextStyle(fontSize: 16)),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
