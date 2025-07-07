import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ContentAnalysisUploadView extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onAnalyze;

  const ContentAnalysisUploadView(
      {super.key, required this.onBack, required this.onAnalyze});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            color: const Color(0xFF23262F),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.blueGrey.shade700, width: 1.2),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/icons/upload.svg',
                width: 40,
                height: 40,
                colorFilter:
                    const ColorFilter.mode(Color(0xFF2D8EFF), BlendMode.srcIn),
              ),
              const SizedBox(height: 12),
              const Text(
                'Drag and drop your file here',
                style: TextStyle(color: Colors.white70, fontSize: 15),
              ),
              const SizedBox(height: 6),
              const Text('or', style: TextStyle(color: Colors.white38)),
              const SizedBox(height: 6),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2D8EFF),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
                ),
                child:
                    const Text('Browse Files', style: TextStyle(fontSize: 15)),
              ),
              const SizedBox(height: 8),
              const Text(
                'Supports PDF, DOC, DOCX, and TXT files',
                style: TextStyle(color: Colors.white38, fontSize: 13),
              ),
            ],
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
              ),
              child: const Text('Analyze Content'),
            ),
          ],
        ),
      ],
    );
  }
}
