import '../entities/preview_article_entity.dart';
import '../repository/recent_articles_repo.dart';
import 'package:ia_web_front/features/article_editor/domain/entities/article_entity_dto.dart';

class RecentArticlesRepoImpl implements RecentArticlesRepo {
  @override
  Future<List<PreviewArticleEntity>> getRecentArticles() async {
    return [
      PreviewArticleEntity(
        id: '1',
        article: ArticleDto(
          h1: TextFormatDto(
              N: false,
              I: false,
              U: false,
              text: 'Brickell Location Guide: Digital Marketing & SEO Services',
              aligment: '',
              size: ''),
          body: [],
          score: 69,
          date: DateTime(2024, 5, 6, 14, 47),
        ),
      ),
      PreviewArticleEntity(
        id: '2',
        article: ArticleDto(
          h1: TextFormatDto(
              N: false,
              I: false,
              U: false,
              text: 'SEO vs Social Media: Which one is better for my business?',
              aligment: '',
              size: ''),
          body: [],
          score: 81,
          date: DateTime(2024, 4, 9, 23, 48),
        ),
      ),
    ];
  }
}
