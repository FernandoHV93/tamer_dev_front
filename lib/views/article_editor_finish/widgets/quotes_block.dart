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
    final controllerText = TextEditingController(text: block.quote);
    return Container(
      color: Colors.grey.shade200,
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.symmetric(vertical: 4),
      child: TextField(
        controller: controllerText,
        maxLines: null,
        style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16),
        decoration:
            InputDecoration.collapsed(hintText: 'Reference a quote here...'),
        onChanged: (value) {
          controller.updateBlock(
              block.id, QuoteBlock(id: block.id, quote: value));
        },
      ),
    );
  }
}
