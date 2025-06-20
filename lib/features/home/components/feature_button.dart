import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FeatureButton extends StatelessWidget {
  final String iconPath;
  final String title;
  final String description;
  final String badgeText;
  final VoidCallback onPressed;

  const FeatureButton({
    super.key,
    required this.iconPath,
    required this.title,
    required this.description,
    required this.badgeText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF23272F), // Gris claro
          elevation: 4,
          padding: const EdgeInsets.all(0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        onPressed: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
          child: Row(
            children: [
              // Icon container
              Container(
                width: 48,
                height: 48,
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: const Color(0xFF181A20), // Fondo icono
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SvgPicture.asset(
                  iconPath,
                  colorFilter:
                      const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
              ),
              const SizedBox(width: 18),
              // Title & description
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                    const SizedBox(height: 4),
                    Text(description,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        )),
                  ],
                ),
              ),
              const SizedBox(width: 18),
              // Badge container
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF31343B), // Badge color
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  badgeText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
