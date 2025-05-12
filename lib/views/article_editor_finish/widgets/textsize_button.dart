import 'package:flutter/material.dart';

class TextSizeButton extends StatefulWidget {
  final String size;
  final String currentSize;
  final VoidCallback onTap;

  const TextSizeButton({
    super.key,
    required this.size,
    required this.currentSize,
    required this.onTap,
  });

  @override
  State<TextSizeButton> createState() => _TextSizeButtonState();
}

class _TextSizeButtonState extends State<TextSizeButton> {
  bool isHovered =
      false; // Estado para detectar si el mouse está sobre el botón

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          isHovered = false;
        });
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          margin: const EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            color: widget.currentSize == widget.size
                ? Colors.blue
                : isHovered
                    ? const Color.fromARGB(
                        80, 34, 120, 226) // Fondo azul claro al pasar el mouse
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            widget.size,
            style: TextStyle(
              color: widget.currentSize == widget.size
                  ? Colors.white
                  : isHovered
                      ? const Color.fromARGB(255, 29, 131,
                          234) // Texto azul intenso al pasar el mouse
                      : Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
