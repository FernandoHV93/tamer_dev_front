import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/brand_voice_provider.dart';
import 'content_analysis_option_card.dart';
import 'content_analysis_upload_view.dart';
import 'content_analysis_paste_view.dart';

class BrandVoiceContentAnalysisContainer extends StatelessWidget {
  const BrandVoiceContentAnalysisContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BrandVoiceProvider>(context);
    final step = provider.contentAnalysisStep;
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF23262F),
        borderRadius: BorderRadius.circular(18),
      ),
      padding: const EdgeInsets.all(28),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: const Text(
              'Content Analysis',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Builder(
            builder: (context) {
              if (step == ContentAnalysisStep.options) {
                return Row(
                  children: [
                    Expanded(
                      child: ContentAnalysisOptionCard(
                        iconPath: 'assets/images/icons/upload.svg',
                        title: 'Upload Document',
                        description:
                            'Upload your content in PDF, DOC, DOCX, or TXT format.',
                        selected: false,
                        onTap: provider.goToUpload,
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: ContentAnalysisOptionCard(
                        iconPath: 'assets/images/icons/clipboard-paste.svg',
                        title: 'Paste Text',
                        description:
                            'Copy and paste your content directly into a text field.',
                        selected: false,
                        onTap: provider.goToPaste,
                      ),
                    ),
                  ],
                );
              } else if (step == ContentAnalysisStep.upload) {
                return ContentAnalysisUploadView(
                  onBack: provider.goBackToOptions,
                  onAnalyze: () {},
                );
              } else if (step == ContentAnalysisStep.paste) {
                return ContentAnalysisPasteView(
                  onBack: provider.goBackToOptions,
                  onAnalyze: () {},
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
    );
  }
}
