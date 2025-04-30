import 'package:flutter/material.dart';

class LanguageItem extends StatelessWidget {
  final String language;
  final String flagPath;

  const LanguageItem(
      {super.key, required this.language, required this.flagPath});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          flagPath,
          width: 30,
          height: 30,
          fit: BoxFit.cover,
        ),
        const SizedBox(width: 8),
        Text(language),
      ],
    );
  }
}
