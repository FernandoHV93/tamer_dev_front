import 'package:flutter/material.dart';
import 'package:ia_web_front/core/desing/app_constant.dart';
import 'package:ia_web_front/core/providers/session_provider.dart';
import 'package:ia_web_front/data/repository_impl/article_impl.dart';
import 'package:ia_web_front/domain/entities/article_builder_entities.dart';
import 'package:ia_web_front/domain/entities/article_entity_dto.dart';
import 'package:ia_web_front/domain/use_cases/save_form.dart';
import 'package:ia_web_front/domain/use_cases/send_default_data.dart';
import 'package:ia_web_front/views/article_builder/components/article_distribution.dart';
import 'package:ia_web_front/views/article_builder/components/article_form.dart';
import 'package:ia_web_front/views/article_builder/components/article_settings.dart';
import 'package:ia_web_front/views/article_builder/components/top_title_card.dart';
import 'package:ia_web_front/views/article_builder/components/media_hub_card.dart';
import 'package:ia_web_front/views/article_builder/components/seo_structure.dart';
import 'package:ia_web_front/views/article_editor_finish/article_editor_screen.dart';

class ArticleBuilderScreen extends StatefulWidget {
  const ArticleBuilderScreen({super.key});

  @override
  State<ArticleBuilderScreen> createState() => _ArticleBuilderScreenState();
}

class _ArticleBuilderScreenState extends State<ArticleBuilderScreen> {
  final SaveForm _saveFormUseCase = SaveForm(ArticleFuncImpl());
  final SendDefaultData _defaultData = SendDefaultData(ArticleFuncImpl());

  late final ArticleBuilderEntity _articleBuilderEntity;

  @override
  void initState() {
    super.initState();
    final sessionProvider = SessionProvider.of(context);
    _articleBuilderEntity = ArticleBuilderEntity(
      sessionId: sessionProvider.sessionID,
      userId: sessionProvider.userID,
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
        imageSize: {
          "width": 0,
          "height": 0,
        },
        layoutOption: AppConstants.layoutOptions.first,
        includeKeywords: false,
        placeUnderHeadings: false,
      ),
      articleSEO: ArticleSEO(
        keywords: [],
      ),
      articleStructure: ArticleStructure(
        typeOfHook: AppConstants.hookOptions.first,
        introductoryHookBrief: AppConstants.hookPrompts.values.first,
        contentOptions: {
          'Conclusion': false,
          'Tables': false,
          'Heading3': false,
          'Lists': false,
          'Italics': false,
          'Quotes': false,
          'KeyTakeaways': false,
          'FAQS': false,
          'Bold': false,
          'Stats': false,
          'RealPeopleOpinion': false,
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
  }

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

  void _handleGenerateArticle() async {
    debugPrint("Enviando ArticleDto por defecto al backend...");

    // Crear un ArticleDto vacío o por defecto
    final defaultArticleDto = ArticleDto(
      userID: _articleBuilderEntity.userId,
      sessionID: _articleBuilderEntity.sessionId,
      h1: TextFormatDto(
        N: true,
        I: false,
        U: false,
        text: '',
        aligment: 'center',
        size: 'H1',
      ),
      body: [],
    );

    try {
      // Enviar el ArticleDto por defecto al backend
      await _defaultData.execute(defaultArticleDto);

      // Navegar a la vista ArticleEditorScreen
      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticleEditorScreen(),
          ),
        );
      }
    } catch (e) {
      // Manejar errores
      debugPrint("Error al enviar el ArticleDto: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error al generar el artículo: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 30, 30, 30),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(200, 10, 200, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TopTitleCard(
                articleBuilderEntity: _articleBuilderEntity,
                onSave: _handleSave,
                onGenerate: _handleGenerateArticle,
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
