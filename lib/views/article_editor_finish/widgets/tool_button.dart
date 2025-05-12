import 'package:flutter/material.dart';

class ToolButton extends StatefulWidget {
  final IconData icon;
  final bool isActive;
  final VoidCallback onPressed;

  const ToolButton({
    super.key,
    required this.icon,
    required this.isActive,
    required this.onPressed,
  });

  @override
  State<ToolButton> createState() => _ToolButtonState();
}

class _ToolButtonState extends State<ToolButton> {
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
        onTap: widget.onPressed,
        child: Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: widget.isActive
                ? Colors.blue
                : isHovered
                    ? const Color.fromARGB(
                        80, 34, 120, 226) // Fondo azul claro al pasar el mouse
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Icon(
            widget.icon,
            color: widget.isActive
                ? Colors.white
                : isHovered
                    ? Colors
                        .blue.shade700 // Ícono azul intenso al pasar el mouse
                    : Colors.white,
            size: 20,
          ),
        ),
      ),
    );
  }
}
