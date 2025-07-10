import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_quill/quill_delta.dart' as quill;
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:ia_web_front/features/article_editor/domain/entities/article_entity_dto.dart';
import 'package:ia_web_front/features/article_editor/presentation/article_editor_top.dart';
import 'package:ia_web_front/features/article_editor/presentation/article_editor_seosettings.dart';
import 'package:ia_web_front/core/desing/app_constant.dart';

class ArticleEditorScreen extends StatefulWidget {
  final ArticleDto? article;
  const ArticleEditorScreen({super.key, this.article});

  @override
  State<ArticleEditorScreen> createState() => _ArticleEditorScreenState();
}

class _ArticleEditorScreenState extends State<ArticleEditorScreen> {
  late quill.QuillController _controller;

  @override
  void initState() {
    super.initState();
    if (widget.article != null) {
      final delta = _articleDtoToDelta(widget.article!);
      _controller = quill.QuillController(
        document: quill.Document.fromDelta(delta),
        selection: const TextSelection.collapsed(offset: 0),
      );
    } else {
      _controller = quill.QuillController.basic();
    }
  }

  quill.Delta _articleDtoToDelta(ArticleDto article) {
    final delta = quill.Delta();
    // H1 como título principal
    if (article.h1.text.isNotEmpty) {
      final h1Attrs = <String, dynamic>{'header': 1};
      final h1Align = article.h1.aligment.toLowerCase();
      if (h1Align == 'center' || h1Align == 'right' || h1Align == 'justify') {
        h1Attrs['align'] = h1Align;
      }
      delta.insert(article.h1.text + '\n\n', h1Attrs); // Separación extra
    }
    // Body: secciones
    for (final section in article.body) {
      // Título de sección
      if (section.title.text.isNotEmpty) {
        final titleAttrs = <String, dynamic>{'header': 2};
        final titleAlign = section.title.aligment.toLowerCase();
        if (titleAlign == 'center' ||
            titleAlign == 'right' ||
            titleAlign == 'justify') {
          titleAttrs['align'] = titleAlign;
        }
        delta.insert(
            section.title.text + '\n\n', titleAttrs); // Separación extra
      }
      // Texto
      for (final t in section.text) {
        if (t.text.isNotEmpty) {
          final attrs = <String, dynamic>{};
          if (t.N) attrs['bold'] = true;
          if (t.I) attrs['italic'] = true;
          if (t.U) attrs['underline'] = true;
          final align = t.aligment.toLowerCase();
          if (align == 'center' || align == 'right' || align == 'justify') {
            attrs['align'] = align;
          }
          delta.insert(t.text + '\n\n', attrs); // Separación extra
        }
      }
      // Imágenes (como embed)
      for (final img in section.images) {
        if (img is ImageDto && img.url.isNotEmpty) {
          delta.insert({'image': img.url});
          delta.insert('\n\n'); // Separación extra
        }
      }
      // Tablas (por ahora como texto plano)
      for (final table in section.tables) {
        if (table.tableTitle.text.isNotEmpty) {
          final tableTitleAttrs = <String, dynamic>{'bold': true};
          final tableTitleAlign = table.tableTitle.aligment.toLowerCase();
          if (tableTitleAlign == 'center' ||
              tableTitleAlign == 'right' ||
              tableTitleAlign == 'justify') {
            tableTitleAttrs['align'] = tableTitleAlign;
          }
          delta.insert(table.tableTitle.text + '\n', tableTitleAttrs);
        }
        for (final row in table.rows) {
          final rowText = row.map((cell) => cell.text).join(' | ');
          delta.insert(rowText + '\n');
        }
        delta.insert('\n'); // Separación extra después de la tabla
      }
      // Códigos
      for (final code in section.codes) {
        if (code.text.isNotEmpty) {
          final codeAttrs = <String, dynamic>{'code-block': true};
          final codeAlign = code.aligment.toLowerCase();
          if (codeAlign == 'center' ||
              codeAlign == 'right' ||
              codeAlign == 'justify') {
            codeAttrs['align'] = codeAlign;
          }
          delta.insert(code.text + '\n\n', codeAttrs); // Separación extra
        }
      }
      // Links
      for (final link in section.links) {
        if (link.text.isNotEmpty && link.url.isNotEmpty) {
          final linkAttrs = <String, dynamic>{'link': link.url};
          final linkAlign = link.aligment.toLowerCase();
          if (linkAlign == 'center' ||
              linkAlign == 'right' ||
              linkAlign == 'justify') {
            linkAttrs['align'] = linkAlign;
          }
          delta.insert(link.text, linkAttrs);
          delta.insert('\n\n'); // Separación extra
        }
      }
      // Citas
      for (final citation in section.citations) {
        if (citation.text.isNotEmpty) {
          final citationAttrs = <String, dynamic>{'blockquote': true};
          final citationAlign = citation.aligment.toLowerCase();
          if (citationAlign == 'center' ||
              citationAlign == 'right' ||
              citationAlign == 'justify') {
            citationAttrs['align'] = citationAlign;
          }
          delta.insert(
              citation.text + '\n\n', citationAttrs); // Separación extra
        }
      }
    }
    return delta;
  }

  @override
  Widget build(BuildContext context) {
    // Define acciones por defecto para todos los botones
    final Map<String, VoidCallback> buttonActions = {
      'Download': () {},
      'Export': () {},
      'Publish': () {},
      'Save Draft': () {},
      'Done': () => Navigator.of(context).pop(),
    };
    final allButtons = [
      ...AppConstants.articleEditorleftButtons,
      ...AppConstants.articleEditorightButtons,
    ];
    final Map<String, VoidCallback> safeButtonActions = {
      for (final key in allButtons) key: (buttonActions[key] ?? () {}),
    };
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 30, 30, 30),
      body: SafeArea(
        child: Column(
          children: [
            ArticleEditorTop(
              buttonActions: safeButtonActions,
            ),
            const SeoSettingsWidget(),
            quill.QuillSimpleToolbar(
              controller: _controller,
              config: quill.QuillSimpleToolbarConfig(
                toolbarIconAlignment: WrapAlignment.start,
                showFontFamily: false,
                showFontSize: true,
                showColorButton: false,
                showBackgroundColorButton: false,
                showAlignmentButtons: true,
                showListNumbers: true,
                showListBullets: true,
                showListCheck: true,
                showCodeBlock: true,
                showQuote: true,
                showLink: true,
                showUndo: true,
                showRedo: true,
                showDirection: false,
                showIndent: true,
                showClearFormat: true,
                showHeaderStyle: true,
                showBoldButton: true,
                showItalicButton: true,
                showUnderLineButton: true,
                showStrikeThrough: true,
                showInlineCode: true,
                showSearchButton: false,
                showSubscript: false,
                showSuperscript: false,
                showJustifyAlignment: false,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 37, 37, 37),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: quill.QuillEditor(
                    controller: _controller,
                    scrollController: ScrollController(),
                    focusNode: FocusNode(),
                    config: quill.QuillEditorConfig(
                      expands: true,
                      padding: const EdgeInsets.all(10),
                      embedBuilders: FlutterQuillEmbeds.editorBuilders(),
                      customStyles: quill.DefaultStyles(
                        h1: quill.DefaultTextBlockStyle(
                          const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(
                                211, 95, 162, 255), // Azul destacado
                            letterSpacing: 0.5,
                          ),
                          const quill.HorizontalSpacing(0, 0),
                          const quill.VerticalSpacing(32, 24),
                          const quill.VerticalSpacing(0, 0),
                          null,
                        ),
                        h2: quill.DefaultTextBlockStyle(
                          const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFB0C4DE), // Azul grisáceo
                            letterSpacing: 0.2,
                          ),
                          const quill.HorizontalSpacing(0, 0),
                          const quill.VerticalSpacing(24, 16),
                          const quill.VerticalSpacing(0, 0),
                          null,
                        ),
                        code: quill.DefaultTextBlockStyle(
                          const TextStyle(
                            color: Color(0xFFB5E853), // Verde claro para código
                            fontFamily: 'monospace',
                            fontSize: 15,
                          ),
                          const quill.HorizontalSpacing(200, 200),
                          const quill.VerticalSpacing(
                              24, 24), // margen vertical amplio
                          const quill.VerticalSpacing(0, 0),
                          BoxDecoration(
                            color: Color(0xFF23262F),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border:
                                Border.all(color: Color(0xFF3A8DFF), width: 1),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFF3A8DFF).withOpacity(0.08),
                                blurRadius: 8,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                        quote: quill.DefaultTextBlockStyle(
                          const TextStyle(
                            color: Colors.white70,
                            fontStyle: FontStyle.italic,
                            fontSize: 16,
                          ),
                          const quill.HorizontalSpacing(32, 32),
                          const quill.VerticalSpacing(24, 24),
                          const quill.VerticalSpacing(0, 0),
                          BoxDecoration(
                            color: Color(0xFF23262F),
                            border: Border(
                              left: BorderSide(
                                color: Color(0xFF3A8DFF),
                                width: 5,
                              ),
                            ),
                          ),
                        ),
                        link: const TextStyle(
                          color: Color(0xFF3A8DFF),
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
