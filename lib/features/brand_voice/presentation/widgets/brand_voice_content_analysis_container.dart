import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/brand_voice_provider.dart';
import 'content_analysis_option_card.dart';
import 'content_analysis_upload_view.dart';
import 'content_analysis_paste_view.dart';
import 'package:ia_web_front/core/providers/session_provider.dart';
import '../provider/brand_form_provider.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../../domain/entities/brand_voice_entity.dart';

class BrandVoiceContentAnalysisContainer extends StatefulWidget {
  const BrandVoiceContentAnalysisContainer({super.key});

  @override
  State<BrandVoiceContentAnalysisContainer> createState() =>
      _BrandVoiceContentAnalysisContainerState();
}

class _BrandVoiceContentAnalysisContainerState
    extends State<BrandVoiceContentAnalysisContainer> {
  bool showBrandVoiceForm = false;

  Future<void> _handleAnalyzeContent(
      BuildContext context, String pastedText) async {
    final provider = Provider.of<BrandVoiceProvider>(context, listen: false);
    final sessionProvider = SessionProvider.of(context);
    final brandFormProvider =
        Provider.of<BrandFormProvider>(context, listen: false);
    final brand = await provider.analyzeContentAndGenerateBrandVoice(
      sessionProvider.sessionID,
      sessionProvider.userID,
      pastedText,
    );
    if (brand != null) {
      brandFormProvider.setEditingBrand(brand);
      setState(() => showBrandVoiceForm = true);
    }
  }

  Future<void> _handleAnalyzeFile(BuildContext context,
      {File? file, List<int>? bytes, String? fileName}) async {
    final provider = Provider.of<BrandVoiceProvider>(context, listen: false);
    final sessionProvider = SessionProvider.of(context);
    final brandFormProvider =
        Provider.of<BrandFormProvider>(context, listen: false);
    BrandVoice? brand;
    if (kIsWeb && bytes != null && fileName != null) {
      // Aquí deberías implementar el método correcto en el provider/usecase para web
      // brand = await provider.analyzeFileBytesAndGenerateBrandVoice(sessionProvider.sessionID, sessionProvider.userID, bytes, fileName);
      // Por ahora, solo muestra un error o ignora
      provider.setError('Web file upload not implemented');
      return;
    } else if (file != null) {
      brand = await provider.analyzeFileAndGenerateBrandVoice(
        sessionProvider.sessionID,
        sessionProvider.userID,
        file.path,
      );
    }
    if (brand != null) {
      brandFormProvider.setEditingBrand(brand);
      setState(() => showBrandVoiceForm = true);
    }
  }

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
                  onAnalyze: (
                      {File? file, List<int>? bytes, String? fileName}) async {
                    await _handleAnalyzeFile(context,
                        file: file, bytes: bytes, fileName: fileName);
                  },
                );
              } else if (step == ContentAnalysisStep.paste) {
                return ContentAnalysisPasteView(
                  onBack: provider.goBackToOptions,
                  onAnalyze: (pastedText) async {
                    await _handleAnalyzeContent(context, pastedText);
                  },
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
