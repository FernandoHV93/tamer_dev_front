import 'sections/general_audience_data_section_entity.dart';
import 'sections/problems_and_desires_section_entity.dart';
import 'sections/motivations_and_values_section_entity.dart';
import 'sections/user_behavioral_patterns_section_entity.dart';
import 'sections/fears_frustrations_obstacles_section_entity.dart';
import 'sections/content_consumption_section_entity.dart';
import 'sections/tone_and_language_section_entity.dart';
import 'sections/audience_expectations_section_entity.dart';
import 'sections/competitor_analysis_section_entity.dart';
import 'sections/brand_identity_section_entity.dart';
import 'sections/brand_personality_section_entity.dart';
import 'sections/fundamental_values_section_entity.dart';
import 'sections/brand_archetypes_section_entity.dart';
import 'sections/brand_dimensions_section_entity.dart';
import 'sections/desired_user_behavior_section_entity.dart';
import 'sections/tone_and_style_section_entity.dart';
import 'sections/brand_voice_guide_section_entity.dart';
import 'sections/consistency_and_adaptability_section_entity.dart';
import 'sections/brand_storytelling_section_entity.dart';
import 'sections/voice_evaluation_section_entity.dart';
import 'sections/implementation_section_entity.dart';
import 'sections/brand_perception_section_entity.dart';

class DeepAnalysisWizardEntity {
  final String brandTitle;
  final GeneralAudienceDataSectionEntity generalAudienceDataSection;
  final ProblemsAndDesiresSectionEntity problemsAndDesiresSection;
  final MotivationsAndValuesSectionEntity motivationsAndValuesSection;
  final UserBehavioralPatternsSectionEntity userBehavioralPatternsSection;
  final FearsFrustrationsObstaclesSectionEntity
      fearsFrustrationsObstaclesSection;
  final ContentConsumptionSectionEntity contentConsumptionSection;
  final ToneAndLanguageSectionEntity toneAndLanguageSection;
  final AudienceExpectationsSectionEntity audienceExpectationsSection;
  final CompetitorAnalysisSectionEntity competitorAnalysisSection;
  final BrandIdentitySectionEntity brandIdentitySection;
  final BrandPersonalitySectionEntity brandPersonalitySection;
  final FundamentalValuesSectionEntity fundamentalValuesSection;
  final BrandArchetypesSectionEntity brandArchetypesSection;
  final BrandDimensionsSectionEntity brandDimensionsSection;
  final DesiredUserBehaviorSectionEntity desiredUserBehaviorSection;
  final ToneAndStyleSectionEntity toneAndStyleSection;
  final BrandVoiceGuideSectionEntity brandVoiceGuideSection;
  final ConsistencyAndAdaptabilitySectionEntity
      consistencyAndAdaptabilitySection;
  final BrandStorytellingSectionEntity brandStorytellingSection;
  final VoiceEvaluationSectionEntity voiceEvaluationSection;
  final ImplementationSectionEntity implementationSection;
  final BrandPerceptionSectionEntity brandPerceptionSection;

  DeepAnalysisWizardEntity({
    this.brandTitle = '',
    required this.generalAudienceDataSection,
    required this.problemsAndDesiresSection,
    required this.motivationsAndValuesSection,
    required this.userBehavioralPatternsSection,
    required this.fearsFrustrationsObstaclesSection,
    required this.contentConsumptionSection,
    required this.toneAndLanguageSection,
    required this.audienceExpectationsSection,
    required this.competitorAnalysisSection,
    required this.brandIdentitySection,
    required this.brandPersonalitySection,
    required this.fundamentalValuesSection,
    required this.brandArchetypesSection,
    required this.brandDimensionsSection,
    required this.desiredUserBehaviorSection,
    required this.toneAndStyleSection,
    required this.brandVoiceGuideSection,
    required this.consistencyAndAdaptabilitySection,
    required this.brandStorytellingSection,
    required this.voiceEvaluationSection,
    required this.implementationSection,
    required this.brandPerceptionSection,
  });

  factory DeepAnalysisWizardEntity.fromJson(Map<String, dynamic> json) =>
      DeepAnalysisWizardEntity(
        brandTitle: json['brandTitle'] ?? '',
        generalAudienceDataSection: GeneralAudienceDataSectionEntity.fromJson(
            json['generalAudienceDataSection'] ?? {}),
        problemsAndDesiresSection: ProblemsAndDesiresSectionEntity.fromJson(
            json['problemsAndDesiresSection'] ?? {}),
        motivationsAndValuesSection: MotivationsAndValuesSectionEntity.fromJson(
            json['motivationsAndValuesSection'] ?? {}),
        userBehavioralPatternsSection:
            UserBehavioralPatternsSectionEntity.fromJson(
                json['userBehavioralPatternsSection'] ?? {}),
        fearsFrustrationsObstaclesSection:
            FearsFrustrationsObstaclesSectionEntity.fromJson(
                json['fearsFrustrationsObstaclesSection'] ?? {}),
        contentConsumptionSection: ContentConsumptionSectionEntity.fromJson(
            json['contentConsumptionSection'] ?? {}),
        toneAndLanguageSection: ToneAndLanguageSectionEntity.fromJson(
            json['toneAndLanguageSection'] ?? {}),
        audienceExpectationsSection: AudienceExpectationsSectionEntity.fromJson(
            json['audienceExpectationsSection'] ?? {}),
        competitorAnalysisSection: CompetitorAnalysisSectionEntity.fromJson(
            json['competitorAnalysisSection'] ?? {}),
        brandIdentitySection: BrandIdentitySectionEntity.fromJson(
            json['brandIdentitySection'] ?? {}),
        brandPersonalitySection: BrandPersonalitySectionEntity.fromJson(
            json['brandPersonalitySection'] ?? {}),
        fundamentalValuesSection: FundamentalValuesSectionEntity.fromJson(
            json['fundamentalValuesSection'] ?? {}),
        brandArchetypesSection: BrandArchetypesSectionEntity.fromJson(
            json['brandArchetypesSection'] ?? {}),
        brandDimensionsSection: BrandDimensionsSectionEntity.fromJson(
            json['brandDimensionsSection'] ?? {}),
        desiredUserBehaviorSection: DesiredUserBehaviorSectionEntity.fromJson(
            json['desiredUserBehaviorSection'] ?? {}),
        toneAndStyleSection: ToneAndStyleSectionEntity.fromJson(
            json['toneAndStyleSection'] ?? {}),
        brandVoiceGuideSection: BrandVoiceGuideSectionEntity.fromJson(
            json['brandVoiceGuideSection'] ?? {}),
        consistencyAndAdaptabilitySection:
            ConsistencyAndAdaptabilitySectionEntity.fromJson(
                json['consistencyAndAdaptabilitySection'] ?? {}),
        brandStorytellingSection: BrandStorytellingSectionEntity.fromJson(
            json['brandStorytellingSection'] ?? {}),
        voiceEvaluationSection: VoiceEvaluationSectionEntity.fromJson(
            json['voiceEvaluationSection'] ?? {}),
        implementationSection: ImplementationSectionEntity.fromJson(
            json['implementationSection'] ?? {}),
        brandPerceptionSection: BrandPerceptionSectionEntity.fromJson(
            json['brandPerceptionSection'] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        'brandTitle': brandTitle,
        'generalAudienceDataSection': generalAudienceDataSection.toJson(),
        'problemsAndDesiresSection': problemsAndDesiresSection.toJson(),
        'motivationsAndValuesSection': motivationsAndValuesSection.toJson(),
        'userBehavioralPatternsSection': userBehavioralPatternsSection.toJson(),
        'fearsFrustrationsObstaclesSection':
            fearsFrustrationsObstaclesSection.toJson(),
        'contentConsumptionSection': contentConsumptionSection.toJson(),
        'toneAndLanguageSection': toneAndLanguageSection.toJson(),
        'audienceExpectationsSection': audienceExpectationsSection.toJson(),
        'competitorAnalysisSection': competitorAnalysisSection.toJson(),
        'brandIdentitySection': brandIdentitySection.toJson(),
        'brandPersonalitySection': brandPersonalitySection.toJson(),
        'fundamentalValuesSection': fundamentalValuesSection.toJson(),
        'brandArchetypesSection': brandArchetypesSection.toJson(),
        'brandDimensionsSection': brandDimensionsSection.toJson(),
        'desiredUserBehaviorSection': desiredUserBehaviorSection.toJson(),
        'toneAndStyleSection': toneAndStyleSection.toJson(),
        'brandVoiceGuideSection': brandVoiceGuideSection.toJson(),
        'consistencyAndAdaptabilitySection':
            consistencyAndAdaptabilitySection.toJson(),
        'brandStorytellingSection': brandStorytellingSection.toJson(),
        'voiceEvaluationSection': voiceEvaluationSection.toJson(),
        'implementationSection': implementationSection.toJson(),
        'brandPerceptionSection': brandPerceptionSection.toJson(),
      };

  DeepAnalysisWizardEntity copyWith({
    String? brandTitle,
    GeneralAudienceDataSectionEntity? generalAudienceDataSection,
    ProblemsAndDesiresSectionEntity? problemsAndDesiresSection,
    MotivationsAndValuesSectionEntity? motivationsAndValuesSection,
    UserBehavioralPatternsSectionEntity? userBehavioralPatternsSection,
    FearsFrustrationsObstaclesSectionEntity? fearsFrustrationsObstaclesSection,
    ContentConsumptionSectionEntity? contentConsumptionSection,
    ToneAndLanguageSectionEntity? toneAndLanguageSection,
    AudienceExpectationsSectionEntity? audienceExpectationsSection,
    CompetitorAnalysisSectionEntity? competitorAnalysisSection,
    BrandIdentitySectionEntity? brandIdentitySection,
    BrandPersonalitySectionEntity? brandPersonalitySection,
    FundamentalValuesSectionEntity? fundamentalValuesSection,
    BrandArchetypesSectionEntity? brandArchetypesSection,
    BrandDimensionsSectionEntity? brandDimensionsSection,
    DesiredUserBehaviorSectionEntity? desiredUserBehaviorSection,
    ToneAndStyleSectionEntity? toneAndStyleSection,
    BrandVoiceGuideSectionEntity? brandVoiceGuideSection,
    ConsistencyAndAdaptabilitySectionEntity? consistencyAndAdaptabilitySection,
    BrandStorytellingSectionEntity? brandStorytellingSection,
    VoiceEvaluationSectionEntity? voiceEvaluationSection,
    ImplementationSectionEntity? implementationSection,
    BrandPerceptionSectionEntity? brandPerceptionSection,
  }) {
    return DeepAnalysisWizardEntity(
      brandTitle: brandTitle ?? this.brandTitle,
      generalAudienceDataSection:
          generalAudienceDataSection ?? this.generalAudienceDataSection,
      problemsAndDesiresSection:
          problemsAndDesiresSection ?? this.problemsAndDesiresSection,
      motivationsAndValuesSection:
          motivationsAndValuesSection ?? this.motivationsAndValuesSection,
      userBehavioralPatternsSection:
          userBehavioralPatternsSection ?? this.userBehavioralPatternsSection,
      fearsFrustrationsObstaclesSection: fearsFrustrationsObstaclesSection ??
          this.fearsFrustrationsObstaclesSection,
      contentConsumptionSection:
          contentConsumptionSection ?? this.contentConsumptionSection,
      toneAndLanguageSection:
          toneAndLanguageSection ?? this.toneAndLanguageSection,
      audienceExpectationsSection:
          audienceExpectationsSection ?? this.audienceExpectationsSection,
      competitorAnalysisSection:
          competitorAnalysisSection ?? this.competitorAnalysisSection,
      brandIdentitySection: brandIdentitySection ?? this.brandIdentitySection,
      brandPersonalitySection:
          brandPersonalitySection ?? this.brandPersonalitySection,
      fundamentalValuesSection:
          fundamentalValuesSection ?? this.fundamentalValuesSection,
      brandArchetypesSection:
          brandArchetypesSection ?? this.brandArchetypesSection,
      brandDimensionsSection:
          brandDimensionsSection ?? this.brandDimensionsSection,
      desiredUserBehaviorSection:
          desiredUserBehaviorSection ?? this.desiredUserBehaviorSection,
      toneAndStyleSection: toneAndStyleSection ?? this.toneAndStyleSection,
      brandVoiceGuideSection:
          brandVoiceGuideSection ?? this.brandVoiceGuideSection,
      consistencyAndAdaptabilitySection: consistencyAndAdaptabilitySection ??
          this.consistencyAndAdaptabilitySection,
      brandStorytellingSection:
          brandStorytellingSection ?? this.brandStorytellingSection,
      voiceEvaluationSection:
          voiceEvaluationSection ?? this.voiceEvaluationSection,
      implementationSection:
          implementationSection ?? this.implementationSection,
      brandPerceptionSection:
          brandPerceptionSection ?? this.brandPerceptionSection,
    );
  }
}
