import 'package:flutter/material.dart';
import 'package:ia_web_front/data/models/models.dart';

class TextFormatController extends ChangeNotifier {
  bool isBold = false;
  bool isItalic = false;
  bool isUnderline = false;
  String textSize = 'P';
  TextAlign textAlign = TextAlign.left;

  void toggleBold() {
    isBold = !isBold;
    notifyListeners();
  }

  void toggleItalic() {
    isItalic = !isItalic;
    notifyListeners();
  }

  void toggleUnderline() {
    isUnderline = !isUnderline;
    notifyListeners();
  }

  void changeTextSize(String size) {
    textSize = size;
    notifyListeners();
  }

  void changeTextAlign(TextAlign align) {
    textAlign = align;
    notifyListeners();
  }

  void setFormat({
    required bool bold,
    required bool italic,
    required bool underline,
    required String size,
    required TextAlign align,
  }) {
    isBold = bold;
    isItalic = italic;
    isUnderline = underline;
    textSize = size;
    textAlign = align;
    notifyListeners();
  }

  BlockFormat getCurrentFormat() {
    return BlockFormat(
      isBold: isBold,
      isItalic: isItalic,
      isUnderline: isUnderline,
      fontSize: textSize,
      align: textAlign,
    );
  }
}
