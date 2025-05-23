import 'package:flutter/material.dart';
import 'package:ia_web_front/data/models/article_editor_models.dart';

class WidgetsController extends ChangeNotifier {
  final List<ArticleBlock> _blocks = [];
  String? selectedBlockId;

  List<ArticleBlock> get blocks => _blocks;

  void addBlock(ArticleBlock block) {
    _blocks.add(block);
    notifyListeners();
  }

  void setBlocks(List<ArticleBlock> newBlocks) {
    _blocks
      ..clear()
      ..addAll(newBlocks);
    notifyListeners();
  }

  void updateBlock(String id, ArticleBlock updated) {
    final index = _blocks.indexWhere((b) => b.id == id);
    if (index != -1) {
      _blocks[index] = updated;
      notifyListeners();
    }
  }

  void removeBlock(String id) {
    _blocks.removeWhere((b) => b.id == id);
    notifyListeners();
  }

  void selectBlock(String id) {
    selectedBlockId = id;
    notifyListeners();
  }

  void toggleBold() {
    _modifyFormat((format) => format.isBold = !format.isBold);
  }

  void toggleItalic() {
    _modifyFormat((format) => format.isItalic = !format.isItalic);
  }

  void toggleUnderline() {
    _modifyFormat((format) => format.isUnderline = !format.isUnderline);
  }

  void changeFontSize(String size) {
    _modifyFormat((format) => format.fontSize = size);
  }

  void changeAlignment(TextAlign align) {
    _modifyFormat((format) => format.align = align);
  }

  void _modifyFormat(void Function(BlockFormat) modifier) {
    final block = _blocks.firstWhere(
      (b) => b.id == selectedBlockId,
    );
    if (block is TextBlock) {
      final format = block.format;
      modifier(format);
      updateBlock(
          block.id, TextBlock(id: block.id, text: block.text, format: format));
    }
  }
}
