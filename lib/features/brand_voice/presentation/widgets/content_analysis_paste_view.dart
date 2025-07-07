import 'package:flutter/material.dart';

class ContentAnalysisPasteView extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onAnalyze;

  const ContentAnalysisPasteView(
      {super.key, required this.onBack, required this.onAnalyze});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: 180,
          decoration: BoxDecoration(
            color: const Color(0xFF23262F),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.blueGrey.shade700, width: 1.2),
          ),
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              maxLines: null,
              expands: true,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Paste your content here...',
                hintStyle: TextStyle(color: Colors.white38),
                isCollapsed: true,
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            OutlinedButton(
              onPressed: onBack,
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF2D8EFF),
                side: const BorderSide(color: Color(0xFF2D8EFF)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(horizontal: 28, vertical: 14),
              ),
              child: const Text('Back'),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: onAnalyze,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2D8EFF),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(horizontal: 28, vertical: 14),
              ),
              child: const Text('Analyze Content'),
            ),
          ],
        ),
      ],
    );
  }
}
