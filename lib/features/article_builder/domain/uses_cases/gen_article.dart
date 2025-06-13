import 'package:ia_web_front/features/article_builder/domain/repository/article_repo.dart';
import 'package:ia_web_front/features/article_editor/domain/entities/article_entity_dto.dart';

class FetchGeneratedArticle {
  final ArticleFunc repository;

  FetchGeneratedArticle(this.repository);

  Future<ArticleDto> execute(String sessionID, String userID) async {
    return await repository.fetchArticleBuilderJson(
        sessionID: sessionID, userID: userID);
  }
}
