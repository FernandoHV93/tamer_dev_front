// Widget reusable para iconos SVG
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgIconButton extends StatelessWidget {
  final String assetPath;
  final Color? color;
  final double size;
  final VoidCallback onPressed;

  const SvgIconButton({
    super.key,
    required this.assetPath,
    this.color,
    this.size = 24,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: SvgPicture.asset(
        assetPath,
        color: color,
        width: size,
        height: size,
      ),
      iconSize: size + 8, // Aumenta el área táctil
      onPressed: onPressed,
    );
  }
}
