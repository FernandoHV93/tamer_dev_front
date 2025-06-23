import '../entities/preview_article_entity.dart';

abstract class RecentArticlesRepo {
  Future<List<PreviewArticleEntity>> getRecentArticles();
}
