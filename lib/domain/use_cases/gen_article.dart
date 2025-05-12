import 'package:ia_web_front/domain/entities/article_entity_dto.dart';
import 'package:ia_web_front/domain/repository/article_repo.dart';

class FetchGeneratedArticle {
  final ArticleFunc repository;

  FetchGeneratedArticle(this.repository);

  Future<ArticleDto> execute(String sessionID, String userID) async {
    return await repository.fetchArticleBuilderJson(
        sessionID: sessionID, userID: userID);
  }
}
