import 'package:flutter/material.dart';
import 'package:ia_web_front/data/models/models.dart';
import 'package:ia_web_front/views/article_editor_finish/widgets/code_block.dart';
import 'package:ia_web_front/views/article_editor_finish/widgets/quotes_block.dart';
import 'package:ia_web_front/views/article_editor_finish/widgets/table_block.dart';
import 'package:ia_web_front/views/article_editor_finish/widgets/text_field.dart';
import 'package:provider/provider.dart';
import 'package:ia_web_front/views/article_editor_finish/controllers/widgets_controller.dart';

class WidgetRenderer extends StatelessWidget {
  final ArticleBlock block;
  const WidgetRenderer({super.key, required this.block});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<WidgetsController>();

    if (block is TextBlock) {
      return MyTextField(block: block as TextBlock, controller: controller);
    }

    if (block is CodeBlock) {
      return CodeBlockWidget(block: block as CodeBlock, controller: controller);
    }

    if (block is QuoteBlock) {
      return QuoteBlockWidget(
          block: block as QuoteBlock, controller: controller);
    }

    if (block is TableBlock) {
      return TableBlockWidget(
          block: block as TableBlock, controller: controller);
    }

    return const SizedBox.shrink();
  }
}
