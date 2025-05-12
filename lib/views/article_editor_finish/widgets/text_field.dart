import 'package:flutter/material.dart';
import 'package:ia_web_front/views/article_editor_finish/controllers/widgets_controller.dart';
import 'package:ia_web_front/data/models/models.dart';

class MyTextField extends StatefulWidget {
  final TextBlock block;
  final WidgetsController controller;

  const MyTextField({
    super.key,
    required this.block,
    required this.controller,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.block.text);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.controller.selectBlock(widget.block.id);
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  double _mapFontSize(String size) {
    switch (size) {
      case 'H1':
        return 32.0;
      case 'H2':
        return 28.0;
      case 'H3':
        return 24.0;
      case 'H4':
        return 20.0;
      default:
        return 16.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final block = widget.controller.blocks
        .firstWhere((b) => b.id == widget.block.id) as TextBlock;
    final format = block.format;

    return TextField(
      controller: _textController,
      maxLines: null,
      textAlign: format.align,
      style: TextStyle(
        color: Colors.white,
        fontWeight: format.isBold ? FontWeight.bold : FontWeight.normal,
        fontStyle: format.isItalic ? FontStyle.italic : FontStyle.normal,
        decoration:
            format.isUnderline ? TextDecoration.underline : TextDecoration.none,
        fontSize: _mapFontSize(format.fontSize),
      ),
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Start typing...',
        hintStyle: TextStyle(color: Colors.grey),
      ),
      onChanged: (val) {
        widget.controller.updateBlock(
          widget.block.id,
          TextBlock(
            id: widget.block.id,
            text: val,
            format: format,
          ),
        );
      },
    );
  }
}
