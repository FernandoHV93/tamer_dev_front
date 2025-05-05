import 'package:flutter/material.dart';

class ArticleEditorEntity {
  final String content;
  final bool isBold;
  final bool isItalic;
  final bool isUnderline;
  final String textSize;
  final TextAlign textAlign;

  ArticleEditorEntity({
    required this.content,
    required this.isBold,
    required this.isItalic,
    required this.isUnderline,
    required this.textSize,
    required this.textAlign,
  });

  factory ArticleEditorEntity.fromJson(Map<String, dynamic> json) {
    return ArticleEditorEntity(
      content: json['content'],
      isBold: json['formatting']['isBold'],
      isItalic: json['formatting']['isItalic'],
      isUnderline: json['formatting']['isUnderline'],
      textSize: json['formatting']['textSize'],
      textAlign: _parseTextAlign(json['formatting']['textAlign']),
    );
  }

  static TextAlign _parseTextAlign(String align) {
    switch (align) {
      case 'center':
        return TextAlign.center;
      case 'right':
        return TextAlign.right;
      case 'left':
      default:
        return TextAlign.left;
    }
  }
}
