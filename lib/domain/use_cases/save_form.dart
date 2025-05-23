import 'package:ia_web_front/domain/entities/article_builder_entities.dart';
import 'package:ia_web_front/domain/repository/article_repo.dart';

class SaveForm {
  final ArticleFunc repository;

  SaveForm(this.repository);

  Future<void> execute(ArticleBuilderEntity model) async {
    await repository.postArticleBuilderJson(model);
  }
}
