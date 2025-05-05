import 'package:flutter/material.dart';
import 'package:ia_web_front/domain/entities/article_editor_entity.dart';

class ArticleEditorTextblock extends StatelessWidget {
  final TextEditingController controller;
  final bool isBold;
  final bool isItalic;
  final bool isUnderline;
  final String textSize;
  final TextAlign textAlign;
  final List<ArticleEditorEntity>? articleEditorEntities;

  const ArticleEditorTextblock({
    super.key,
    required this.controller,
    required this.isBold,
    required this.isItalic,
    required this.isUnderline,
    required this.textSize,
    required this.textAlign,
    required this.articleEditorEntities,
  });

  @override
  Widget build(BuildContext context) {
    final initialContent = articleEditorEntities
        ?.map((entity) => entity.content)
        .join('\n\n'); // Separar cada bloque con dos saltos de línea

    // Asignar el contenido concatenado al controlador
    controller.text = initialContent ?? '';
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 45, 45, 46),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color.fromARGB(255, 73, 73, 73),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: articleEditorEntities!.map((entity) {
            final controller = TextEditingController(text: entity.content);
            return TextField(
              controller: controller,
              maxLines: null,
              textAlign: entity.textAlign,
              style: TextStyle(
                color: Colors.white,
                fontWeight: isBold || entity.isBold
                    ? FontWeight.bold
                    : FontWeight.normal,
                fontStyle: isItalic || entity.isItalic
                    ? FontStyle.italic
                    : FontStyle.normal,
                decoration: isUnderline || entity.isUnderline
                    ? TextDecoration.underline
                    : TextDecoration.none,
                fontSize: entity.textSize == 'P'
                    ? 16
                    : entity.textSize == 'H1'
                        ? 32
                        : entity.textSize == 'H2'
                            ? 28
                            : entity.textSize == 'H3'
                                ? 24
                                : 20,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Start writing here...',
                hintStyle: TextStyle(color: Colors.grey),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
