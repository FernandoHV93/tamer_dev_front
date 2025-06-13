import 'package:ia_web_front/features/article_builder/domain/repository/article_repo.dart';
import 'package:ia_web_front/features/article_editor/domain/entities/article_entity_dto.dart';

class SendDefaultData {
  final ArticleFunc repository;

  SendDefaultData(this.repository);

  Future<void> execute(ArticleDto defaultDto) async {
    await repository.postDefaultData(defaultDto);
  }
}
