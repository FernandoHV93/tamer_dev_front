import 'package:flutter/material.dart';
import 'package:ia_web_front/core/utils/roadmap_builder.dart';
import 'package:ia_web_front/domain/entities/block.dart';
import 'package:ia_web_front/domain/entities/connection.dart';
import 'package:ia_web_front/domain/entities/leveldata.dart';
import 'package:ia_web_front/views/roadmap/components/block_widget.dart';
import 'package:ia_web_front/views/roadmap/components/buildLevelWidget.dart';
import 'package:ia_web_front/views/roadmap/components/childOptionsButton.dart';
import 'package:ia_web_front/views/roadmap/components/connection_painter.dart';
import 'package:ia_web_front/views/roadmap/components/status_section.dart';

class RoadmapScreen extends StatefulWidget {
  const RoadmapScreen({super.key});

  @override
  State<RoadmapScreen> createState() => _RoadmapScreenState();
}

class _RoadmapScreenState extends State<RoadmapScreen> {
  List<Block> blocks = [];
  List<Connection> connections = [];
  Block? selectedBlock;
  final TransformationController _transformationController =
      TransformationController();
  final double _minScale = 0.5;
  final double _maxScale = 2.5;

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _createInitialBlock();
  }

  void _createInitialBlock() {
    final initialBlock = Block(
      id: UniqueKey().toString(),
      position: const Offset(200, 200),
      title: 'Initial Block',
    );
    blocks.add(initialBlock);
  }

  void openEditDialog(Block block) {
    final titleController = TextEditingController(text: block.title);
    final descriptionController = TextEditingController(
        text: block.comments.isNotEmpty ? block.comments[0] : '');
    final articleUrlController = TextEditingController(
        text: block.links.isNotEmpty ? block.links[0] : '');
    String selectedLabel = block.label;
    final articleContextController =
        TextEditingController(text: block.context["parameters"] ?? "");

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Title",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                const Text("Description",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                const Text("Article URL",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                TextField(
                  controller: articleUrlController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Context',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                TextField(
                  controller: articleContextController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                const Text("Status",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: [
                    ChoiceChip(
                      backgroundColor: Colors.green,
                      label: const Text("Done"),
                      selected: selectedLabel == "Done",
                      selectedColor: Colors.green,
                      onSelected: (_) {
                        selectedLabel = "Done";
                        (context as Element)
                            .markNeedsBuild(); // 👈 Forzar rebuild
                      },
                    ),
                    ChoiceChip(
                      backgroundColor: Colors.red,
                      label: const Text("To Fix"),
                      selected: selectedLabel == "To Fix",
                      selectedColor: Colors.red,
                      onSelected: (_) {
                        selectedLabel = "To Fix";
                        (context as Element).markNeedsBuild();
                      },
                    ),
                    ChoiceChip(
                      backgroundColor: const Color.fromARGB(255, 183, 140, 11),
                      label: const Text("To Check"),
                      selected: selectedLabel == "To Check",
                      selectedColor: const Color.fromARGB(255, 183, 140, 11),
                      onSelected: (_) {
                        selectedLabel = "To Check";
                        (context as Element).markNeedsBuild();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  block.title = titleController.text;
                  block.comments = [descriptionController.text];
                  block.links = [articleUrlController.text];
                  block.label = selectedLabel;
                  block.context = {
                    ...block.context,
                    "context": articleContextController.text.trim().isEmpty
                        ? "Sin contexto"
                        : articleContextController.text.trim(),
                  };
                });
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void addConnectedBlock(Block parent) {
    final newBlock = Block(
      id: UniqueKey().toString(),
      position: parent.position + const Offset(0, 150), // Debajo
      title: 'New Block',
    );
    setState(() {
      blocks.add(newBlock);
      connections.add(Connection(fromId: parent.id, toId: newBlock.id));
      selectedBlock = newBlock;
    });
  }

  void addBlock() {
    final newRoot = Block(
        id: UniqueKey().toString(),
        position: const Offset(100, 100),
        title: 'Root Block',
        parentId: null);
    setState(() {
      blocks.add(newRoot);
    });
  }

  void connectBlocks(Block from, Block to) {
    setState(() {
      connections.add(Connection(fromId: from.id, toId: to.id));
    });
  }

  void _showChildOptionsDialog(Block parent) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: const Text(
              'Add Content',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
            ),
            content: Column(mainAxisSize: MainAxisSize.min, children: [
              ChildOptionButton(
                title: 'Single Child',
                description:
                    'Add a single article node. Best for adding individual pieces of content',
                borderColor: Colors.blueAccent,
                textColor: const Color.fromARGB(255, 104, 164, 213),
                onPressed: () {
                  Navigator.pop(context);
                  addConnectedBlock(parent);
                },
              ),
              SizedBox(
                height: 5,
              ),
              ChildOptionButton(
                title: 'Bulk Generate',
                description:
                    'Generate multiple articles at once. Perfect for planning content clusters',
                borderColor: Colors.pinkAccent,
                textColor: Colors.pinkAccent,
                onPressed: () {
                  Navigator.pop(context);
                  _showBulkGenerateDialog(parent);
                },
              ),
            ]),
          );
        });
  }

  void _showBulkGenerateDialog(Block root) {
    List<NivelData> niveles = [
      NivelData(title: "Nivel 1", parentId: root.id),
    ];
    Map<int, List<Block>> createdBlocksPerLevel = {};

    showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Bulk Generate'),
              backgroundColor: Colors.white,
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ...niveles.asMap().entries.map((entry) {
                      final index = entry.key;
                      final nivel = entry.value;

                      List<Block> availableParents = [];
                      if (index > 0) {
                        availableParents =
                            createdBlocksPerLevel[index - 1] ?? [];
                      }

                      return BuildNivelWidget(
                        nivel: nivel,
                        index: index,
                        availableParents: availableParents,
                        onToggleExpanded: () {
                          setState(() {
                            nivel.expanded = !nivel.expanded;
                          });
                        },
                        onAddChildTitle: (value) {
                          if (value.isNotEmpty) {
                            setState(() {
                              nivel.childTitles = [...nivel.childTitles, value];
                            });
                          }
                        },
                        onChangeParent: (value) {
                          setState(() {
                            nivel.parentId = value;
                          });
                        },
                      );
                    }).toList(),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple[200],
                  ),
                  onPressed: () {
                    setState(() {
                      niveles
                          .add(NivelData(title: "Nivel ${niveles.length + 1}"));
                    });
                  },
                  child: const Text("Agregar Nivel"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _generarNiveles(root, niveles);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[300]),
                  child: const Text('Generar'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _generarNiveles(Block root, List<NivelData> niveles) {
    Map<String, Block> idToBlock = {root.id: root};
    Map<int, List<Block>> createdBlocksPerLevel = {
      0: [root]
    };

    for (var levelIndex = 0; levelIndex < niveles.length; levelIndex++) {
      final nivel = niveles[levelIndex];
      final List<Block> currentLevelBlocks = [];

      for (var title in nivel.childTitles) {
        Block parentBlock;

        if (nivel.parentId != null && idToBlock.containsKey(nivel.parentId)) {
          parentBlock = idToBlock[nivel.parentId!]!;
        } else {
          parentBlock = root;
        }

        final newBlock = Block(
          id: UniqueKey().toString(),
          position: parentBlock.position +
              Offset(0, 150 * (currentLevelBlocks.length + 1)),
          title: title,
          parentId: parentBlock.id,
        );

        final newConnection =
            Connection(fromId: parentBlock.id, toId: newBlock.id);

        setState(() {
          blocks.add(newBlock);
          connections.add(newConnection);
        });

        idToBlock[newBlock.id] = newBlock;
        currentLevelBlocks.add(newBlock);
      }

      createdBlocksPerLevel[levelIndex + 1] = currentLevelBlocks;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Row(
            children: [
              // Sidebar herramientas
              Container(
                width: 200,
                color: Colors.grey[200],
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: addBlock,
                      child: const Text('Add New Root Block'),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                        child: SingleChildScrollView(
                      child: Column(
                        children: [
                          StatusSection(
                            status: "Done",
                            color: Colors.green,
                            blocks:
                                blocks.where((b) => b.label == "Done").toList(),
                          ),
                          StatusSection(
                            status: "To Check",
                            color: Colors.amber,
                            blocks: blocks
                                .where((b) => b.label == "To Check")
                                .toList(),
                          ),
                          StatusSection(
                            status: "To Fix",
                            color: Colors.red,
                            blocks: blocks
                                .where((b) => b.label == "To Fix")
                                .toList(),
                          ),
                          const SizedBox(height: 20),
                          selectedBlock != null
                              ? Text(
                                  'Selected: ${selectedBlock!.title}',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                )
                              : const Text('')
                        ],
                      ),
                    ))
                  ],
                ),
              ),
              // Canvas area
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedBlock = null;
                    });
                  },
                  child: InteractiveViewer(
                    transformationController: _transformationController,
                    minScale: _minScale,
                    maxScale: _maxScale,
                    constrained: false,
                    child: Stack(
                      children: [
                        CustomPaint(
                          size: Size.square(5000),
                          painter: ConnectionPainter(
                            blocks: blocks,
                            connections: connections,
                          ),
                        ),
                        ...blocks.map((block) {
                          return Positioned(
                            left: block.position.dx,
                            top: block.position.dy,
                            child: GestureDetector(
                              onPanStart: (details) {
                                setState(() {
                                  selectedBlock = block;
                                });
                              },
                              onPanUpdate: (details) {
                                setState(() {
                                  block.position += details.delta;
                                });
                              },
                              onTap: () {
                                setState(() {
                                  if (selectedBlock == null) {
                                    selectedBlock = block;
                                  } else if (selectedBlock != null &&
                                      selectedBlock != block) {
                                    connectBlocks(selectedBlock!, block);
                                    selectedBlock = null;
                                  }
                                });
                              },
                              child: BlockWidget(
                                  block: block,
                                  isSelected: selectedBlock == block,
                                  onEdit: () {
                                    openEditDialog(block);
                                  },
                                  onDelete: () {
                                    setState(() {
                                      connections.removeWhere((c) =>
                                          c.fromId == block.id ||
                                          c.toId == block.id);
                                      blocks.remove(block);
                                      selectedBlock = null;
                                    });
                                  },
                                  onAddConnected: () =>
                                      _showChildOptionsDialog(block)),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 100,
            right: 50,
            child: Row(
              children: [
                FloatingActionButton(
                  heroTag: 'zoom_in',
                  mini: true,
                  onPressed: () {
                    Matrix4 newMatrix = _transformationController.value.clone();
                    double currentScale = newMatrix.getMaxScaleOnAxis();
                    double nextScale =
                        (currentScale * 1.2).clamp(_minScale, _maxScale);

                    double scaleFactor = nextScale / currentScale;
                    newMatrix.scale(scaleFactor);

                    _transformationController.value = newMatrix;
                  },
                  child: const Icon(Icons.zoom_in),
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  heroTag: 'zoom_out',
                  mini: true,
                  onPressed: () {
                    Matrix4 newMatrix = _transformationController.value.clone();
                    double currentScale = newMatrix.getMaxScaleOnAxis();
                    double nextScale =
                        (currentScale * 0.8).clamp(_minScale, _maxScale);

                    double scaleFactor = nextScale / currentScale;
                    newMatrix.scale(scaleFactor);

                    _transformationController.value = newMatrix;
                  },
                  child: const Icon(Icons.zoom_out),
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  heroTag: 'reset',
                  mini: true,
                  onPressed: () {
                    _transformationController.value = Matrix4.identity();
                  },
                  child: const Icon(Icons.center_focus_strong),
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  heroTag: 'generate_json',
                  mini: true,
                  backgroundColor: Colors.orange,
                  onPressed: () {
                    final jsonString = RoadmapBuilder.generateRoadmapJson(
                      blocks: blocks,
                      connections: connections,
                    );
                    debugPrint("JSON generado:\n${jsonString.toJson()}");

                    // send post to backend using the use case
                  },
                  child: const Icon(Icons.save),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
