import 'package:flutter/material.dart';
import 'package:ia_web_front/views/article_editor_finish/controllers/widgets_controller.dart';
import 'package:ia_web_front/data/models/models.dart';

class CodeBlockWidget extends StatelessWidget {
  final CodeBlock block;
  final WidgetsController controller;
  const CodeBlockWidget(
      {super.key, required this.block, required this.controller});

  @override
  Widget build(BuildContext context) {
    final controllerText = TextEditingController(text: block.code);
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 30, 30, 30),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.grey),
        ),
        child: TextField(
          controller: controllerText,
          maxLines: null,
          style: TextStyle(
            fontFamily: 'monospace',
            color: Colors.greenAccent,
          ),
          decoration: InputDecoration.collapsed(hintText: "Code here..."),
          onChanged: (value) {
            controller.updateBlock(
                block.id, CodeBlock(id: block.id, code: value));
          },
        ),
      ),
    );
  }
}
