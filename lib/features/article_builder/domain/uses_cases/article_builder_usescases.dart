import 'package:ia_web_front/features/article_builder/domain/entities/article_builder_entities.dart';
import 'package:ia_web_front/features/article_builder/domain/repository/article_repo.dart';
import 'package:ia_web_front/features/article_editor/domain/entities/article_entity_dto.dart';
import 'package:ia_web_front/features/article_builder/domain/entities/keyword_analysis_result.dart';

class ArticleBuilderUsescases {
  final ArticleFunc repository;

  ArticleBuilderUsescases(this.repository);

  Future<ArticleDto> fetchGeneratedArticle(
      String sessionId, String userId) async {
    return await repository.fetchArticleBuilderJson(
        sessionID: sessionId, userID: userId);
  }

  Future<void> sendDefaultData(
      String sessionId, String userId, ArticleDto defaultDto) async {
    return await repository.postDefaultData(sessionId, userId, defaultDto);
  }

  Future<void> saveForm(
      String sessionId, String userId, ArticleBuilderEntity model) async {
    return await repository.postArticleBuilderJson(sessionId, userId, model);
  }

  Future<KeywordAnalysisResult> runAnalysis({
    required String mainKeyword,
    required bool isAutoMode,
  }) {
    return repository.runAnalysis(
        mainKeyword: mainKeyword, isAutoMode: isAutoMode);
  }
}
