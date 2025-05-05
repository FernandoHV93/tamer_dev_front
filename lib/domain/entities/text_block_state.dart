import 'package:flutter/material.dart';

class TextBlockState {
  final TextEditingController controller;
  bool isBold;
  bool isItalic;
  bool isUnderline;
  String textSize;
  TextAlign textAlign;

  TextBlockState({
    required this.controller,
    this.isBold = false,
    this.isItalic = false,
    this.isUnderline = false,
    this.textSize = 'P',
    this.textAlign = TextAlign.left,
  });
}
