import 'package:ia_web_front/domain/entities/article_builder_entities.dart';
import 'package:ia_web_front/domain/entities/article_editor_entity.dart';

abstract class ArticleFunc {
  Future<List<ArticleEditorEntity>> getGeneratedArticle(
      String sessionID, String userID);
  Future<void> postArticleBuilderJson(ArticleBuilderEntity model);
}
