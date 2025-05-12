import 'package:flutter/material.dart';

abstract class ArticleBlock {
  final String id;
  ArticleBlock(this.id);
}

class TextBlock extends ArticleBlock {
  String text;
  BlockFormat format;
  TextBlock({required String id, required this.text, required this.format})
      : super(id);
}

class CodeBlock extends ArticleBlock {
  String code;
  CodeBlock({required String id, required this.code}) : super(id);
}

class QuoteBlock extends ArticleBlock {
  String quote;
  QuoteBlock({required String id, required this.quote}) : super(id);
}

class TableBlock extends ArticleBlock {
  List<List<String>> rows;
  TableBlock({required String id, required this.rows}) : super(id);
}

class BlockFormat {
  bool isBold;
  bool isItalic;
  bool isUnderline;
  String fontSize;
  TextAlign align;
  BlockFormat({
    this.isBold = false,
    this.isItalic = false,
    this.isUnderline = false,
    this.fontSize = 'P',
    this.align = TextAlign.left,
  });
}
