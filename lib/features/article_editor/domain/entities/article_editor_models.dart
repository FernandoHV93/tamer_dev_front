import 'dart:typed_data';

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
  TextBlock tableTitle;
  TextBlock description;
  List<List<String>> rows;
  TableBlock(
      {required String id,
      required this.rows,
      required this.tableTitle,
      required this.description})
      : super(id);
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

class ImageBlock extends ArticleBlock {
  final String? url;
  final int width;
  final int height;
  final String text;
  final Uint8List? bytes;
  ImageBlock(
      {required String id,
      this.url,
      required this.height,
      required this.width,
      required this.text,
      this.bytes})
      : super(id);
}
