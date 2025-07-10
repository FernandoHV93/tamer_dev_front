import 'package:flutter/material.dart';
import '../entities/preview_article_entity.dart';
import '../usecases/load_recent_articles.dart';
import 'package:ia_web_front/features/article_builder/data/repository/article_impl.dart';
import 'package:ia_web_front/features/article_editor/domain/entities/article_entity_dto.dart';

class RecentArticlesController extends ChangeNotifier {
  final LoadRecentArticles loadRecentArticlesUseCase;
  List<PreviewArticleEntity> _articles = [];
  List<PreviewArticleEntity> get articles => _articles;

  String? _generatingArticleTitle;
  bool _isGenerating = false;
  String? _generatingError;
  String? _sessionId;
  String? _userId;

  bool get isGenerating => _isGenerating;
  String? get generatingArticleTitle => _generatingArticleTitle;
  String? get generatingError => _generatingError;

  RecentArticlesController({required this.loadRecentArticlesUseCase});

  Future<void> loadRecentArticles() async {
    _articles = await loadRecentArticlesUseCase();
    notifyListeners();
  }

  void startGeneratingArticle({
    required String title,
    required String sessionId,
    required String userId,
  }) {
    _generatingArticleTitle = title;
    _isGenerating = true;
    _generatingError = null;
    notifyListeners();
    _generateArticle(sessionId, userId);
  }

  Future<void> _generateArticle(String sessionId, String userId) async {
    final repo = ArticleFuncImpl();
    try {
      final defaultArticleDto = ArticleDto(
        h1: TextFormatDto(
          N: true,
          I: false,
          U: false,
          text: '',
          aligment: 'center',
          size: 'H1',
        ),
        body: [],
      );
      await repo.postDefaultData(sessionId, userId, defaultArticleDto);

      final articleDto = await repo.fetchArticleBuilderJson(
        sessionID: sessionId,
        userID: userId,
      );
      final newArticle = PreviewArticleEntity(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        article: articleDto,
      );
      _articles.insert(0, newArticle);
      _isGenerating = false;
      _generatingArticleTitle = null;
      _generatingError = null;
      notifyListeners();
    } catch (e) {
      _generatingError = e.toString();
      _isGenerating = true;
      notifyListeners();
    }
  }

  void retryGeneratingArticle() {
    _generatingError = null;
    notifyListeners();
    if (_sessionId != null && _userId != null) {
      _generateArticle(_sessionId!, _userId!);
    }
  }
}
