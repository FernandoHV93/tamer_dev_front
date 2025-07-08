import 'package:flutter/foundation.dart';
import '../../domain/entities/deep_analysis_wizard_entity.dart';
import '../../domain/entities/sections/general_audience_data_section_entity.dart';
import '../../domain/entities/sections/problems_and_desires_section_entity.dart';
import '../../domain/entities/sections/motivations_and_values_section_entity.dart';
import '../../domain/entities/sections/user_behavioral_patterns_section_entity.dart';
import '../../domain/entities/sections/fears_frustrations_obstacles_section_entity.dart';
import '../../domain/entities/sections/content_consumption_section_entity.dart';
import '../../domain/entities/sections/tone_and_language_section_entity.dart';
import '../../domain/entities/sections/audience_expectations_section_entity.dart';
import '../../domain/entities/sections/competitor_analysis_section_entity.dart';
import '../../domain/entities/sections/brand_identity_section_entity.dart';
import '../../domain/entities/sections/brand_personality_section_entity.dart';
import '../../domain/entities/sections/fundamental_values_section_entity.dart';
import '../../domain/entities/sections/brand_archetypes_section_entity.dart';
import '../../domain/entities/sections/brand_dimensions_section_entity.dart';
import '../../domain/entities/sections/desired_user_behavior_section_entity.dart';
import '../../domain/entities/sections/tone_and_style_section_entity.dart';
import '../../domain/entities/sections/brand_voice_guide_section_entity.dart';
import '../../domain/entities/sections/consistency_and_adaptability_section_entity.dart';
import '../../domain/entities/sections/brand_storytelling_section_entity.dart';
import '../../domain/entities/sections/voice_evaluation_section_entity.dart';
import '../../domain/entities/sections/implementation_section_entity.dart';
import '../../domain/entities/sections/brand_perception_section_entity.dart';
import '../../domain/entities/brand_voice_entity.dart';
import '../../domain/usecases/brand_voice_usecases.dart';
import 'brand_voice_provider.dart';
import 'package:flutter/material.dart';

class DeepAnalysisWizardProvider extends ChangeNotifier {
  DeepAnalysisWizardEntity _wizardEntity;
  final BrandVoiceUseCases brandVoiceUseCases;
  final BrandVoiceProvider brandVoiceProvider;

  bool _isLoading = false;
  String? _error;
  bool get isLoading => _isLoading;
  String? get error => _error;

  DeepAnalysisWizardProvider(
    this.brandVoiceUseCases, {
    required this.brandVoiceProvider,
  }) : _wizardEntity = DeepAnalysisWizardEntity(
          generalAudienceDataSection: GeneralAudienceDataSectionEntity(
            averageAge: null,
            generations: [],
            predominantGender: null,
            educationLevel: null,
            occupation: '',
          ),
          problemsAndDesiresSection: ProblemsAndDesiresSectionEntity(
            problems: '',
            desires: '',
          ),
          motivationsAndValuesSection: MotivationsAndValuesSectionEntity(
            motivation: '',
          ),
          userBehavioralPatternsSection: UserBehavioralPatternsSectionEntity(
            patterns: '',
          ),
          fearsFrustrationsObstaclesSection:
              FearsFrustrationsObstaclesSectionEntity(
            fears: '',
            frustrations: '',
            obstacles: '',
          ),
          contentConsumptionSection: ContentConsumptionSectionEntity(
            contentType: '',
            channels: [],
          ),
          toneAndLanguageSection: ToneAndLanguageSectionEntity(
            tone: '',
            describeProblems: '',
            brandHelp: '',
          ),
          audienceExpectationsSection: AudienceExpectationsSectionEntity(
            expectations: '',
          ),
          competitorAnalysisSection: CompetitorAnalysisSectionEntity(
            communication: '',
            selectedTone: '',
            personality: [],
            brandDifference: '',
            brandPerception: '',
            voiceStrategy: '',
          ),
          brandIdentitySection: BrandIdentitySectionEntity(
            vision: '',
            mission: '',
            coreValues: '',
            alignValues: '',
            problem: '',
            impact: '',
          ),
          brandPersonalitySection: BrandPersonalitySectionEntity(
            dropdownValues: List.filled(8, null),
            brandAsPerson: '',
            brandAsFamous: '',
          ),
          fundamentalValuesSection: FundamentalValuesSectionEntity(
            meaning: '',
            essential: '',
            convey: '',
          ),
          brandArchetypesSection: BrandArchetypesSectionEntity(
            selectedArchetype: null,
            motivation: '',
            emotionalConnection: '',
            emotionsToEvoke: '',
            combineArchetypes: '',
          ),
          brandDimensionsSection: BrandDimensionsSectionEntity(
            sincerity: '',
            emotional: '',
            competence: '',
            sophistication: '',
            robust: '',
          ),
          desiredUserBehaviorSection: DesiredUserBehaviorSectionEntity(
            honest: '',
            friendly: '',
            valued: '',
          ),
          toneAndStyleSection: ToneAndStyleSectionEntity(
            selectedFormality: null,
            selectedSeriousness: null,
            vocabulary: '',
            badNews: '',
            platformTone: '',
          ),
          brandVoiceGuideSection: BrandVoiceGuideSectionEntity(
            expressions: '',
            avoid: '',
            criticism: '',
            gratitude: '',
            digitalVsPrint: '',
          ),
          consistencyAndAdaptabilitySection:
              ConsistencyAndAdaptabilitySectionEntity(
            consistency: '',
            guidelines: '',
            adapt: '',
          ),
          brandStorytellingSection: BrandStorytellingSectionEntity(
            centralStory: '',
            narrativeElements: '',
            humanRelatable: '',
          ),
          voiceEvaluationSection: VoiceEvaluationSectionEntity(
            indicators: '',
            feedback: '',
            evolve: '',
            adjustments: '',
          ),
          implementationSection: ImplementationSectionEntity(
            instagramVsBlog: '',
            negativeComment: '',
            dosDonts: '',
            customerJourney: '',
          ),
          brandPerceptionSection: BrandPerceptionSectionEntity(
            object: '',
            slogan: '',
            feeling: '',
            afterPurchase: '',
          ),
        );

  DeepAnalysisWizardEntity get wizardEntity => _wizardEntity;

  void updateGeneralAudienceDataSection(
      GeneralAudienceDataSectionEntity entity) {
    _wizardEntity = DeepAnalysisWizardEntity(
      generalAudienceDataSection: entity,
      problemsAndDesiresSection: _wizardEntity.problemsAndDesiresSection,
      motivationsAndValuesSection: _wizardEntity.motivationsAndValuesSection,
      userBehavioralPatternsSection:
          _wizardEntity.userBehavioralPatternsSection,
      fearsFrustrationsObstaclesSection:
          _wizardEntity.fearsFrustrationsObstaclesSection,
      contentConsumptionSection: _wizardEntity.contentConsumptionSection,
      toneAndLanguageSection: _wizardEntity.toneAndLanguageSection,
      audienceExpectationsSection: _wizardEntity.audienceExpectationsSection,
      competitorAnalysisSection: _wizardEntity.competitorAnalysisSection,
      brandIdentitySection: _wizardEntity.brandIdentitySection,
      brandPersonalitySection: _wizardEntity.brandPersonalitySection,
      fundamentalValuesSection: _wizardEntity.fundamentalValuesSection,
      brandArchetypesSection: _wizardEntity.brandArchetypesSection,
      brandDimensionsSection: _wizardEntity.brandDimensionsSection,
      desiredUserBehaviorSection: _wizardEntity.desiredUserBehaviorSection,
      toneAndStyleSection: _wizardEntity.toneAndStyleSection,
      brandVoiceGuideSection: _wizardEntity.brandVoiceGuideSection,
      consistencyAndAdaptabilitySection:
          _wizardEntity.consistencyAndAdaptabilitySection,
      brandStorytellingSection: _wizardEntity.brandStorytellingSection,
      voiceEvaluationSection: _wizardEntity.voiceEvaluationSection,
      implementationSection: _wizardEntity.implementationSection,
      brandPerceptionSection: _wizardEntity.brandPerceptionSection,
    );
    notifyListeners();
  }

  void updateProblemsAndDesiresSection(ProblemsAndDesiresSectionEntity entity) {
    _wizardEntity = DeepAnalysisWizardEntity(
      generalAudienceDataSection: _wizardEntity.generalAudienceDataSection,
      problemsAndDesiresSection: entity,
      motivationsAndValuesSection: _wizardEntity.motivationsAndValuesSection,
      userBehavioralPatternsSection:
          _wizardEntity.userBehavioralPatternsSection,
      fearsFrustrationsObstaclesSection:
          _wizardEntity.fearsFrustrationsObstaclesSection,
      contentConsumptionSection: _wizardEntity.contentConsumptionSection,
      toneAndLanguageSection: _wizardEntity.toneAndLanguageSection,
      audienceExpectationsSection: _wizardEntity.audienceExpectationsSection,
      competitorAnalysisSection: _wizardEntity.competitorAnalysisSection,
      brandIdentitySection: _wizardEntity.brandIdentitySection,
      brandPersonalitySection: _wizardEntity.brandPersonalitySection,
      fundamentalValuesSection: _wizardEntity.fundamentalValuesSection,
      brandArchetypesSection: _wizardEntity.brandArchetypesSection,
      brandDimensionsSection: _wizardEntity.brandDimensionsSection,
      desiredUserBehaviorSection: _wizardEntity.desiredUserBehaviorSection,
      toneAndStyleSection: _wizardEntity.toneAndStyleSection,
      brandVoiceGuideSection: _wizardEntity.brandVoiceGuideSection,
      consistencyAndAdaptabilitySection:
          _wizardEntity.consistencyAndAdaptabilitySection,
      brandStorytellingSection: _wizardEntity.brandStorytellingSection,
      voiceEvaluationSection: _wizardEntity.voiceEvaluationSection,
      implementationSection: _wizardEntity.implementationSection,
      brandPerceptionSection: _wizardEntity.brandPerceptionSection,
    );
    notifyListeners();
  }

  void updateMotivationsAndValuesSection(
      MotivationsAndValuesSectionEntity entity) {
    _wizardEntity = DeepAnalysisWizardEntity(
      generalAudienceDataSection: _wizardEntity.generalAudienceDataSection,
      problemsAndDesiresSection: _wizardEntity.problemsAndDesiresSection,
      motivationsAndValuesSection: entity,
      userBehavioralPatternsSection:
          _wizardEntity.userBehavioralPatternsSection,
      fearsFrustrationsObstaclesSection:
          _wizardEntity.fearsFrustrationsObstaclesSection,
      contentConsumptionSection: _wizardEntity.contentConsumptionSection,
      toneAndLanguageSection: _wizardEntity.toneAndLanguageSection,
      audienceExpectationsSection: _wizardEntity.audienceExpectationsSection,
      competitorAnalysisSection: _wizardEntity.competitorAnalysisSection,
      brandIdentitySection: _wizardEntity.brandIdentitySection,
      brandPersonalitySection: _wizardEntity.brandPersonalitySection,
      fundamentalValuesSection: _wizardEntity.fundamentalValuesSection,
      brandArchetypesSection: _wizardEntity.brandArchetypesSection,
      brandDimensionsSection: _wizardEntity.brandDimensionsSection,
      desiredUserBehaviorSection: _wizardEntity.desiredUserBehaviorSection,
      toneAndStyleSection: _wizardEntity.toneAndStyleSection,
      brandVoiceGuideSection: _wizardEntity.brandVoiceGuideSection,
      consistencyAndAdaptabilitySection:
          _wizardEntity.consistencyAndAdaptabilitySection,
      brandStorytellingSection: _wizardEntity.brandStorytellingSection,
      voiceEvaluationSection: _wizardEntity.voiceEvaluationSection,
      implementationSection: _wizardEntity.implementationSection,
      brandPerceptionSection: _wizardEntity.brandPerceptionSection,
    );
    notifyListeners();
  }

  void updateUserBehavioralPatternsSection(
      UserBehavioralPatternsSectionEntity entity) {
    _wizardEntity = DeepAnalysisWizardEntity(
      generalAudienceDataSection: _wizardEntity.generalAudienceDataSection,
      problemsAndDesiresSection: _wizardEntity.problemsAndDesiresSection,
      motivationsAndValuesSection: _wizardEntity.motivationsAndValuesSection,
      userBehavioralPatternsSection: entity,
      fearsFrustrationsObstaclesSection:
          _wizardEntity.fearsFrustrationsObstaclesSection,
      contentConsumptionSection: _wizardEntity.contentConsumptionSection,
      toneAndLanguageSection: _wizardEntity.toneAndLanguageSection,
      audienceExpectationsSection: _wizardEntity.audienceExpectationsSection,
      competitorAnalysisSection: _wizardEntity.competitorAnalysisSection,
      brandIdentitySection: _wizardEntity.brandIdentitySection,
      brandPersonalitySection: _wizardEntity.brandPersonalitySection,
      fundamentalValuesSection: _wizardEntity.fundamentalValuesSection,
      brandArchetypesSection: _wizardEntity.brandArchetypesSection,
      brandDimensionsSection: _wizardEntity.brandDimensionsSection,
      desiredUserBehaviorSection: _wizardEntity.desiredUserBehaviorSection,
      toneAndStyleSection: _wizardEntity.toneAndStyleSection,
      brandVoiceGuideSection: _wizardEntity.brandVoiceGuideSection,
      consistencyAndAdaptabilitySection:
          _wizardEntity.consistencyAndAdaptabilitySection,
      brandStorytellingSection: _wizardEntity.brandStorytellingSection,
      voiceEvaluationSection: _wizardEntity.voiceEvaluationSection,
      implementationSection: _wizardEntity.implementationSection,
      brandPerceptionSection: _wizardEntity.brandPerceptionSection,
    );
    notifyListeners();
  }

  void updateFearsFrustrationsObstaclesSection(
      FearsFrustrationsObstaclesSectionEntity entity) {
    _wizardEntity = DeepAnalysisWizardEntity(
      generalAudienceDataSection: _wizardEntity.generalAudienceDataSection,
      problemsAndDesiresSection: _wizardEntity.problemsAndDesiresSection,
      motivationsAndValuesSection: _wizardEntity.motivationsAndValuesSection,
      userBehavioralPatternsSection:
          _wizardEntity.userBehavioralPatternsSection,
      fearsFrustrationsObstaclesSection: entity,
      contentConsumptionSection: _wizardEntity.contentConsumptionSection,
      toneAndLanguageSection: _wizardEntity.toneAndLanguageSection,
      audienceExpectationsSection: _wizardEntity.audienceExpectationsSection,
      competitorAnalysisSection: _wizardEntity.competitorAnalysisSection,
      brandIdentitySection: _wizardEntity.brandIdentitySection,
      brandPersonalitySection: _wizardEntity.brandPersonalitySection,
      fundamentalValuesSection: _wizardEntity.fundamentalValuesSection,
      brandArchetypesSection: _wizardEntity.brandArchetypesSection,
      brandDimensionsSection: _wizardEntity.brandDimensionsSection,
      desiredUserBehaviorSection: _wizardEntity.desiredUserBehaviorSection,
      toneAndStyleSection: _wizardEntity.toneAndStyleSection,
      brandVoiceGuideSection: _wizardEntity.brandVoiceGuideSection,
      consistencyAndAdaptabilitySection:
          _wizardEntity.consistencyAndAdaptabilitySection,
      brandStorytellingSection: _wizardEntity.brandStorytellingSection,
      voiceEvaluationSection: _wizardEntity.voiceEvaluationSection,
      implementationSection: _wizardEntity.implementationSection,
      brandPerceptionSection: _wizardEntity.brandPerceptionSection,
    );
    notifyListeners();
  }

  void updateContentConsumptionSection(ContentConsumptionSectionEntity entity) {
    _wizardEntity = DeepAnalysisWizardEntity(
      generalAudienceDataSection: _wizardEntity.generalAudienceDataSection,
      problemsAndDesiresSection: _wizardEntity.problemsAndDesiresSection,
      motivationsAndValuesSection: _wizardEntity.motivationsAndValuesSection,
      userBehavioralPatternsSection:
          _wizardEntity.userBehavioralPatternsSection,
      fearsFrustrationsObstaclesSection:
          _wizardEntity.fearsFrustrationsObstaclesSection,
      contentConsumptionSection: entity,
      toneAndLanguageSection: _wizardEntity.toneAndLanguageSection,
      audienceExpectationsSection: _wizardEntity.audienceExpectationsSection,
      competitorAnalysisSection: _wizardEntity.competitorAnalysisSection,
      brandIdentitySection: _wizardEntity.brandIdentitySection,
      brandPersonalitySection: _wizardEntity.brandPersonalitySection,
      fundamentalValuesSection: _wizardEntity.fundamentalValuesSection,
      brandArchetypesSection: _wizardEntity.brandArchetypesSection,
      brandDimensionsSection: _wizardEntity.brandDimensionsSection,
      desiredUserBehaviorSection: _wizardEntity.desiredUserBehaviorSection,
      toneAndStyleSection: _wizardEntity.toneAndStyleSection,
      brandVoiceGuideSection: _wizardEntity.brandVoiceGuideSection,
      consistencyAndAdaptabilitySection:
          _wizardEntity.consistencyAndAdaptabilitySection,
      brandStorytellingSection: _wizardEntity.brandStorytellingSection,
      voiceEvaluationSection: _wizardEntity.voiceEvaluationSection,
      implementationSection: _wizardEntity.implementationSection,
      brandPerceptionSection: _wizardEntity.brandPerceptionSection,
    );
    notifyListeners();
  }

  void updateToneAndLanguageSection(ToneAndLanguageSectionEntity entity) {
    _wizardEntity = DeepAnalysisWizardEntity(
      generalAudienceDataSection: _wizardEntity.generalAudienceDataSection,
      problemsAndDesiresSection: _wizardEntity.problemsAndDesiresSection,
      motivationsAndValuesSection: _wizardEntity.motivationsAndValuesSection,
      userBehavioralPatternsSection:
          _wizardEntity.userBehavioralPatternsSection,
      fearsFrustrationsObstaclesSection:
          _wizardEntity.fearsFrustrationsObstaclesSection,
      contentConsumptionSection: _wizardEntity.contentConsumptionSection,
      toneAndLanguageSection: entity,
      audienceExpectationsSection: _wizardEntity.audienceExpectationsSection,
      competitorAnalysisSection: _wizardEntity.competitorAnalysisSection,
      brandIdentitySection: _wizardEntity.brandIdentitySection,
      brandPersonalitySection: _wizardEntity.brandPersonalitySection,
      fundamentalValuesSection: _wizardEntity.fundamentalValuesSection,
      brandArchetypesSection: _wizardEntity.brandArchetypesSection,
      brandDimensionsSection: _wizardEntity.brandDimensionsSection,
      desiredUserBehaviorSection: _wizardEntity.desiredUserBehaviorSection,
      toneAndStyleSection: _wizardEntity.toneAndStyleSection,
      brandVoiceGuideSection: _wizardEntity.brandVoiceGuideSection,
      consistencyAndAdaptabilitySection:
          _wizardEntity.consistencyAndAdaptabilitySection,
      brandStorytellingSection: _wizardEntity.brandStorytellingSection,
      voiceEvaluationSection: _wizardEntity.voiceEvaluationSection,
      implementationSection: _wizardEntity.implementationSection,
      brandPerceptionSection: _wizardEntity.brandPerceptionSection,
    );
    notifyListeners();
  }

  void updateAudienceExpectationsSection(
      AudienceExpectationsSectionEntity entity) {
    _wizardEntity = DeepAnalysisWizardEntity(
      generalAudienceDataSection: _wizardEntity.generalAudienceDataSection,
      problemsAndDesiresSection: _wizardEntity.problemsAndDesiresSection,
      motivationsAndValuesSection: _wizardEntity.motivationsAndValuesSection,
      userBehavioralPatternsSection:
          _wizardEntity.userBehavioralPatternsSection,
      fearsFrustrationsObstaclesSection:
          _wizardEntity.fearsFrustrationsObstaclesSection,
      contentConsumptionSection: _wizardEntity.contentConsumptionSection,
      toneAndLanguageSection: _wizardEntity.toneAndLanguageSection,
      audienceExpectationsSection: entity,
      competitorAnalysisSection: _wizardEntity.competitorAnalysisSection,
      brandIdentitySection: _wizardEntity.brandIdentitySection,
      brandPersonalitySection: _wizardEntity.brandPersonalitySection,
      fundamentalValuesSection: _wizardEntity.fundamentalValuesSection,
      brandArchetypesSection: _wizardEntity.brandArchetypesSection,
      brandDimensionsSection: _wizardEntity.brandDimensionsSection,
      desiredUserBehaviorSection: _wizardEntity.desiredUserBehaviorSection,
      toneAndStyleSection: _wizardEntity.toneAndStyleSection,
      brandVoiceGuideSection: _wizardEntity.brandVoiceGuideSection,
      consistencyAndAdaptabilitySection:
          _wizardEntity.consistencyAndAdaptabilitySection,
      brandStorytellingSection: _wizardEntity.brandStorytellingSection,
      voiceEvaluationSection: _wizardEntity.voiceEvaluationSection,
      implementationSection: _wizardEntity.implementationSection,
      brandPerceptionSection: _wizardEntity.brandPerceptionSection,
    );
    notifyListeners();
  }

  void updateCompetitorAnalysisSection(CompetitorAnalysisSectionEntity entity) {
    _wizardEntity = DeepAnalysisWizardEntity(
      generalAudienceDataSection: _wizardEntity.generalAudienceDataSection,
      problemsAndDesiresSection: _wizardEntity.problemsAndDesiresSection,
      motivationsAndValuesSection: _wizardEntity.motivationsAndValuesSection,
      userBehavioralPatternsSection:
          _wizardEntity.userBehavioralPatternsSection,
      fearsFrustrationsObstaclesSection:
          _wizardEntity.fearsFrustrationsObstaclesSection,
      contentConsumptionSection: _wizardEntity.contentConsumptionSection,
      toneAndLanguageSection: _wizardEntity.toneAndLanguageSection,
      audienceExpectationsSection: _wizardEntity.audienceExpectationsSection,
      competitorAnalysisSection: entity,
      brandIdentitySection: _wizardEntity.brandIdentitySection,
      brandPersonalitySection: _wizardEntity.brandPersonalitySection,
      fundamentalValuesSection: _wizardEntity.fundamentalValuesSection,
      brandArchetypesSection: _wizardEntity.brandArchetypesSection,
      brandDimensionsSection: _wizardEntity.brandDimensionsSection,
      desiredUserBehaviorSection: _wizardEntity.desiredUserBehaviorSection,
      toneAndStyleSection: _wizardEntity.toneAndStyleSection,
      brandVoiceGuideSection: _wizardEntity.brandVoiceGuideSection,
      consistencyAndAdaptabilitySection:
          _wizardEntity.consistencyAndAdaptabilitySection,
      brandStorytellingSection: _wizardEntity.brandStorytellingSection,
      voiceEvaluationSection: _wizardEntity.voiceEvaluationSection,
      implementationSection: _wizardEntity.implementationSection,
      brandPerceptionSection: _wizardEntity.brandPerceptionSection,
    );
    notifyListeners();
  }

  void updateBrandIdentitySection(BrandIdentitySectionEntity entity) {
    _wizardEntity = DeepAnalysisWizardEntity(
      generalAudienceDataSection: _wizardEntity.generalAudienceDataSection,
      problemsAndDesiresSection: _wizardEntity.problemsAndDesiresSection,
      motivationsAndValuesSection: _wizardEntity.motivationsAndValuesSection,
      userBehavioralPatternsSection:
          _wizardEntity.userBehavioralPatternsSection,
      fearsFrustrationsObstaclesSection:
          _wizardEntity.fearsFrustrationsObstaclesSection,
      contentConsumptionSection: _wizardEntity.contentConsumptionSection,
      toneAndLanguageSection: _wizardEntity.toneAndLanguageSection,
      audienceExpectationsSection: _wizardEntity.audienceExpectationsSection,
      competitorAnalysisSection: _wizardEntity.competitorAnalysisSection,
      brandIdentitySection: entity,
      brandPersonalitySection: _wizardEntity.brandPersonalitySection,
      fundamentalValuesSection: _wizardEntity.fundamentalValuesSection,
      brandArchetypesSection: _wizardEntity.brandArchetypesSection,
      brandDimensionsSection: _wizardEntity.brandDimensionsSection,
      desiredUserBehaviorSection: _wizardEntity.desiredUserBehaviorSection,
      toneAndStyleSection: _wizardEntity.toneAndStyleSection,
      brandVoiceGuideSection: _wizardEntity.brandVoiceGuideSection,
      consistencyAndAdaptabilitySection:
          _wizardEntity.consistencyAndAdaptabilitySection,
      brandStorytellingSection: _wizardEntity.brandStorytellingSection,
      voiceEvaluationSection: _wizardEntity.voiceEvaluationSection,
      implementationSection: _wizardEntity.implementationSection,
      brandPerceptionSection: _wizardEntity.brandPerceptionSection,
    );
    notifyListeners();
  }

  void updateBrandPersonalitySection(BrandPersonalitySectionEntity entity) {
    _wizardEntity = DeepAnalysisWizardEntity(
      generalAudienceDataSection: _wizardEntity.generalAudienceDataSection,
      problemsAndDesiresSection: _wizardEntity.problemsAndDesiresSection,
      motivationsAndValuesSection: _wizardEntity.motivationsAndValuesSection,
      userBehavioralPatternsSection:
          _wizardEntity.userBehavioralPatternsSection,
      fearsFrustrationsObstaclesSection:
          _wizardEntity.fearsFrustrationsObstaclesSection,
      contentConsumptionSection: _wizardEntity.contentConsumptionSection,
      toneAndLanguageSection: _wizardEntity.toneAndLanguageSection,
      audienceExpectationsSection: _wizardEntity.audienceExpectationsSection,
      competitorAnalysisSection: _wizardEntity.competitorAnalysisSection,
      brandIdentitySection: _wizardEntity.brandIdentitySection,
      brandPersonalitySection: entity,
      fundamentalValuesSection: _wizardEntity.fundamentalValuesSection,
      brandArchetypesSection: _wizardEntity.brandArchetypesSection,
      brandDimensionsSection: _wizardEntity.brandDimensionsSection,
      desiredUserBehaviorSection: _wizardEntity.desiredUserBehaviorSection,
      toneAndStyleSection: _wizardEntity.toneAndStyleSection,
      brandVoiceGuideSection: _wizardEntity.brandVoiceGuideSection,
      consistencyAndAdaptabilitySection:
          _wizardEntity.consistencyAndAdaptabilitySection,
      brandStorytellingSection: _wizardEntity.brandStorytellingSection,
      voiceEvaluationSection: _wizardEntity.voiceEvaluationSection,
      implementationSection: _wizardEntity.implementationSection,
      brandPerceptionSection: _wizardEntity.brandPerceptionSection,
    );
    notifyListeners();
  }

  void updateFundamentalValuesSection(FundamentalValuesSectionEntity entity) {
    _wizardEntity = DeepAnalysisWizardEntity(
      generalAudienceDataSection: _wizardEntity.generalAudienceDataSection,
      problemsAndDesiresSection: _wizardEntity.problemsAndDesiresSection,
      motivationsAndValuesSection: _wizardEntity.motivationsAndValuesSection,
      userBehavioralPatternsSection:
          _wizardEntity.userBehavioralPatternsSection,
      fearsFrustrationsObstaclesSection:
          _wizardEntity.fearsFrustrationsObstaclesSection,
      contentConsumptionSection: _wizardEntity.contentConsumptionSection,
      toneAndLanguageSection: _wizardEntity.toneAndLanguageSection,
      audienceExpectationsSection: _wizardEntity.audienceExpectationsSection,
      competitorAnalysisSection: _wizardEntity.competitorAnalysisSection,
      brandIdentitySection: _wizardEntity.brandIdentitySection,
      brandPersonalitySection: _wizardEntity.brandPersonalitySection,
      fundamentalValuesSection: entity,
      brandArchetypesSection: _wizardEntity.brandArchetypesSection,
      brandDimensionsSection: _wizardEntity.brandDimensionsSection,
      desiredUserBehaviorSection: _wizardEntity.desiredUserBehaviorSection,
      toneAndStyleSection: _wizardEntity.toneAndStyleSection,
      brandVoiceGuideSection: _wizardEntity.brandVoiceGuideSection,
      consistencyAndAdaptabilitySection:
          _wizardEntity.consistencyAndAdaptabilitySection,
      brandStorytellingSection: _wizardEntity.brandStorytellingSection,
      voiceEvaluationSection: _wizardEntity.voiceEvaluationSection,
      implementationSection: _wizardEntity.implementationSection,
      brandPerceptionSection: _wizardEntity.brandPerceptionSection,
    );
    notifyListeners();
  }

  void updateBrandArchetypesSection(BrandArchetypesSectionEntity entity) {
    _wizardEntity = DeepAnalysisWizardEntity(
      generalAudienceDataSection: _wizardEntity.generalAudienceDataSection,
      problemsAndDesiresSection: _wizardEntity.problemsAndDesiresSection,
      motivationsAndValuesSection: _wizardEntity.motivationsAndValuesSection,
      userBehavioralPatternsSection:
          _wizardEntity.userBehavioralPatternsSection,
      fearsFrustrationsObstaclesSection:
          _wizardEntity.fearsFrustrationsObstaclesSection,
      contentConsumptionSection: _wizardEntity.contentConsumptionSection,
      toneAndLanguageSection: _wizardEntity.toneAndLanguageSection,
      audienceExpectationsSection: _wizardEntity.audienceExpectationsSection,
      competitorAnalysisSection: _wizardEntity.competitorAnalysisSection,
      brandIdentitySection: _wizardEntity.brandIdentitySection,
      brandPersonalitySection: _wizardEntity.brandPersonalitySection,
      fundamentalValuesSection: _wizardEntity.fundamentalValuesSection,
      brandArchetypesSection: entity,
      brandDimensionsSection: _wizardEntity.brandDimensionsSection,
      desiredUserBehaviorSection: _wizardEntity.desiredUserBehaviorSection,
      toneAndStyleSection: _wizardEntity.toneAndStyleSection,
      brandVoiceGuideSection: _wizardEntity.brandVoiceGuideSection,
      consistencyAndAdaptabilitySection:
          _wizardEntity.consistencyAndAdaptabilitySection,
      brandStorytellingSection: _wizardEntity.brandStorytellingSection,
      voiceEvaluationSection: _wizardEntity.voiceEvaluationSection,
      implementationSection: _wizardEntity.implementationSection,
      brandPerceptionSection: _wizardEntity.brandPerceptionSection,
    );
    notifyListeners();
  }

  void updateBrandDimensionsSection(BrandDimensionsSectionEntity entity) {
    _wizardEntity = DeepAnalysisWizardEntity(
      generalAudienceDataSection: _wizardEntity.generalAudienceDataSection,
      problemsAndDesiresSection: _wizardEntity.problemsAndDesiresSection,
      motivationsAndValuesSection: _wizardEntity.motivationsAndValuesSection,
      userBehavioralPatternsSection:
          _wizardEntity.userBehavioralPatternsSection,
      fearsFrustrationsObstaclesSection:
          _wizardEntity.fearsFrustrationsObstaclesSection,
      contentConsumptionSection: _wizardEntity.contentConsumptionSection,
      toneAndLanguageSection: _wizardEntity.toneAndLanguageSection,
      audienceExpectationsSection: _wizardEntity.audienceExpectationsSection,
      competitorAnalysisSection: _wizardEntity.competitorAnalysisSection,
      brandIdentitySection: _wizardEntity.brandIdentitySection,
      brandPersonalitySection: _wizardEntity.brandPersonalitySection,
      fundamentalValuesSection: _wizardEntity.fundamentalValuesSection,
      brandArchetypesSection: _wizardEntity.brandArchetypesSection,
      brandDimensionsSection: entity,
      desiredUserBehaviorSection: _wizardEntity.desiredUserBehaviorSection,
      toneAndStyleSection: _wizardEntity.toneAndStyleSection,
      brandVoiceGuideSection: _wizardEntity.brandVoiceGuideSection,
      consistencyAndAdaptabilitySection:
          _wizardEntity.consistencyAndAdaptabilitySection,
      brandStorytellingSection: _wizardEntity.brandStorytellingSection,
      voiceEvaluationSection: _wizardEntity.voiceEvaluationSection,
      implementationSection: _wizardEntity.implementationSection,
      brandPerceptionSection: _wizardEntity.brandPerceptionSection,
    );
    notifyListeners();
  }

  void updateDesiredUserBehaviorSection(
      DesiredUserBehaviorSectionEntity entity) {
    _wizardEntity = DeepAnalysisWizardEntity(
      generalAudienceDataSection: _wizardEntity.generalAudienceDataSection,
      problemsAndDesiresSection: _wizardEntity.problemsAndDesiresSection,
      motivationsAndValuesSection: _wizardEntity.motivationsAndValuesSection,
      userBehavioralPatternsSection:
          _wizardEntity.userBehavioralPatternsSection,
      fearsFrustrationsObstaclesSection:
          _wizardEntity.fearsFrustrationsObstaclesSection,
      contentConsumptionSection: _wizardEntity.contentConsumptionSection,
      toneAndLanguageSection: _wizardEntity.toneAndLanguageSection,
      audienceExpectationsSection: _wizardEntity.audienceExpectationsSection,
      competitorAnalysisSection: _wizardEntity.competitorAnalysisSection,
      brandIdentitySection: _wizardEntity.brandIdentitySection,
      brandPersonalitySection: _wizardEntity.brandPersonalitySection,
      fundamentalValuesSection: _wizardEntity.fundamentalValuesSection,
      brandArchetypesSection: _wizardEntity.brandArchetypesSection,
      brandDimensionsSection: _wizardEntity.brandDimensionsSection,
      desiredUserBehaviorSection: entity,
      toneAndStyleSection: _wizardEntity.toneAndStyleSection,
      brandVoiceGuideSection: _wizardEntity.brandVoiceGuideSection,
      consistencyAndAdaptabilitySection:
          _wizardEntity.consistencyAndAdaptabilitySection,
      brandStorytellingSection: _wizardEntity.brandStorytellingSection,
      voiceEvaluationSection: _wizardEntity.voiceEvaluationSection,
      implementationSection: _wizardEntity.implementationSection,
      brandPerceptionSection: _wizardEntity.brandPerceptionSection,
    );
    notifyListeners();
  }

  void updateToneAndStyleSection(ToneAndStyleSectionEntity entity) {
    _wizardEntity = DeepAnalysisWizardEntity(
      generalAudienceDataSection: _wizardEntity.generalAudienceDataSection,
      problemsAndDesiresSection: _wizardEntity.problemsAndDesiresSection,
      motivationsAndValuesSection: _wizardEntity.motivationsAndValuesSection,
      userBehavioralPatternsSection:
          _wizardEntity.userBehavioralPatternsSection,
      fearsFrustrationsObstaclesSection:
          _wizardEntity.fearsFrustrationsObstaclesSection,
      contentConsumptionSection: _wizardEntity.contentConsumptionSection,
      toneAndLanguageSection: _wizardEntity.toneAndLanguageSection,
      audienceExpectationsSection: _wizardEntity.audienceExpectationsSection,
      competitorAnalysisSection: _wizardEntity.competitorAnalysisSection,
      brandIdentitySection: _wizardEntity.brandIdentitySection,
      brandPersonalitySection: _wizardEntity.brandPersonalitySection,
      fundamentalValuesSection: _wizardEntity.fundamentalValuesSection,
      brandArchetypesSection: _wizardEntity.brandArchetypesSection,
      brandDimensionsSection: _wizardEntity.brandDimensionsSection,
      desiredUserBehaviorSection: _wizardEntity.desiredUserBehaviorSection,
      toneAndStyleSection: entity,
      brandVoiceGuideSection: _wizardEntity.brandVoiceGuideSection,
      consistencyAndAdaptabilitySection:
          _wizardEntity.consistencyAndAdaptabilitySection,
      brandStorytellingSection: _wizardEntity.brandStorytellingSection,
      voiceEvaluationSection: _wizardEntity.voiceEvaluationSection,
      implementationSection: _wizardEntity.implementationSection,
      brandPerceptionSection: _wizardEntity.brandPerceptionSection,
    );
    notifyListeners();
  }

  void updateBrandVoiceGuideSection(BrandVoiceGuideSectionEntity entity) {
    _wizardEntity = DeepAnalysisWizardEntity(
      generalAudienceDataSection: _wizardEntity.generalAudienceDataSection,
      problemsAndDesiresSection: _wizardEntity.problemsAndDesiresSection,
      motivationsAndValuesSection: _wizardEntity.motivationsAndValuesSection,
      userBehavioralPatternsSection:
          _wizardEntity.userBehavioralPatternsSection,
      fearsFrustrationsObstaclesSection:
          _wizardEntity.fearsFrustrationsObstaclesSection,
      contentConsumptionSection: _wizardEntity.contentConsumptionSection,
      toneAndLanguageSection: _wizardEntity.toneAndLanguageSection,
      audienceExpectationsSection: _wizardEntity.audienceExpectationsSection,
      competitorAnalysisSection: _wizardEntity.competitorAnalysisSection,
      brandIdentitySection: _wizardEntity.brandIdentitySection,
      brandPersonalitySection: _wizardEntity.brandPersonalitySection,
      fundamentalValuesSection: _wizardEntity.fundamentalValuesSection,
      brandArchetypesSection: _wizardEntity.brandArchetypesSection,
      brandDimensionsSection: _wizardEntity.brandDimensionsSection,
      desiredUserBehaviorSection: _wizardEntity.desiredUserBehaviorSection,
      toneAndStyleSection: _wizardEntity.toneAndStyleSection,
      brandVoiceGuideSection: entity,
      consistencyAndAdaptabilitySection:
          _wizardEntity.consistencyAndAdaptabilitySection,
      brandStorytellingSection: _wizardEntity.brandStorytellingSection,
      voiceEvaluationSection: _wizardEntity.voiceEvaluationSection,
      implementationSection: _wizardEntity.implementationSection,
      brandPerceptionSection: _wizardEntity.brandPerceptionSection,
    );
    notifyListeners();
  }

  void updateConsistencyAndAdaptabilitySection(
      ConsistencyAndAdaptabilitySectionEntity entity) {
    _wizardEntity = DeepAnalysisWizardEntity(
      generalAudienceDataSection: _wizardEntity.generalAudienceDataSection,
      problemsAndDesiresSection: _wizardEntity.problemsAndDesiresSection,
      motivationsAndValuesSection: _wizardEntity.motivationsAndValuesSection,
      userBehavioralPatternsSection:
          _wizardEntity.userBehavioralPatternsSection,
      fearsFrustrationsObstaclesSection:
          _wizardEntity.fearsFrustrationsObstaclesSection,
      contentConsumptionSection: _wizardEntity.contentConsumptionSection,
      toneAndLanguageSection: _wizardEntity.toneAndLanguageSection,
      audienceExpectationsSection: _wizardEntity.audienceExpectationsSection,
      competitorAnalysisSection: _wizardEntity.competitorAnalysisSection,
      brandIdentitySection: _wizardEntity.brandIdentitySection,
      brandPersonalitySection: _wizardEntity.brandPersonalitySection,
      fundamentalValuesSection: _wizardEntity.fundamentalValuesSection,
      brandArchetypesSection: _wizardEntity.brandArchetypesSection,
      brandDimensionsSection: _wizardEntity.brandDimensionsSection,
      desiredUserBehaviorSection: _wizardEntity.desiredUserBehaviorSection,
      toneAndStyleSection: _wizardEntity.toneAndStyleSection,
      brandVoiceGuideSection: _wizardEntity.brandVoiceGuideSection,
      consistencyAndAdaptabilitySection: entity,
      brandStorytellingSection: _wizardEntity.brandStorytellingSection,
      voiceEvaluationSection: _wizardEntity.voiceEvaluationSection,
      implementationSection: _wizardEntity.implementationSection,
      brandPerceptionSection: _wizardEntity.brandPerceptionSection,
    );
    notifyListeners();
  }

  void updateBrandStorytellingSection(BrandStorytellingSectionEntity entity) {
    _wizardEntity = DeepAnalysisWizardEntity(
      generalAudienceDataSection: _wizardEntity.generalAudienceDataSection,
      problemsAndDesiresSection: _wizardEntity.problemsAndDesiresSection,
      motivationsAndValuesSection: _wizardEntity.motivationsAndValuesSection,
      userBehavioralPatternsSection:
          _wizardEntity.userBehavioralPatternsSection,
      fearsFrustrationsObstaclesSection:
          _wizardEntity.fearsFrustrationsObstaclesSection,
      contentConsumptionSection: _wizardEntity.contentConsumptionSection,
      toneAndLanguageSection: _wizardEntity.toneAndLanguageSection,
      audienceExpectationsSection: _wizardEntity.audienceExpectationsSection,
      competitorAnalysisSection: _wizardEntity.competitorAnalysisSection,
      brandIdentitySection: _wizardEntity.brandIdentitySection,
      brandPersonalitySection: _wizardEntity.brandPersonalitySection,
      fundamentalValuesSection: _wizardEntity.fundamentalValuesSection,
      brandArchetypesSection: _wizardEntity.brandArchetypesSection,
      brandDimensionsSection: _wizardEntity.brandDimensionsSection,
      desiredUserBehaviorSection: _wizardEntity.desiredUserBehaviorSection,
      toneAndStyleSection: _wizardEntity.toneAndStyleSection,
      brandVoiceGuideSection: _wizardEntity.brandVoiceGuideSection,
      consistencyAndAdaptabilitySection:
          _wizardEntity.consistencyAndAdaptabilitySection,
      brandStorytellingSection: entity,
      voiceEvaluationSection: _wizardEntity.voiceEvaluationSection,
      implementationSection: _wizardEntity.implementationSection,
      brandPerceptionSection: _wizardEntity.brandPerceptionSection,
    );
    notifyListeners();
  }

  void updateVoiceEvaluationSection(VoiceEvaluationSectionEntity entity) {
    _wizardEntity = DeepAnalysisWizardEntity(
      generalAudienceDataSection: _wizardEntity.generalAudienceDataSection,
      problemsAndDesiresSection: _wizardEntity.problemsAndDesiresSection,
      motivationsAndValuesSection: _wizardEntity.motivationsAndValuesSection,
      userBehavioralPatternsSection:
          _wizardEntity.userBehavioralPatternsSection,
      fearsFrustrationsObstaclesSection:
          _wizardEntity.fearsFrustrationsObstaclesSection,
      contentConsumptionSection: _wizardEntity.contentConsumptionSection,
      toneAndLanguageSection: _wizardEntity.toneAndLanguageSection,
      audienceExpectationsSection: _wizardEntity.audienceExpectationsSection,
      competitorAnalysisSection: _wizardEntity.competitorAnalysisSection,
      brandIdentitySection: _wizardEntity.brandIdentitySection,
      brandPersonalitySection: _wizardEntity.brandPersonalitySection,
      fundamentalValuesSection: _wizardEntity.fundamentalValuesSection,
      brandArchetypesSection: _wizardEntity.brandArchetypesSection,
      brandDimensionsSection: _wizardEntity.brandDimensionsSection,
      desiredUserBehaviorSection: _wizardEntity.desiredUserBehaviorSection,
      toneAndStyleSection: _wizardEntity.toneAndStyleSection,
      brandVoiceGuideSection: _wizardEntity.brandVoiceGuideSection,
      consistencyAndAdaptabilitySection:
          _wizardEntity.consistencyAndAdaptabilitySection,
      brandStorytellingSection: _wizardEntity.brandStorytellingSection,
      voiceEvaluationSection: entity,
      implementationSection: _wizardEntity.implementationSection,
      brandPerceptionSection: _wizardEntity.brandPerceptionSection,
    );
    notifyListeners();
  }

  void updateImplementationSection(ImplementationSectionEntity entity) {
    _wizardEntity = DeepAnalysisWizardEntity(
      generalAudienceDataSection: _wizardEntity.generalAudienceDataSection,
      problemsAndDesiresSection: _wizardEntity.problemsAndDesiresSection,
      motivationsAndValuesSection: _wizardEntity.motivationsAndValuesSection,
      userBehavioralPatternsSection:
          _wizardEntity.userBehavioralPatternsSection,
      fearsFrustrationsObstaclesSection:
          _wizardEntity.fearsFrustrationsObstaclesSection,
      contentConsumptionSection: _wizardEntity.contentConsumptionSection,
      toneAndLanguageSection: _wizardEntity.toneAndLanguageSection,
      audienceExpectationsSection: _wizardEntity.audienceExpectationsSection,
      competitorAnalysisSection: _wizardEntity.competitorAnalysisSection,
      brandIdentitySection: _wizardEntity.brandIdentitySection,
      brandPersonalitySection: _wizardEntity.brandPersonalitySection,
      fundamentalValuesSection: _wizardEntity.fundamentalValuesSection,
      brandArchetypesSection: _wizardEntity.brandArchetypesSection,
      brandDimensionsSection: _wizardEntity.brandDimensionsSection,
      desiredUserBehaviorSection: _wizardEntity.desiredUserBehaviorSection,
      toneAndStyleSection: _wizardEntity.toneAndStyleSection,
      brandVoiceGuideSection: _wizardEntity.brandVoiceGuideSection,
      consistencyAndAdaptabilitySection:
          _wizardEntity.consistencyAndAdaptabilitySection,
      brandStorytellingSection: _wizardEntity.brandStorytellingSection,
      voiceEvaluationSection: _wizardEntity.voiceEvaluationSection,
      implementationSection: entity,
      brandPerceptionSection: _wizardEntity.brandPerceptionSection,
    );
    notifyListeners();
  }

  void updateBrandPerceptionSection(BrandPerceptionSectionEntity entity) {
    _wizardEntity = DeepAnalysisWizardEntity(
      generalAudienceDataSection: _wizardEntity.generalAudienceDataSection,
      problemsAndDesiresSection: _wizardEntity.problemsAndDesiresSection,
      motivationsAndValuesSection: _wizardEntity.motivationsAndValuesSection,
      userBehavioralPatternsSection:
          _wizardEntity.userBehavioralPatternsSection,
      fearsFrustrationsObstaclesSection:
          _wizardEntity.fearsFrustrationsObstaclesSection,
      contentConsumptionSection: _wizardEntity.contentConsumptionSection,
      toneAndLanguageSection: _wizardEntity.toneAndLanguageSection,
      audienceExpectationsSection: _wizardEntity.audienceExpectationsSection,
      competitorAnalysisSection: _wizardEntity.competitorAnalysisSection,
      brandIdentitySection: _wizardEntity.brandIdentitySection,
      brandPersonalitySection: _wizardEntity.brandPersonalitySection,
      fundamentalValuesSection: _wizardEntity.fundamentalValuesSection,
      brandArchetypesSection: _wizardEntity.brandArchetypesSection,
      brandDimensionsSection: _wizardEntity.brandDimensionsSection,
      desiredUserBehaviorSection: _wizardEntity.desiredUserBehaviorSection,
      toneAndStyleSection: _wizardEntity.toneAndStyleSection,
      brandVoiceGuideSection: _wizardEntity.brandVoiceGuideSection,
      consistencyAndAdaptabilitySection:
          _wizardEntity.consistencyAndAdaptabilitySection,
      brandStorytellingSection: _wizardEntity.brandStorytellingSection,
      voiceEvaluationSection: _wizardEntity.voiceEvaluationSection,
      implementationSection: _wizardEntity.implementationSection,
      brandPerceptionSection: entity,
    );
    notifyListeners();
  }

  Future<BrandVoice?> generateBrandVoice(
      String sessionId, String userId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      final brand = await brandVoiceUseCases.generateBrandVoice(
        sessionId,
        userId,
        _wizardEntity,
      );
      // Cargar en BrandVoiceProvider para edición
      await brandVoiceProvider.addBrand(sessionId, userId, brand);
      _isLoading = false;
      notifyListeners();
      return brand;
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
      return null;
    }
  }

  // ... otros métodos para otras secciones ...
}
