import 'package:ia_web_front/domain/entities/article_entity_dto.dart';
import 'package:ia_web_front/domain/repository/article_repo.dart';

class SendDefaultData {
  final ArticleFunc repository;

  SendDefaultData(this.repository);

  Future<void> execute(ArticleDto defaultDto) async {
    await repository.postDefaultData(defaultDto);
  }
}
