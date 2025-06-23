import '../entities/preview_article_entity.dart';
import '../repository/recent_articles_repo.dart';

class LoadRecentArticles {
  final RecentArticlesRepo repo;
  LoadRecentArticles(this.repo);

  Future<List<PreviewArticleEntity>> call() async {
    return await repo.getRecentArticles();
  }
}
