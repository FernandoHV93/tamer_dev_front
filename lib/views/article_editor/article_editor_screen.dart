import 'package:flutter/material.dart';
import 'package:ia_web_front/domain/entities/article_editor_entity.dart';
import 'package:ia_web_front/views/article_editor/components/article_editor_textblock.dart';
import 'package:ia_web_front/views/article_editor/components/article_editor_toolbar.dart';
import 'package:ia_web_front/views/article_editor/components/article_editor_top.dart';

class ArticleEditorScreen extends StatefulWidget {
  final List<ArticleEditorEntity>? articleEditorEntities;
  const ArticleEditorScreen({super.key, this.articleEditorEntities});

  @override
  State<ArticleEditorScreen> createState() => _ArticleEditorScreenState();
}

class _ArticleEditorScreenState extends State<ArticleEditorScreen> {
  final Map<String, VoidCallback> buttonActions = {
    'Download': () {
      debugPrint('Download button pressed');
    },
    'Export': () {
      debugPrint('Export button pressed');
    },
    'Publish': () {
      debugPrint('Publish button pressed');
    },
    'Save Draft': () {
      debugPrint('Save Draft button pressed');
    },
    'Done': () {
      debugPrint('Done button pressed');
    },
  };

  bool isBold = false;
  bool isItalic = false;
  bool isUnderline = false;
  String textSize = 'P';
  TextAlign textAlign = TextAlign.left;

  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.articleEditorEntities != null) {
      widget.articleEditorEntities!.map((element) {
        _textController.text = element.content;
        isBold = element.isBold;
        isItalic = element.isItalic;
        isUnderline = element.isUnderline;
        textSize = element.textSize;
        textAlign = element.textAlign;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        ArticleEditorTop(buttonActions: buttonActions),
        Expanded(
          child: Row(children: [
            Container(
              width: 30,
              color: const Color.fromARGB(255, 41, 41, 41),
            ),
            Expanded(
              child: Container(
                color: const Color.fromARGB(255, 31, 31, 31),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  child: Column(
                    children: [
                      ArticleEditorToolbar(
                        isBold: isBold,
                        isItalic: isItalic,
                        isUnderline: isUnderline,
                        textSize: textSize,
                        textAlign: textAlign,
                        onBoldToggle: () {
                          setState(() {
                            isBold = !isBold;
                          });
                        },
                        onItalicToggle: () {
                          setState(() {
                            isItalic = !isItalic;
                          });
                        },
                        onUnderlineToggle: () {
                          setState(() {
                            isUnderline = !isUnderline;
                          });
                        },
                        onTextSizeChange: (size) {
                          setState(() {
                            textSize = size;
                          });
                        },
                        onTextAlignChange: (align) {
                          setState(() {
                            textAlign = align;
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: ArticleEditorTextblock(
                          articleEditorEntities: widget.articleEditorEntities,
                          controller: _textController,
                          isBold: isBold,
                          isItalic: isItalic,
                          isUnderline: isUnderline,
                          textSize: textSize,
                          textAlign: textAlign,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(width: 30, color: const Color.fromARGB(255, 41, 41, 41))
          ]),
        ),
        const SizedBox(width: 16)
      ]),
    );
  }
}
