import 'package:flutter/material.dart';
import 'package:ia_web_front/features/article_editor/domain/entities/article_editor_models.dart';
import 'package:ia_web_front/features/article_editor/presentation/controllers/widgets_controller.dart';

import 'package:provider/provider.dart';

class WidgetRenderer extends StatelessWidget {
  final ArticleBlock block;
  const WidgetRenderer({super.key, required this.block});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<WidgetsController>();

    if (block is TextBlock) {
      final textBlock = block as TextBlock;
      final style = TextStyle(
        fontSize: _mapFontSize(textBlock.format.fontSize),
        fontWeight:
            textBlock.format.isBold ? FontWeight.bold : FontWeight.normal,
        fontStyle:
            textBlock.format.isItalic ? FontStyle.italic : FontStyle.normal,
        decoration: textBlock.format.isUnderline
            ? TextDecoration.underline
            : TextDecoration.none,
        color: Colors.white,
      );

      return GestureDetector(
        onTap: () => controller.selectBlock(textBlock.id),
        child: TextField(
          controller: TextEditingController.fromValue(
            TextEditingValue(
              text: textBlock.text,
              selection: TextSelection.collapsed(offset: textBlock.text.length),
            ),
          ),
          style: style,
          textAlign: textBlock.format.align,
          maxLines: null,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Escribe algo...',
            hintStyle: TextStyle(color: Colors.grey),
          ),
          onChanged: (value) {
            controller.updateBlock(
              textBlock.id,
              TextBlock(
                id: textBlock.id,
                text: value,
                format: textBlock.format,
              ),
            );
          },
        ),
      );
    }

    if (block is CodeBlock) {
      final codeBlock = block as CodeBlock;
      return GestureDetector(
        onTap: () => controller.selectBlock(codeBlock.id),
        child: Container(
          padding: const EdgeInsets.all(12),
          color: const Color.fromARGB(255, 40, 40, 40),
          width: double.infinity,
          child: TextField(
            controller: TextEditingController.fromValue(
              TextEditingValue(
                text: codeBlock.code,
                selection:
                    TextSelection.collapsed(offset: codeBlock.code.length),
              ),
            ),
            style: const TextStyle(
                fontFamily: 'monospace', color: Colors.greenAccent),
            maxLines: null,
            decoration:
                const InputDecoration.collapsed(hintText: 'Escribe código...'),
            onChanged: (value) {
              controller.updateBlock(
                codeBlock.id,
                CodeBlock(id: codeBlock.id, code: value),
              );
            },
          ),
        ),
      );
    }
    if (block is ImageBlock) {
      final imageBlock = block as ImageBlock;
      if (imageBlock.bytes != null) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.memory(
              imageBlock.bytes!,
              width: imageBlock.width.toDouble(),
              height: imageBlock.height.toDouble(),
              fit: BoxFit.cover,
              errorBuilder: (_, error, __) => const Text(
                'Error decoding image bytes',
                style: TextStyle(color: Colors.red),
              ),
            ),
            if (imageBlock.text.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  imageBlock.text,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
          ],
        );
      }
      final url = imageBlock.url ?? '';
      if (url.isNotEmpty) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              url,
              width: imageBlock.width.toDouble(),
              height: imageBlock.height.toDouble(),
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                debugPrint('error cargando la imagen: $error');
                return const Text(
                  'error',
                  style: TextStyle(color: Colors.red),
                );
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            (loadingProgress.expectedTotalBytes ?? 1)
                        : null,
                  ),
                );
              },
            ),
            if (imageBlock.text.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  imageBlock.text,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
          ],
        );
      }
    }
    if (block is QuoteBlock) {
      final quoteBlock = block as QuoteBlock;
      return GestureDetector(
        onTap: () => controller.selectBlock(quoteBlock.id),
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
                text: quoteBlock.quote,
                selection:
                    TextSelection.collapsed(offset: quoteBlock.quote.length),
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
                quoteBlock.id,
                QuoteBlock(id: quoteBlock.id, quote: value),
              );
            },
          ),
        ),
      );
    }

    if (block is TableBlock) {
      final tableBlock = block as TableBlock;
      return GestureDetector(
        onTap: () => controller.selectBlock(tableBlock.id),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1) Editable Title
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
              child: TextField(
                controller: TextEditingController.fromValue(
                  TextEditingValue(
                    text: tableBlock.tableTitle.text,
                    selection: TextSelection.collapsed(
                      offset: tableBlock.tableTitle.text.length,
                    ),
                  ),
                ),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                decoration: InputDecoration(
                  hintText: 'Título de la tabla',
                  hintStyle: TextStyle(color: Colors.white54),
                  border: InputBorder.none,
                ),
                onChanged: (newTitle) {
                  final newTitleBlock = TextBlock(
                    id: tableBlock.tableTitle.id,
                    text: newTitle,
                    format: tableBlock.tableTitle.format,
                  );
                  controller.updateBlock(
                    tableBlock.id,
                    TableBlock(
                      id: tableBlock.id,
                      tableTitle: newTitleBlock,
                      description: tableBlock.description,
                      rows: tableBlock.rows,
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 8),

            // 2) La propia tabla editable
            Column(
              children: tableBlock.rows.asMap().entries.map((entry) {
                final rowIndex = entry.key;
                final row = entry.value;
                return Row(
                  children: row.asMap().entries.map((cellEntry) {
                    final cellIndex = cellEntry.key;
                    final cellText = cellEntry.value;
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: TextField(
                          controller: TextEditingController.fromValue(
                            TextEditingValue(
                              text: cellText,
                              selection: TextSelection.collapsed(
                                  offset: cellText.length),
                            ),
                          ),
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            isDense: true,
                            filled: true,
                            fillColor: Color.fromARGB(255, 50, 50, 50),
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (newCell) {
                            // clonamos la matriz de filas
                            final newRows = tableBlock.rows
                                .map((r) => List<String>.from(r))
                                .toList();
                            newRows[rowIndex][cellIndex] = newCell;
                            controller.updateBlock(
                              tableBlock.id,
                              TableBlock(
                                id: tableBlock.id,
                                tableTitle: tableBlock.tableTitle,
                                description: tableBlock.description,
                                rows: newRows,
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  }).toList(),
                );
              }).toList(),
            ),
            const SizedBox(height: 8),
            // 3) Editable Description
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
              child: TextField(
                controller: TextEditingController.fromValue(
                  TextEditingValue(
                    text: tableBlock.description.text,
                    selection: TextSelection.collapsed(
                      offset: tableBlock.description.text.length,
                    ),
                  ),
                ),
                style: TextStyle(
                  color: Colors.white70,
                  fontStyle: FontStyle.italic,
                ),
                decoration: InputDecoration(
                  hintText: 'Descripción',
                  hintStyle: TextStyle(color: Colors.white38),
                  border: InputBorder.none,
                ),
                onChanged: (newDesc) {
                  final newDescBlock = TextBlock(
                    id: tableBlock.description.id,
                    text: newDesc,
                    format: tableBlock.description.format,
                  );
                  controller.updateBlock(
                    tableBlock.id,
                    TableBlock(
                      id: tableBlock.id,
                      tableTitle: tableBlock.tableTitle,
                      description: newDescBlock,
                      rows: tableBlock.rows,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    }

    return const SizedBox.shrink();
  }

  double _mapFontSize(String size) {
    switch (size) {
      case 'H1':
        return 32;
      case 'H2':
        return 28;
      case 'H3':
        return 24;
      case 'H4':
        return 20;
      default:
        return 16;
    }
  }
}
