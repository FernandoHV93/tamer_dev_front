import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ia_web_front/core/desing/app_constant.dart';
import 'package:ia_web_front/views/article_editor_finish/controllers/textformat_controller.dart';
import 'package:ia_web_front/views/article_editor_finish/controllers/widgets_controller.dart';
import 'package:ia_web_front/data/models/models.dart';
import 'package:ia_web_front/views/article_editor_finish/widgets/textsize_button.dart';
import 'package:ia_web_front/views/article_editor_finish/widgets/tool_button.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';

class ArticleEditorToolbar extends StatelessWidget {
  const ArticleEditorToolbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final formatController = context.watch<TextFormatController>();
    final widgetsController = context.read<WidgetsController>();

    Future<TableBlock?> showInsertTableDialog(BuildContext context) async {
      final rowController = TextEditingController();
      final columnController = TextEditingController();

      return showDialog<TableBlock>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Insert Table"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: rowController,
                  keyboardType: TextInputType.number,
                  decoration:
                      const InputDecoration(labelText: "Number of Rows"),
                ),
                TextField(
                  controller: columnController,
                  keyboardType: TextInputType.number,
                  decoration:
                      const InputDecoration(labelText: "Number of Columns"),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  final rows = int.tryParse(rowController.text) ?? 0;
                  final columns = int.tryParse(columnController.text) ?? 0;

                  if (rows > 0 && columns > 0) {
                    final data = List.generate(
                      rows,
                      (_) => List.generate(columns, (_) => ''),
                    );
                    Navigator.pop(context,
                        TableBlock(id: UniqueKey().toString(), rows: data));
                  }
                },
                child: const Text("Insert"),
              ),
            ],
          );
        },
      );
    }

    Future<ImageBlock?> showInsertImageDialog(BuildContext context) async {
      String mode = 'online';
      final urlController = TextEditingController();
      final captionController = TextEditingController();
      final widthController = TextEditingController(text: '50');
      final heightController = TextEditingController(text: '50');
      String? localImagePath;

      return showDialog<ImageBlock>(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: const Text('Insert Image'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Radio<String>(
                          value: 'online',
                          groupValue: mode,
                          onChanged: (val) => setState(() => mode = val!),
                        ),
                        const Text('Online'),
                        Radio<String>(
                          value: 'local',
                          groupValue: mode,
                          onChanged: (val) => setState(() => mode = val!),
                        ),
                        const Text('Local'),
                      ],
                    ),
                    if (mode == 'online') ...[
                      TextField(
                        controller: urlController,
                        decoration:
                            const InputDecoration(labelText: 'Image URL'),
                      ),
                      TextField(
                        controller: captionController,
                        decoration: const InputDecoration(labelText: 'Caption'),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: widthController,
                              keyboardType: TextInputType.number,
                              decoration:
                                  const InputDecoration(labelText: 'Width'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              controller: heightController,
                              keyboardType: TextInputType.number,
                              decoration:
                                  const InputDecoration(labelText: 'Height'),
                            ),
                          ),
                        ],
                      ),
                    ],
                    if (mode == 'local') ...[
                      ElevatedButton(
                        onPressed: () async {
                          final result = await FilePicker.platform
                              .pickFiles(type: FileType.image);
                          if (result != null) {
                            setState(() =>
                                localImagePath = result.files.single.path);
                            debugPrint('$localImagePath');
                          }
                        },
                        child: const Text('Seleccionar imagen local'),
                      ),
                      if (localImagePath != null)
                        Text('Seleccionada: $localImagePath',
                            style: const TextStyle(fontSize: 12)),
                      TextField(
                        controller: captionController,
                        decoration: const InputDecoration(labelText: 'Caption'),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: widthController,
                              keyboardType: TextInputType.number,
                              decoration:
                                  const InputDecoration(labelText: 'Width'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              controller: heightController,
                              keyboardType: TextInputType.number,
                              decoration:
                                  const InputDecoration(labelText: 'Height'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () {
                      if (mode == 'online' && urlController.text.isNotEmpty) {
                        Navigator.pop(
                          context,
                          ImageBlock(
                            id: UniqueKey().toString(),
                            url: urlController.text,
                            text: captionController.text,
                            width: int.tryParse(widthController.text) ?? 200,
                            height: int.tryParse(heightController.text) ?? 200,
                          ),
                        );
                      } else if (mode == 'local' && localImagePath != null) {
                        Navigator.pop(
                          context,
                          ImageBlock(
                            id: UniqueKey().toString(),
                            url: localImagePath!,
                            text: captionController.text,
                            width: int.tryParse(widthController.text) ?? 200,
                            height: int.tryParse(heightController.text) ?? 200,
                          ),
                        );
                      }
                    },
                    child: const Text('Insertar'),
                  ),
                ],
              );
            },
          );
        },
      );
    }

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
              final tableBlock = await showInsertTableDialog(context);
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
                final imageBlock = await showInsertImageDialog(context);
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
