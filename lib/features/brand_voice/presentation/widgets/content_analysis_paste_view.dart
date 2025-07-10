import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/brand_voice_provider.dart';

class ContentAnalysisPasteView extends StatefulWidget {
  final VoidCallback onBack;
  final void Function(String pastedText) onAnalyze;

  const ContentAnalysisPasteView({
    super.key,
    required this.onBack,
    required this.onAnalyze,
  });

  @override
  State<ContentAnalysisPasteView> createState() =>
      _ContentAnalysisPasteViewState();
}

class _ContentAnalysisPasteViewState extends State<ContentAnalysisPasteView> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final brandVoiceProvider = Provider.of<BrandVoiceProvider>(context);
    final isLoading = brandVoiceProvider.isLoading;
    final providerError = brandVoiceProvider.error;
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
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _controller,
              maxLines: null,
              expands: true,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
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
              onPressed: isLoading ? null : widget.onBack,
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
              onPressed: isLoading
                  ? null
                  : () {
                      final pastedText = _controller.text.trim();
                      if (pastedText.isNotEmpty) {
                        widget.onAnalyze(pastedText);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Please paste some content.')),
                        );
                      }
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    isLoading ? Colors.blueGrey : const Color(0xFF2D8EFF),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
              ),
              child: isLoading
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Text('Analyze Content'),
            ),
          ],
        ),
      ],
    );
  }
}
