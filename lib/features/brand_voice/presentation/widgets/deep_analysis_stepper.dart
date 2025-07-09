import 'package:flutter/material.dart';
import 'sections/general_audience_data_section.dart';
import 'sections/problems_and_desires_section.dart';
import 'sections/motivations_and_values_section.dart';
import 'sections/user_behavioral_patterns_section.dart';
import 'sections/fears_frustrations_obstacles_section.dart';
import 'sections/content_consumption_section.dart';
import 'sections/tone_and_language_section.dart';
import 'sections/audience_expectations_section.dart';
import 'sections/competitor_analysis_section.dart';
import 'sections/brand_identity_section.dart';
import 'sections/brand_personality_section.dart';
import 'sections/fundamental_values_section.dart';
import 'sections/brand_archetypes_section.dart';
import 'sections/brand_dimensions_section.dart';
import 'sections/desired_user_behavior_section.dart';
import 'sections/tone_and_style_section.dart';
import 'sections/brand_voice_guide_section.dart';
import 'sections/consistency_and_adaptability_section.dart';
import 'sections/brand_storytelling_section.dart';
import 'sections/voice_evaluation_section.dart';
import 'sections/implementation_section.dart';
import 'sections/brand_perception_section.dart';
import 'sections/deep_analysis_summary.dart';
import 'package:provider/provider.dart';
import '../provider/deep_analysis_wizard_provider.dart';
import '../provider/brand_form_provider.dart';
import '../../domain/entities/brand_voice_entity.dart';
import 'package:ia_web_front/core/providers/session_provider.dart';
import '../provider/brand_voice_provider.dart';

class DeepAnalysisStepper extends StatefulWidget {
  final ScrollController scrollController;
  const DeepAnalysisStepper({super.key, required this.scrollController});

  @override
  State<DeepAnalysisStepper> createState() => DeepAnalysisStepperState();
}

class DeepAnalysisStepperState extends State<DeepAnalysisStepper> {
  static const int totalSections = 22;
  int currentSection = 0;
  bool showSummary = false;
  bool showBrandVoiceForm = false;
  BrandVoice? generatedBrandVoice;
  final TextEditingController _titleController = TextEditingController();

  List<Widget> get sections => [
        const GeneralAudienceDataSection(),
        const ProblemsAndDesiresSection(),
        const MotivationsAndValuesSection(),
        const UserBehavioralPatternsSection(),
        const FearsFrustrationsObstaclesSection(),
        const ContentConsumptionSection(),
        const ToneAndLanguageSection(),
        const AudienceExpectationsSection(),
        const CompetitorAnalysisSection(),
        const BrandIdentitySection(),
        const BrandPersonalitySection(),
        const FundamentalValuesSection(),
        const BrandArchetypesSection(),
        const BrandDimensionsSection(),
        const DesiredUserBehaviorSection(),
        const ToneAndStyleSection(),
        const BrandVoiceGuideSection(),
        const ConsistencyAndAdaptabilitySection(),
        const BrandStorytellingSection(),
        const VoiceEvaluationSection(),
        const ImplementationSection(),
        const BrandPerceptionSection(),
      ];

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _goToSection(int section) {
    setState(() {
      currentSection = section;
      showSummary = false;
      showBrandVoiceForm = false;
    });
    // Scroll al tope después de cambiar de sección
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.scrollController.hasClients) {
        widget.scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _goToSummary() {
    setState(() {
      showSummary = true;
      showBrandVoiceForm = false;
    });
  }

  void _goToBrandVoiceForm(BrandVoice brand) {
    setState(() {
      generatedBrandVoice = brand;
      showBrandVoiceForm = true;
      showSummary = false;
    });
    // Cargar en el BrandFormProvider
    final brandFormProvider =
        Provider.of<BrandFormProvider>(context, listen: false);
    brandFormProvider.setEditingBrandFromWizard(brand);
    Provider.of<BrandVoiceProvider>(context, listen: false).selectMethod(null);
    ;
  }

  @override
  Widget build(BuildContext context) {
    final wizardProvider = Provider.of<DeepAnalysisWizardProvider>(context);
    double percent = ((currentSection + 1) / totalSections) * 100;

    if (showSummary) {
      return DeepAnalysisSummary(
        wizardData: wizardProvider.wizardEntity,
        titleController: _titleController,
        isLoading: wizardProvider.isLoading,
        onBack: () => setState(() => showSummary = false),
        onGenerate: () async {
          final session = SessionProvider.of(context);
          final brand = await wizardProvider.generateBrandVoice(
              session.sessionID, session.userID);
          if (brand != null) {
            _goToBrandVoiceForm(brand);
          }
        },
      );
    }

    return Center(
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: const Color(0xFF23262F),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Row(
              children: [
                const Text(
                  'Deep Analysis',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                const Spacer(),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  'Section ${currentSection + 1} of $totalSections',
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const Spacer(),
                Text(
                  '${percent.toStringAsFixed(0)}% Complete',
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 4),
            LinearProgressIndicator(
              value: (currentSection + 1) / totalSections,
              backgroundColor: Colors.white12,
              color: Colors.blueAccent,
              minHeight: 4,
            ),
            const SizedBox(height: 24),
            // Body
            AnimatedSize(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                color: const Color(0xFF23262F),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: SingleChildScrollView(
                    // El scroll principal ahora es externo, así que no se usa controller aquí
                    child: sections[currentSection],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Footer
            Row(
              children: [
                ElevatedButton(
                  onPressed: currentSection > 0
                      ? () => _goToSection(currentSection - 1)
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.blueAccent),
                  ),
                  child: const Text('Back'),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: currentSection < totalSections - 1
                      ? () {
                          _goToSection(currentSection + 1);
                        }
                      : () {
                          // Al ir al resumen, también scrollea al tope
                          widget.scrollController.animateTo(
                            0,
                            duration: const Duration(milliseconds: 350),
                            curve: Curves.easeInOut,
                          );
                          _goToSummary();
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                  ),
                  child: Text(
                    currentSection == totalSections - 1 ? 'Finish' : 'Next',
                    style: TextStyle(color: Colors.white),
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
