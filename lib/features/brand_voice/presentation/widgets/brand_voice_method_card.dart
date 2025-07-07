import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BrandVoiceMethodCard extends StatelessWidget {
  final String title;
  final String description;
  final bool selected;
  final bool recommended;
  final VoidCallback onTap;
  final String? badgeText;
  final String iconPath;

  const BrandVoiceMethodCard({
    super.key,
    required this.title,
    required this.description,
    required this.selected,
    required this.recommended,
    required this.onTap,
    required this.iconPath,
    this.badgeText,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF1A2636) : const Color(0xFF23262F),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color:
                selected ? const Color(0xFF2D8EFF) : Colors.blueGrey.shade700,
            width: recommended ? 3.0 : 1.5,
          ),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  iconPath,
                  width: 28,
                  height: 28,
                  colorFilter: ColorFilter.mode(
                    selected ? Colors.white : Colors.blue[200]!,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  title,
                  style: TextStyle(
                    color: selected ? Colors.white : Colors.blue[100],
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: TextStyle(
                    color: selected ? Colors.white70 : Colors.blueGrey[200],
                    fontSize: 13.5,
                  ),
                ),
              ],
            ),
            if (recommended && badgeText != null)
              Positioned(
                top: -18,
                right: -18,
                child: Transform.translate(
                  offset: const Offset(0, 0),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 29, 233, 90),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      badgeText!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 11.5,
                        letterSpacing: 0.1,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
