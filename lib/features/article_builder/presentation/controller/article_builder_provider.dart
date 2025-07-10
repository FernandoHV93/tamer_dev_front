import 'package:flutter/material.dart';
import 'package:ia_web_front/core/desing/app_constant.dart';
import 'package:ia_web_front/features/article_builder/data/repository/article_impl.dart';
import 'package:ia_web_front/features/article_builder/domain/entities/article_builder_entities.dart';
import 'package:ia_web_front/features/article_builder/domain/uses_cases/article_builder_usescases.dart';
import 'package:ia_web_front/features/article_editor/domain/entities/article_entity_dto.dart';
import 'package:ia_web_front/features/article_builder/domain/entities/keyword_analysis_result.dart';

class ArticleBuilderProvider with ChangeNotifier {
  final ArticleBuilderUsescases _useCases;
  ArticleBuilderEntity _articleBuilderEntity;

  bool _isLoading = false;
  String? _errorMessage;
  KeywordAnalysisResult? _analysisResult;

  ArticleBuilderProvider({
    ArticleBuilderUsescases? useCases,
  })  : _useCases = useCases ?? ArticleBuilderUsescases(ArticleFuncImpl()),
        _articleBuilderEntity = _createDefaultEntity();

  ArticleBuilderEntity get articleBuilderEntity => _articleBuilderEntity;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  KeywordAnalysisResult? get analysisResult => _analysisResult;
  Map<String, dynamic> get selectedBrandVoice =>
      _articleBuilderEntity.articleSettings.brandVoice;

  static ArticleBuilderEntity _createDefaultEntity() {
    return ArticleBuilderEntity(
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

  void updateLanguage(String language) {
    _articleBuilderEntity.articleGeneratorGeneral.language = language;
    notifyListeners();
  }

  void updateArticleTitle(String title) {
    _articleBuilderEntity.articleGeneratorGeneral.articleTitle = title;
    notifyListeners();
  }

  void updateArticleMainKeyword(String keyword) {
    _articleBuilderEntity.articleGeneratorGeneral.articleMainKeyword = keyword;
    notifyListeners();
  }

  void updateArticleType(String type) {
    _articleBuilderEntity.articleGeneratorGeneral.articleType = type;
    notifyListeners();
  }

  void updateArticleMetaTitle(String metaTitle) {
    _articleBuilderEntity.articleGeneratorGeneral.articleMetaTitle = metaTitle;
    notifyListeners();
  }

  void updateArticleSize(String size) {
    _articleBuilderEntity.articleSettings.articleSize = size;
    notifyListeners();
  }

  void updateTargetCountry(String country) {
    _articleBuilderEntity.articleSettings.targetCountry = country;
    notifyListeners();
  }

  void updateAiModel(String model) {
    _articleBuilderEntity.articleSettings.aiModel = model;
    notifyListeners();
  }

  void updateHumanizeText(String level) {
    _articleBuilderEntity.articleSettings.humanizeText = level;
    notifyListeners();
  }

  void updateAiWordsRemoval(String value) {
    _articleBuilderEntity.articleSettings.aiWordsRemoval = value;
    notifyListeners();
  }

  void updatePointOfView(String pov) {
    _articleBuilderEntity.articleSettings.pointOfView = pov;
    notifyListeners();
  }

  void updateToneOfVoice(String tone) {
    _articleBuilderEntity.articleSettings.toneOfVoice = tone;
    notifyListeners();
  }

  void updateDetailsToInclude(String details) {
    _articleBuilderEntity.articleSettings.detailsToInclude = details;
    notifyListeners();
  }

  void updateBrandVoice(Map<String, String> brandVoice) {
    _articleBuilderEntity.articleSettings.brandVoice = brandVoice;
    notifyListeners();
  }

  void updateAiImages(bool aiImages) {
    _articleBuilderEntity.articleMediaHub.aiImages = aiImages;
    notifyListeners();
  }

  void updateNumberOfImages(int count) {
    _articleBuilderEntity.articleMediaHub.numberOfImages = count;
    notifyListeners();
  }

  void updateImageStyle(String style) {
    _articleBuilderEntity.articleMediaHub.imageStyle = style;
    notifyListeners();
  }

  void updateImageSize(Map<String, int> size) {
    _articleBuilderEntity.articleMediaHub.imageSize = size;
    notifyListeners();
  }

  void updateYoutubeVideos(bool videos) {
    _articleBuilderEntity.articleMediaHub.youtubeVideos = videos;
    notifyListeners();
  }

  void updateNumberOfVideos(int count) {
    _articleBuilderEntity.articleMediaHub.numberOfVideos = count;
    notifyListeners();
  }

  void updateLayoutOption(String layout) {
    _articleBuilderEntity.articleMediaHub.layoutOption = layout;
    notifyListeners();
  }

  void updateIncludeKeywords(bool include) {
    _articleBuilderEntity.articleMediaHub.includeKeywords = include;
    notifyListeners();
  }

  void updatePlaceUnderHeadings(bool place) {
    _articleBuilderEntity.articleMediaHub.placeUnderHeadings = place;
    notifyListeners();
  }

  void updateAdditionalInstructions(String instructions) {
    _articleBuilderEntity.articleMediaHub.additionalInstructions = instructions;
    notifyListeners();
  }

  void updateBrandName(String name) {
    _articleBuilderEntity.articleMediaHub.brandName = name;
    notifyListeners();
  }

  void updateKeywords(List<String> keywords) {
    _articleBuilderEntity.articleSEO.keywords = keywords;
    notifyListeners();
  }

  void addKeyword(String keyword) {
    if (!_articleBuilderEntity.articleSEO.keywords.contains(keyword)) {
      _articleBuilderEntity.articleSEO.keywords.add(keyword);
      notifyListeners();
    }
  }

  void removeKeyword(String keyword) {
    _articleBuilderEntity.articleSEO.keywords.remove(keyword);
    notifyListeners();
  }

  void updateTypeOfHook(String hook) {
    _articleBuilderEntity.articleStructure.typeOfHook = hook;
    notifyListeners();
  }

  void updateIntroductoryHookBrief(String brief) {
    _articleBuilderEntity.articleStructure.introductoryHookBrief = brief;
    notifyListeners();
  }

  void updateContentOption(String option, bool value) {
    _articleBuilderEntity.articleStructure.contentOptions[option] = value;
    notifyListeners();
  }

  void updateSourceLinks(bool sourceLinks) {
    _articleBuilderEntity.articleDistribution.sourceLinks = sourceLinks;
    notifyListeners();
  }

  void updateCitations(bool citations) {
    _articleBuilderEntity.articleDistribution.citations = citations;
    notifyListeners();
  }

  void updateInternalLinking(List<String> links) {
    _articleBuilderEntity.articleDistribution.internalLinking = links;
    notifyListeners();
  }

  void updateExternalLinking(List<String> links) {
    _articleBuilderEntity.articleDistribution.externalLinking = links;
    notifyListeners();
  }

  void updateSyndicationOption(String option, bool value) {
    _articleBuilderEntity.articleDistribution.articleSydication[option] = value;
    notifyListeners();
  }

  Future<void> saveForm({
    required String sessionId,
    required String userId,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      final entityToSend = ArticleBuilderEntity(
        articleGeneratorGeneral: _articleBuilderEntity.articleGeneratorGeneral,
        articleSettings: _articleBuilderEntity.articleSettings,
        articleMediaHub: _articleBuilderEntity.articleMediaHub,
        articleSEO: _articleBuilderEntity.articleSEO,
        articleStructure: _articleBuilderEntity.articleStructure,
        articleDistribution: _articleBuilderEntity.articleDistribution,
      );

      await _useCases.saveForm(sessionId, userId, entityToSend);
    } catch (e) {
      _setError("Error al guardar el formulario: $e");
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> sendDefaultData({
    required String sessionId,
    required String userId,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      final defaultArticleDto = ArticleDto(
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

      await _useCases.sendDefaultData(sessionId, userId, defaultArticleDto);
    } catch (e) {
      _setError("Error al enviar datos por defecto: $e");
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  Future<ArticleDto> fetchGeneratedArticle({
    required String sessionId,
    required String userId,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      final article = await _useCases.fetchGeneratedArticle(sessionId, userId);

      return article;
    } catch (e) {
      _setError("Error al obtener el artículo generado: $e");
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> runAnalysis(String sessionId, String userId, String mainKeyword,
      bool isAutoMode) async {
    _setLoading(true);
    _clearError();
    try {
      _analysisResult = await _useCases.runAnalysis(
        sessionId: sessionId,
        userId: userId,
        mainKeyword: mainKeyword,
        isAutoMode: isAutoMode,
      );
    } catch (e) {
      _setError("Error al analizar: $e");
    } finally {
      _setLoading(false);
      notifyListeners();
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void resetForm() {
    _articleBuilderEntity = _createDefaultEntity();
    _clearError();
    notifyListeners();
  }

  void setSelectedBrandVoice(Map<String, dynamic> brandVoice) {
    _articleBuilderEntity.articleSettings.brandVoice = brandVoice;
    notifyListeners();
  }
}
