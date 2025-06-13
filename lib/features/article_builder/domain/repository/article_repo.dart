import 'package:ia_web_front/features/article_builder/domain/entities/article_builder_entities.dart';
import 'package:ia_web_front/features/article_editor/domain/entities/article_entity_dto.dart';

abstract class ArticleFunc {
  Future<void> postArticleBuilderJson(
      String sessionId, String userId, ArticleBuilderEntity model);

  Future<ArticleDto> fetchArticleBuilderJson(
      {required String userID, required String sessionID});

  Future<void> postDefaultData(
      String sessionId, String userId, ArticleDto defaultDto);
}
