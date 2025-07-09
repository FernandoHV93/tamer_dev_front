import 'package:flutter/material.dart';
import '../../../domain/entities/deep_analysis_wizard_entity.dart';
import 'package:provider/provider.dart';
import '../../provider/deep_analysis_wizard_provider.dart';

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
              const Text(
                'Brand Voice Analysis Title',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelStyle: TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Color.fromARGB(255, 28, 30, 36),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide.none),
                  hintText: 'Enter a title for your brand voice analysis',
                  hintStyle: TextStyle(color: Colors.white54),
                ),
                style: const TextStyle(color: Colors.white),
                onChanged: (value) {
                  Provider.of<DeepAnalysisWizardProvider>(context,
                          listen: false)
                      .updateBrandTitle(value);
                },
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
              _section('Motivations and Values', [
                _qa('What motivates your audience to make purchasing decisions?',
                    wizardData.motivationsAndValuesSection.motivation)
              ]),
              _section('User Behavioral Patterns', [
                _qa("What are your audience's behavioral patterns?",
                    wizardData.userBehavioralPatternsSection.patterns),
              ]),
              _section('Fears, Frustations, and Obstacles', [
                _qa('What are the main fears of your audience?',
                    wizardData.fearsFrustrationsObstaclesSection.fears),
                _qa('what are the most common frustation of your audience?',
                    wizardData.fearsFrustrationsObstaclesSection.frustrations),
                _qa('What obstacles does your audience face?',
                    wizardData.fearsFrustrationsObstaclesSection.obstacles),
              ]),
              _section('Content Consumption', [
                _qa('What type of content does your audience consume?',
                    wizardData.contentConsumptionSection.contentType),
                _qa(
                    'Where does your audience consume this content?',
                    wizardData.contentConsumptionSection.channels.isEmpty
                        ? null
                        : wizardData.contentConsumptionSection.channels
                            .join(', ')),
              ]),
              _section('Tone and Language', [
                _qa('What tone and language does your audience use in daily life? (formality, expressions, style)',
                    wizardData.toneAndLanguageSection.tone),
                _qa('How does your audience describe their problems?',
                    wizardData.toneAndLanguageSection.describeProblems),
                _qa('How would your brand help solve those problems?',
                    wizardData.toneAndLanguageSection.brandHelp),
              ]),
              _section('Audience Expectations', [
                _qa('What expectations doeas your audience have of the brands they choose?',
                    wizardData.audienceExpectationsSection.expectations)
              ]),
              _section('Competitor Analysis', [
                _qa('How do your main competitors communicate?',
                    wizardData.competitorAnalysisSection.communication),
                _qa('What tone do your competitors use?',
                    wizardData.competitorAnalysisSection.selectedTone),
                _qa(
                    'What type of personality do your competitors project?',
                    wizardData.competitorAnalysisSection.personality.isEmpty
                        ? null
                        : wizardData.competitorAnalysisSection.personality
                            .join(', ')),
                _qa('What makes your brand different from others?',
                    wizardData.competitorAnalysisSection.brandDifference),
                _qa('How do you want your brand to be perceived in comparison to competitors?',
                    wizardData.competitorAnalysisSection.brandPerception),
                _qa('Should you adopt a similar voice or differentiate radically? Why?',
                    wizardData.competitorAnalysisSection.voiceStrategy),
              ]),
              _section('Brand Identity', [
                _qa("What is your brand's vision?",
                    wizardData.brandIdentitySection.vision),
                _qa("What is your brand's mission?",
                    wizardData.brandIdentitySection.mission),
                _qa("What are your brand's core values?",
                    wizardData.brandIdentitySection.coreValues),
                _qa("How do these values align with your audience's values?",
                    wizardData.brandIdentitySection.alignValues),
                _qa("What social or emotional problem is your brand committed to solving?",
                    wizardData.brandIdentitySection.problem),
                _qa("How do you want to impact the world or your customers' lives?",
                    wizardData.brandIdentitySection.impact),
              ]),
              _section('Brand Personality', [
                _qa(
                    'Is your brand young or mature?',
                    wizardData.brandPersonalitySection.dropdownValues.isNotEmpty
                        ? wizardData.brandPersonalitySection.dropdownValues[0]
                        : null),
                _qa(
                    'Is it traditional or avant-garde?',
                    wizardData.brandPersonalitySection.dropdownValues.length > 1
                        ? wizardData.brandPersonalitySection.dropdownValues[1]
                        : null),
                _qa(
                    'Is it classic or modern?',
                    wizardData.brandPersonalitySection.dropdownValues.length > 2
                        ? wizardData.brandPersonalitySection.dropdownValues[2]
                        : null),
                _qa(
                    'Is it introverted or extroverted?',
                    wizardData.brandPersonalitySection.dropdownValues.length > 3
                        ? wizardData.brandPersonalitySection.dropdownValues[3]
                        : null),
                _qa(
                    'Is it conservative or innovative?',
                    wizardData.brandPersonalitySection.dropdownValues.length > 4
                        ? wizardData.brandPersonalitySection.dropdownValues[4]
                        : null),
                _qa(
                    'Is it reflective or playful?',
                    wizardData.brandPersonalitySection.dropdownValues.length > 5
                        ? wizardData.brandPersonalitySection.dropdownValues[5]
                        : null),
                _qa(
                    'Is it conventional or rebellious?',
                    wizardData.brandPersonalitySection.dropdownValues.length > 6
                        ? wizardData.brandPersonalitySection.dropdownValues[6]
                        : null),
                _qa(
                    'Is it exclusive or open?',
                    wizardData.brandPersonalitySection.dropdownValues.length > 7
                        ? wizardData.brandPersonalitySection.dropdownValues[7]
                        : null),
                _qa('If your brand were a person, how would you describe it?',
                    wizardData.brandPersonalitySection.brandAsPerson),
                _qa('If your brand were a famous person, who would it be?',
                    wizardData.brandPersonalitySection.brandAsFamous),
              ]),
              _section('Fundamental Values', [
                _qa('What does each value mean for your brand: intelligence, strength, creativity, order, fun, freedom?',
                    wizardData.fundamentalValuesSection.meaning),
                _qa('Which of these values are essential and which are secondary?',
                    wizardData.fundamentalValuesSection.essential),
                _qa('How can you convey these values through communication?',
                    wizardData.fundamentalValuesSection.convey),
              ]),
              _section('Brand Archetypes', [
                _qa('Which brand archetype best reflects your purpose?',
                    wizardData.brandArchetypesSection.selectedArchetype),
                _qa('What is the main motivation of the chosen archetype, and how does it align with your brand?',
                    wizardData.brandArchetypesSection.motivation),
                _qa('How can you use this archetype to connect emotionally with your audience?',
                    wizardData.brandArchetypesSection.emotionalConnection),
                _qa('What emotions do you want your brand to evoke?',
                    wizardData.brandArchetypesSection.emotionsToEvoke),
                _qa('Can you combine archetypes to make your brand voice more unique? Which ones?',
                    wizardData.brandArchetypesSection.combineArchetypes),
              ]),
              _section('Brand Dimensions', [
                _qa('How do you want your brand to be perceived in terms of sincerity?',
                    wizardData.brandDimensionsSection.sincerity),
                _qa('What emotional characteristics do you want to convey?',
                    wizardData.brandDimensionsSection.emotional),
                _qa('How do you want to convey competence?',
                    wizardData.brandDimensionsSection.competence),
                _qa('What level of sophistication do you want to reflect?',
                    wizardData.brandDimensionsSection.sophistication),
                _qa('Should your brand be perceived as robust or strong? Why?',
                    wizardData.brandDimensionsSection.robust),
              ]),
              _section('Desired User Behavior', [
                _qa('How can you ensure your brand is perceived as honest?',
                    wizardData.desiredUserBehaviorSection.honest),
                _qa('What elements make a brand friendly to your audience?',
                    wizardData.desiredUserBehaviorSection.friendly),
                _qa("What characteristics do users value most in a brand's behavior?",
                    wizardData.desiredUserBehaviorSection.valued),
              ]),
              _section('Tone and Style', [
                _qa('How formal or informal should your brand tone be?',
                    wizardData.toneAndStyleSection.selectedFormality),
                _qa('How serious or playful should your brand be?',
                    wizardData.toneAndStyleSection.selectedSeriousness),
                _qa('What vocabulary best represents your brand?',
                    wizardData.toneAndStyleSection.vocabulary),
                _qa('How does your brand communicate bad news or sensitive topics?',
                    wizardData.toneAndStyleSection.badNews),
                _qa('What is the appropriate tone for each platform or channel?',
                    wizardData.toneAndStyleSection.platformTone),
              ]),
              _section('Brand Voice Guide', [
                _qa('What expressions and words should always be used to represent your brand voice?',
                    wizardData.brandVoiceGuideSection.expressions),
                _qa('What words or expressions should be avoided?',
                    wizardData.brandVoiceGuideSection.avoid),
                _qa('How does your brand respond to criticism or unhappy customers?',
                    wizardData.brandVoiceGuideSection.criticism),
                _qa('How does your brand express gratitude or recognition?',
                    wizardData.brandVoiceGuideSection.gratitude),
                _qa('How does your brand communication differ between digital and print media?',
                    wizardData.brandVoiceGuideSection.digitalVsPrint),
              ]),
              _section('Consistency and Adaptability', [
                _qa('How do you ensure the consistency of your brand voice when multiple team members create content?',
                    wizardData.consistencyAndAdaptabilitySection.consistency),
                _qa('What guidelines or processes should be established to maintain brand voice consistency?',
                    wizardData.consistencyAndAdaptabilitySection.guidelines),
                _qa('How should your brand voice adapt during crises or major changes?',
                    wizardData.consistencyAndAdaptabilitySection.adapt),
              ]),
              _section('Brand Storytelling', [
                _qa('What is the central story of your brand?',
                    wizardData.brandStorytellingSection.centralStory),
                _qa('What narrative elements should always be present in your communications?',
                    wizardData.brandStorytellingSection.narrativeElements),
                _qa('How can you use storytelling to make your brand more human and relatable?',
                    wizardData.brandStorytellingSection.humanRelatable),
              ]),
              _section('Voice Evaluation', [
                _qa('What indicators can you use to measure the effectiveness of your brand voice?',
                    wizardData.voiceEvaluationSection.indicators),
                _qa('How do you collect feedback from your audience about your brand voice?',
                    wizardData.voiceEvaluationSection.feedback),
                _qa('How should your brand voice evolve over time?',
                    wizardData.voiceEvaluationSection.evolve),
                _qa('What adjustments should be made based on cultural or social changes affecting your audience?',
                    wizardData.voiceEvaluationSection.adjustments),
              ]),
              _section('Implementation', [
                _qa('How should your brand sound in an Instagram post versus a blog post?',
                    wizardData.implementationSection.instagramVsBlog),
                _qa('How should your brand respond to a negative comment?',
                    wizardData.implementationSection.negativeComment),
                _qa('What examples of "do\'s" and "don\'ts" are necessary to guide content creators?',
                    wizardData.implementationSection.dosDonts),
                _qa('How does your brand voice apply at different stages of the customer journey?',
                    wizardData.implementationSection.customerJourney),
              ]),
              _section('Brand Perception', [
                _qa('If your brand were an object, what would it be and why?',
                    wizardData.brandPerceptionSection.object),
                _qa('If your brand had an internal slogan or mantra, what would it be?',
                    wizardData.brandPerceptionSection.slogan),
                _qa('How do you want your customers to feel after interacting with your content?',
                    wizardData.brandPerceptionSection.feeling),
                _qa('What do you want customers to think about your brand after making a purchase?',
                    wizardData.brandPerceptionSection.afterPurchase),
              ]),
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
