import 'package:flutter/material.dart';
import '../entities/preview_article_entity.dart';
import '../usecases/load_recent_articles.dart';

class RecentArticlesController extends ChangeNotifier {
  final LoadRecentArticles loadRecentArticlesUseCase;
  List<PreviewArticleEntity> _articles = [];
  List<PreviewArticleEntity> get articles => _articles;

  RecentArticlesController({required this.loadRecentArticlesUseCase});

  Future<void> loadRecentArticles() async {
    _articles = await loadRecentArticlesUseCase();
    notifyListeners();
  }
}
