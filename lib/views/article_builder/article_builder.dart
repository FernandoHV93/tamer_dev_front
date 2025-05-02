import 'package:flutter/material.dart';
import 'package:ia_web_front/core/desing/app_constant.dart';
import 'package:ia_web_front/data/repository_impl/article_impl.dart';
import 'package:ia_web_front/domain/entities/article_builder_entities.dart';
import 'package:ia_web_front/domain/use_cases/save_form.dart';
import 'package:ia_web_front/views/article_builder/components/article_distribution.dart';
import 'package:ia_web_front/views/article_builder/components/article_form.dart';
import 'package:ia_web_front/views/article_builder/components/article_settings.dart';
import 'package:ia_web_front/views/article_builder/components/top_title_card.dart';
import 'package:ia_web_front/views/article_builder/components/media_hub_card.dart';
import 'package:ia_web_front/views/article_builder/components/seo_structure.dart';

class ArticleBuilderScreen extends StatefulWidget {
  const ArticleBuilderScreen({super.key});

  @override
  State<ArticleBuilderScreen> createState() => _ArticleBuilderScreenState();
}

class _ArticleBuilderScreenState extends State<ArticleBuilderScreen> {
  final SaveForm _saveFormUseCase = SaveForm(ArticleFuncImpl());

  final ArticleBuilderEntity _articleBuilderEntity = ArticleBuilderEntity(
    sessionId: 'session123',
    userId: 'user456',
    articleGeneratorGeneral: ArticleGeneratorGeneral(
      language: AppConstants.languages.keys.first,
      articleTitle: '',
      articleMainKeyword: '',
      articleType: AppConstants.articleTypes.keys.first,
    ),
    articleSettings: ArticleGeneratorSettings(
      articleSize: AppConstants.sizeDetails.keys.first,
      aiModel: AppConstants.aiModels.first,
      humanizeText: AppConstants.humanLevels.first,
      pointOfView: AppConstants.povOptions.first.values.first,
      toneOfVoice: AppConstants.tones.first.values.first,
      targetCountry: AppConstants.languages.keys.first,
    ),
    articleMediaHub: ArticleMediaHub(
      aiImages: false,
      numberOfImages: 0,
      additionalInstructions: '',
      brandName: '',
      numberOfVideos: 0,
      youtubeVideos: false,
      imageStyle: AppConstants.imageStyles.first,
      imageSize: AppConstants.imageSizes.first,
      layoutOption: AppConstants.layoutOptions.first,
      includeKeywords: false,
      placeUnderHeadings: false,
    ),
    articleSEO: ArticleSEO(
      keywords: [""],
    ),
    articleStructure: ArticleStructure(
      typeOfHook: AppConstants.hookOptions.first,
      introductoryHookBrief: AppConstants.hookPrompts.values.first,
      contentOptions: {
        'conclusion': false,
        'tables': false,
        'heading3': false,
        'lists': false,
        'italics': false,
        'quotes': false,
        'keyTakeaways': false,
        'faqs': false,
        'bold': false,
        'stats': false,
        'realPeopleOpinion': false,
      },
    ),
    articleDistribution: ArticleDistributionsEntity(
      sourceLinks: false,
      citations: false,
      internalLinking: [],
      externalLinking: [],
      articleSydication:
          Map<String, bool>.from(AppConstants.selectedSyndication),
    ),
  );

  void _handleSave() async {
    debugPrint("Guardando datos...");
    debugPrint("Datos a enviar: ${_articleBuilderEntity.toJson()}");
    try {
      await _saveFormUseCase.execute(_articleBuilderEntity);
      debugPrint("Datos enviados exitosamente al servidor.");
    } catch (e) {
      debugPrint("Error al enviar los datos: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(200, 10, 200, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TopTitleCard(
                articleBuilderEntity: _articleBuilderEntity,
                onSave: _handleSave,
              ),
              const SizedBox(height: 20),
              ArticleForm(
                articleBuilderEntity: _articleBuilderEntity,
              ),
              const SizedBox(height: 25),
              ArticleSettingsCard(
                articleBuilderEntity: _articleBuilderEntity,
              ),
              const SizedBox(height: 25),
              MediaHubCard(
                articleBuilderEntity: _articleBuilderEntity,
              ),
              const SizedBox(height: 25),
              SeoStructure(
                articleBuilderEntity: _articleBuilderEntity,
              ),
              const SizedBox(height: 25),
              ArticleDistributionSection(
                articleBuilderEntity: _articleBuilderEntity,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
