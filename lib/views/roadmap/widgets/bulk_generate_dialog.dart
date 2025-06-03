import 'package:flutter/material.dart';
import 'package:ia_web_front/views/roadmap/model/roadmap_models.dart';

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
    return AlertDialog(
      title: const Text('Bulk Generator'),
      backgroundColor: Colors.white,
      content: SingleChildScrollView(
        child: Column(
          children: [
            ...niveles.asMap().entries.map((entry) {
              final index = entry.key;
              final nivel = entry.value;

              final availableParents = createdTitlesPerLevel[index] ?? [];

              return Column(
                children: [
                  BuildNivelWidget(
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

                        createdTitlesPerLevel.putIfAbsent(index + 1, () => []);
                        createdTitlesPerLevel[index + 1]!.add(title);
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                ],
              );
            }),
          ],
        ),
      ),
      actions: [
        ElevatedButton.icon(
          onPressed: () {
            setState(() {
              final newLevel = NivelData(title: "Nivel ${niveles.length + 1}");
              niveles.add(newLevel);
            });
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.purple[200]),
          icon: const Icon(Icons.add),
          label: const Text("Agregar Nivel"),
        ),
        TextButton(
          child: const Text('Cancelar'),
          onPressed: () => Navigator.pop(context),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[300]),
          onPressed: () {
            widget.onGenerate(niveles);
            Navigator.pop(context);
          },
          child: const Text('Generar'),
        ),
      ],
    );
  }
}
