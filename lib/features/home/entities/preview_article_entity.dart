import 'package:ia_web_front/features/article_editor/domain/entities/article_entity_dto.dart';

class PreviewArticleEntity {
  final String id;
  final ArticleDto article;

  PreviewArticleEntity({
    required this.id,
    required this.article,
  });

  String get title => article.h1.text;
  int get score => article.score ?? 0;
  int get wordCount => article.wordCount;
  DateTime get date => article.date ?? DateTime.now();
}
