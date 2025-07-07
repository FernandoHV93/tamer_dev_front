import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ContentAnalysisOptionCard extends StatelessWidget {
  final String iconPath;
  final String title;
  final String description;
  final bool selected;
  final VoidCallback onTap;

  const ContentAnalysisOptionCard({
    super.key,
    required this.iconPath,
    required this.title,
    required this.description,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF23262F) : const Color(0xFF23262F),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color:
                selected ? const Color(0xFF2D8EFF) : Colors.blueGrey.shade700,
            width: selected ? 2.2 : 1.2,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              iconPath,
              width: 32,
              height: 32,
              colorFilter:
                  const ColorFilter.mode(Color(0xFF2D8EFF), BlendMode.srcIn),
            ),
            const SizedBox(height: 18),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 13.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
