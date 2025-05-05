import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ia_web_front/core/desing/app_constant.dart';
import 'package:ia_web_front/views/article_editor/components/textSizeButton.dart';
import 'package:ia_web_front/views/article_editor/components/tool_button.dart';

class ArticleEditorToolbar extends StatelessWidget {
  final bool isBold;
  final bool isItalic;
  final bool isUnderline;
  final String textSize;
  final TextAlign textAlign;
  final VoidCallback onBoldToggle;
  final VoidCallback onItalicToggle;
  final VoidCallback onUnderlineToggle;
  final ValueChanged<String> onTextSizeChange;
  final ValueChanged<TextAlign> onTextAlignChange;

  const ArticleEditorToolbar({
    super.key,
    required this.isBold,
    required this.isItalic,
    required this.isUnderline,
    required this.textSize,
    required this.textAlign,
    required this.onBoldToggle,
    required this.onItalicToggle,
    required this.onUnderlineToggle,
    required this.onTextSizeChange,
    required this.onTextAlignChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 45, 45, 46),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color.fromARGB(255, 73, 73, 73),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ToolButton(
            icon: FontAwesomeIcons.bold,
            isActive: isBold,
            onPressed: onBoldToggle,
          ),
          ToolButton(
            icon: FontAwesomeIcons.italic,
            isActive: isItalic,
            onPressed: onItalicToggle,
          ),
          ToolButton(
            icon: FontAwesomeIcons.underline,
            isActive: isUnderline,
            onPressed: onUnderlineToggle,
          ),
          const SizedBox(width: 16),
          ...AppConstants.articleEditortextSizes.map((size) {
            return TextSizeButton(
              size: size,
              currentSize: textSize,
              onTap: () {
                onTextSizeChange(size);
              },
            );
          }),
          const SizedBox(width: 16),
          ToolButton(
            icon: FontAwesomeIcons.alignLeft,
            isActive: textAlign == TextAlign.left,
            onPressed: () {
              onTextAlignChange(TextAlign.left);
            },
          ),
          ToolButton(
            icon: FontAwesomeIcons.alignCenter,
            isActive: textAlign == TextAlign.center,
            onPressed: () {
              onTextAlignChange(TextAlign.center);
            },
          ),
          ToolButton(
            icon: FontAwesomeIcons.alignRight,
            isActive: textAlign == TextAlign.right,
            onPressed: () {
              onTextAlignChange(TextAlign.right);
            },
          ),
        ],
      ),
    );
  }
}
