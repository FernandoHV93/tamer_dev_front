import 'package:flutter/material.dart';

class ChildOptionButton extends StatelessWidget {
  final String title;
  final String description;
  final Color borderColor;
  final Color textColor;
  final VoidCallback onPressed;

  const ChildOptionButton({
    super.key,
    required this.title,
    required this.description,
    required this.borderColor,
    required this.textColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: borderColor, width: 0.8),
        ),
        fixedSize: const Size(500, 80),
        elevation: 0,
        foregroundColor: textColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black, // Siempre negro el title
            ),
          ),
          const SizedBox(height: 5),
          Text(
            description,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.normal,
              color: Colors.blueGrey,
            ),
          ),
        ],
      ),
    );
  }
}
