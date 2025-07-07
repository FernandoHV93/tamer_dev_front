import 'package:flutter/material.dart';
import 'package:ia_web_front/core/desing/app_constant.dart';

class BrandVoiceCard extends StatelessWidget {
  final List<String> brandVoices;
  final String selectedVoice;
  final VoidCallback? onAdd;
  final ValueChanged<String?>? onChanged;

  const BrandVoiceCard({
    super.key,
    this.brandVoices = const ['None'],
    this.selectedVoice = 'None',
    this.onAdd,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(
            maxWidth: AppConstants.kArticleBuilderMaxWidth),
        decoration: BoxDecoration(
          color: const Color(0xFF181A20),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Brand Voice',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 6),
                const Icon(Icons.info_outline, color: Colors.white38, size: 18),
                const Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 22, vertical: 12),
                  ),
                  onPressed: onAdd,
                  child: const Text('Add',
                      style: TextStyle(fontSize: 15, color: Colors.white)),
                ),
              ],
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: selectedVoice,
              items: brandVoices
                  .map((voice) => DropdownMenuItem<String>(
                        value: voice,
                        child: Text(voice,
                            style: const TextStyle(color: Colors.white)),
                      ))
                  .toList(),
              onChanged: onChanged,
              dropdownColor: const Color(0xFF232733),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFF232733),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFF363A45)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFF2563EB)),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),
            const SizedBox(height: 18),
            Wrap(
              children: [
                const Text(
                  'Create unique styles and tones for different situations using, ensuring your content always remains consistent.',
                  style: TextStyle(color: Colors.white54, fontSize: 14),
                ),
                InkWell(
                  onTap: onAdd,
                  child: const Text(
                    'Brand Voice',
                    style: TextStyle(
                        color: Color(0xFF2563EB),
                        fontSize: 14,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
