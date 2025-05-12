import 'package:ia_web_front/domain/entities/article_builder_entities.dart';
import 'package:ia_web_front/domain/entities/article_entity_dto.dart';

abstract class ArticleFunc {
  Future<void> postArticleBuilderJson(ArticleBuilderEntity model);
  Future<ArticleDto> fetchArticleBuilderJson(
      {required String userID, required String sessionID});

  Future<void> postDefaultData(ArticleDto defaultDto);
}
