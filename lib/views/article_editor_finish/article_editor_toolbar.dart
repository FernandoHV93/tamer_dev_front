import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ia_web_front/core/desing/app_constant.dart';
import 'package:ia_web_front/views/article_editor_finish/controllers/textformat_controller.dart';
import 'package:ia_web_front/views/article_editor_finish/controllers/widgets_controller.dart';
import 'package:ia_web_front/data/models/models.dart';
import 'package:ia_web_front/views/article_editor_finish/widgets/insert_imageDialog.dart';
import 'package:ia_web_front/views/article_editor_finish/widgets/insert_table_dialog.dart';
import 'package:ia_web_front/views/article_editor_finish/widgets/textsize_button.dart';
import 'package:ia_web_front/views/article_editor_finish/widgets/tool_button.dart';
import 'package:provider/provider.dart';

class ArticleEditorToolbar extends StatelessWidget {
  const ArticleEditorToolbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final formatController = context.watch<TextFormatController>();
    final widgetsController = context.read<WidgetsController>();

    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 45, 45, 46),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color.fromARGB(255, 73, 73, 73)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ToolButton(
            icon: FontAwesomeIcons.bold,
            isActive: formatController.isBold,
            onPressed: formatController.toggleBold,
          ),
          ToolButton(
            icon: FontAwesomeIcons.italic,
            isActive: formatController.isItalic,
            onPressed: formatController.toggleItalic,
          ),
          ToolButton(
            icon: FontAwesomeIcons.underline,
            isActive: formatController.isUnderline,
            onPressed: formatController.toggleUnderline,
          ),
          const SizedBox(width: 16),
          ...AppConstants.articleEditortextSizes.map((size) => TextSizeButton(
                size: size,
                currentSize: formatController.textSize,
                onTap: () => formatController.changeTextSize(size),
              )),
          const SizedBox(width: 16),
          ToolButton(
            icon: FontAwesomeIcons.alignLeft,
            isActive: formatController.textAlign == TextAlign.left,
            onPressed: () => formatController.changeTextAlign(TextAlign.left),
          ),
          ToolButton(
            icon: FontAwesomeIcons.alignCenter,
            isActive: formatController.textAlign == TextAlign.center,
            onPressed: () => formatController.changeTextAlign(TextAlign.center),
          ),
          ToolButton(
            icon: FontAwesomeIcons.alignRight,
            isActive: formatController.textAlign == TextAlign.right,
            onPressed: () => formatController.changeTextAlign(TextAlign.right),
          ),
          const SizedBox(width: 16),
          ToolButton(
            icon: FontAwesomeIcons.fileWord,
            isActive: false,
            onPressed: () {
              widgetsController.addBlock(TextBlock(
                id: UniqueKey().toString(),
                text: '',
                format: formatController.getCurrentFormat(),
              ));
            },
          ),
          ToolButton(
            icon: FontAwesomeIcons.table,
            isActive: false,
            onPressed: () async {
              final tableBlock = await showDialog<TableBlock>(
                context: context,
                builder: (_) => InsertTableDialog(),
              );
              if (tableBlock != null) {
                widgetsController.addBlock(tableBlock);
              }
            },
          ),
          ToolButton(
            icon: FontAwesomeIcons.code,
            isActive: false,
            onPressed: () {
              widgetsController.addBlock(CodeBlock(
                id: UniqueKey().toString(),
                code: '',
              ));
            },
          ),
          ToolButton(
              icon: FontAwesomeIcons.image,
              isActive: false,
              onPressed: () async {
                final imageBlock = await showDialog<ImageBlock>(
                  context: context,
                  builder: (_) => InsertImageDialog(),
                );

                if (imageBlock != null) {
                  widgetsController.addBlock(imageBlock);
                }
              }),
          ToolButton(
            icon: FontAwesomeIcons.link,
            isActive: false,
            onPressed: () {},
          ),
          ToolButton(
            icon: FontAwesomeIcons.quoteRight,
            isActive: false,
            onPressed: () {
              widgetsController.addBlock(QuoteBlock(
                id: UniqueKey().toString(),
                quote: '',
              ));
            },
          ),
        ],
      ),
    );
  }
}
