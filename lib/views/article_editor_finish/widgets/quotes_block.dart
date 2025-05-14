import 'package:flutter/material.dart';
import 'package:ia_web_front/views/article_editor_finish/controllers/widgets_controller.dart';
import 'package:ia_web_front/data/models/models.dart';

class QuoteBlockWidget extends StatelessWidget {
  final QuoteBlock block;
  final WidgetsController controller;

  const QuoteBlockWidget(
      {super.key, required this.block, required this.controller});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.selectBlock(block.id),
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          border:
              Border(left: BorderSide(color: Colors.grey.shade600, width: 4)),
          color: const Color.fromARGB(255, 60, 60, 60),
        ),
        child: TextField(
          controller: TextEditingController.fromValue(
            TextEditingValue(
              text: block.quote,
              selection: TextSelection.collapsed(offset: block.quote.length),
            ),
          ),
          style: const TextStyle(
            fontStyle: FontStyle.italic,
            color: Colors.white70,
            fontSize: 16,
          ),
          maxLines: null,
          decoration: const InputDecoration.collapsed(hintText: 'Cita...'),
          onChanged: (value) {
            controller.updateBlock(
              block.id,
              QuoteBlock(id: block.id, quote: value),
            );
          },
        ),
      ),
    );
  }
}
