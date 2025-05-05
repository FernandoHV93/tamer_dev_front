import 'package:ia_web_front/domain/entities/article_editor_entity.dart';
import 'package:ia_web_front/domain/repository/article_repo.dart';

class GetGeneratedArticle {
  final ArticleFunc repository;

  GetGeneratedArticle(this.repository);

  Future<List<ArticleEditorEntity>> execute(
      String sessionID, String userID) async {
    return await repository.getGeneratedArticle(sessionID, userID);
  }
}
