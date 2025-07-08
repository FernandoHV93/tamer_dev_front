import 'package:flutter/material.dart';
import '../../../domain/entities/deep_analysis_wizard_entity.dart';

class DeepAnalysisSummary extends StatelessWidget {
  final DeepAnalysisWizardEntity wizardData;
  final TextEditingController titleController;
  final VoidCallback onBack;
  final VoidCallback onGenerate;
  final bool isLoading;

  const DeepAnalysisSummary({
    super.key,
    required this.wizardData,
    required this.titleController,
    required this.onBack,
    required this.onGenerate,
    this.isLoading = false,
  });

  Widget _section(String title, List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.only(top: 32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  Widget _qa(String question, String? answer) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(question,
              style: const TextStyle(fontSize: 15, color: Colors.white)),
          const SizedBox(height: 2),
          Text(
            (answer == null || answer.isEmpty) ? 'Not answered' : answer,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color(0xFF23262F),
          borderRadius: BorderRadius.circular(18),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Review Your Answers',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              const SizedBox(height: 24),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Brand Voice Analysis Title *',
                  labelStyle: TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Color(0xFF23262F),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide.none),
                  hintText: 'Enter a title for your brand voice analysis',
                  hintStyle: TextStyle(color: Colors.white54),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              // Sección ejemplo: General Audience Data
              _section('General Audience Data', [
                _qa(
                    'What is the average age of your audience?',
                    wizardData.generalAudienceDataSection.averageAge
                        ?.toString()),
                _qa(
                    'Which generation does your ideal customer belong to?',
                    wizardData.generalAudienceDataSection.generations
                        .join(', ')),
                _qa('What is the predominant gender of your audience?',
                    wizardData.generalAudienceDataSection.predominantGender),
                _qa('What is the educational level of your audience?',
                    wizardData.generalAudienceDataSection.educationLevel),
                _qa('What is the primary occupation of your audience?',
                    wizardData.generalAudienceDataSection.occupation),
              ]),
              _section('Problems and Desires', [
                _qa('What are the main problems your audience faces?',
                    wizardData.problemsAndDesiresSection.problems),
                _qa('What are the primary desires of your audience?',
                    wizardData.problemsAndDesiresSection.desires),
              ]),
              // ... Agrega aquí el resto de secciones y preguntas ...
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: isLoading ? null : onBack,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF3A7BFF),
                      side: const BorderSide(color: Color(0xFF3A7BFF)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18)),
                    ),
                    child: const Text('Back to Wizard'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: isLoading ? null : onGenerate,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3A7BFF),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18)),
                    ),
                    child: isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                                strokeWidth: 2, color: Colors.white))
                        : const Text('Generate Brand Voice',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
