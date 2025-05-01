import 'package:flutter/material.dart';

class InputWithButton extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final String hint;
  final String buttonLabel;
  final VoidCallback onPressed;

  const InputWithButton({
    required this.title,
    required this.controller,
    required this.hint,
    required this.buttonLabel,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: hint,
                  border: const OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 10),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.blueGrey[50],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: onPressed,
              child: Text(
                buttonLabel,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.blue),
              ),
            )
          ],
        ),
      ],
    );
  }
}
