import 'package:flutter/material.dart';

import 'package:ia_web_front/features/roadmap/domain/model/roadmap_models.dart';
import 'package:ia_web_front/features/roadmap/domain/uses_cases/load_roadmap.dart';
import 'package:ia_web_front/features/roadmap/domain/uses_cases/save_roadmap.dart';

class RoadmapController with ChangeNotifier {
  final List<Block> _blocks = [];
  Block? _selectedBlock;
  late final SaveRoadmap saveRoadmap;
  late final LoadRoadmap loadRoadmap;

  List<Block> get blocks => _blocks;
  Block? get selectedBlock => _selectedBlock;

  RoadmapController() {
    _createInitialBlock();
  }

  void _createInitialBlock() {
    addBlock(
      Block(
        id: UniqueKey().toString(),
        position: const Offset(330, 50),
        title: 'Initial Block',
      ),
    );
  }

  void loadRoadmapfromJson(String sessionId, String userId) async {
    try {
      final Map<String, dynamic> roadmapData =
          await loadRoadmap.execute(sessionId, userId);

      final List<dynamic> roadmapList = roadmapData['roadmap'] ?? [];

      // Limpiamos los bloques existentes si es necesario
      _blocks.clear();

      for (var blockJson in roadmapList) {
        final block = Block.fromJson(blockJson);
        _blocks.add(block);
      }

      notifyListeners();
    } catch (e) {
      debugPrint('Error loading roadmap: $e');
    }
  }

  void setSelectedBlock(Block? block) {
    _selectedBlock = block;
    notifyListeners();
  }

  void addBlock(Block block) {
    _blocks.add(block);
    notifyListeners();
  }

  void updateBlock(Block updatedBlock) {
    final index = _blocks.indexWhere((b) => b.id == updatedBlock.id);
    if (index != -1) {
      final oldBlock = _blocks[index];
      _blocks[index] = Block(
        id: oldBlock.id,
        position: updatedBlock.position,
        title: updatedBlock.title,
        comments: updatedBlock.comments,
        links: updatedBlock.links,
        label: updatedBlock.label,
        context: updatedBlock.context,
        parentId: updatedBlock.parentId,
        connections: updatedBlock.connections,
      );
      notifyListeners();
    }
  }

  void removeBlock(String blockId) {
    _blocks.removeWhere((b) => b.id == blockId);
    for (final block in _blocks) {
      block.connections.removeWhere(
        (conn) => conn.fromId == blockId || conn.toId == blockId,
      );
    }
    if (_selectedBlock?.id == blockId) {
      _selectedBlock = null;
    }
    notifyListeners();
  }

  void addConnection(Connection connection) {
    final fromBlock = _blocks.firstWhere((b) => b.id == connection.fromId);
    fromBlock.connections.add(connection);
    notifyListeners();
  }

  void addConnectedBlock(Block parent) {
    // Find all children of the parent
    final children = _blocks.where((b) => b.parentId?.id == parent.id).toList();

    // Calculate vertical offset based on number of children
    final verticalOffset = 150.0; // Base vertical spacing
    final newY = parent.position.dy +
        verticalOffset +
        (children.length * verticalOffset);

    final newBlock = Block(
      id: UniqueKey().toString(),
      position: Offset(parent.position.dx, newY),
      title: 'New Block',
      parentId: parent,
    );

    addBlock(newBlock);
    addConnection(Connection(fromId: parent.id, toId: newBlock.id));
    setSelectedBlock(newBlock);
  }

  void moveBlock(String blockId, Offset newPosition) {
    final block = _blocks.firstWhere((b) => b.id == blockId);
    block.position = newPosition;
    notifyListeners();
  }

  void bulkGenerateBlocksFromNiveles(Block root, List<NivelData> niveles) {
    const double verticalSpacing = 150.0; // Distancia entre niveles
    const double horizontalSpacing = 220.0; // Espacio entre bloques hermanos
    const double blockWidth = 200.0; // Ancho del bloque

    Map<String, List<Block>> titleToBlocks = {};
    for (var block in _blocks) {
      titleToBlocks.putIfAbsent(block.title, () => []).add(block);
    }

    Map<int, List<Block>> createdBlocksPerLevel = {
      0: [root],
    };
    Map<String, Block> idToBlock = {root.id: root};

    for (int levelIndex = 0; levelIndex < niveles.length; levelIndex++) {
      final nivel = niveles[levelIndex];
      final List<Block> currentLevelBlocks = [];

      for (final entry in nivel.childrenPerParent.entries) {
        final parentTitle = entry.key;
        final childTitles = entry.value;

        final parentCandidates = titleToBlocks[parentTitle];
        if (parentCandidates == null || parentCandidates.isEmpty) continue;

        final parentBlock = parentCandidates.first;

        final numChildren = childTitles.length;
        if (numChildren == 0) continue;

        // Calcula el ancho total ocupado por los hijos
        final totalWidth = (numChildren - 1) * horizontalSpacing;
        // Centra los hijos respecto al padre
        final startX = parentBlock.position.dx - (totalWidth / 2);
        final y = parentBlock.position.dy + verticalSpacing;

        for (int i = 0; i < numChildren; i++) {
          final x = startX + i * horizontalSpacing;
          final childTitle = childTitles[i];

          final newBlock = Block(
            id: UniqueKey().toString(),
            title: childTitle,
            position: Offset(x, y),
            parentId: parentBlock,
          );

          addBlock(newBlock);
          addConnection(Connection(fromId: parentBlock.id, toId: newBlock.id));
          titleToBlocks.putIfAbsent(childTitle, () => []).add(newBlock);
          idToBlock[newBlock.id] = newBlock;
          currentLevelBlocks.add(newBlock);
        }
      }
      createdBlocksPerLevel[levelIndex + 1] = currentLevelBlocks;
    }
  }

  Future<Map<String, dynamic>> exportRoadmapToJson(
      String sessionId, String userId) async {
    final data = _blocks.map((b) => b.toJson()).toList();
    saveRoadmap.execute(sessionId, userId, {'roadmap': data});
    return {'roadmap': data};
  }
}
