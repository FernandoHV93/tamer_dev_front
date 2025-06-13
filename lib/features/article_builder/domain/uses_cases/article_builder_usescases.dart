import 'package:ia_web_front/features/article_builder/domain/entities/article_builder_entities.dart';
import 'package:ia_web_front/features/article_builder/domain/repository/article_repo.dart';
import 'package:ia_web_front/features/article_editor/domain/entities/article_entity_dto.dart';

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
    return await repository.postDefaultData(defaultDto);
  }

  Future<void> saveForm(
      String sessionId, String userId, ArticleBuilderEntity model) async {
    return await repository.postArticleBuilderJson(model);
  }
}
