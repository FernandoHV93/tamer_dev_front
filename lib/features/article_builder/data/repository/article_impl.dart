import 'package:ia_web_front/core/api/api.dart';
import 'package:ia_web_front/core/api/backend_urls.dart';
import 'package:ia_web_front/features/article_builder/domain/entities/article_builder_entities.dart';
import 'package:ia_web_front/features/article_builder/domain/repository/article_repo.dart';
import 'package:ia_web_front/features/article_editor/domain/entities/article_entity_dto.dart';
import 'package:ia_web_front/features/article_builder/domain/entities/keyword_analysis_result.dart';

class ArticleFuncImpl implements ArticleFunc {
  @override
  Future<ArticleDto> fetchArticleBuilderJson({
    required String sessionID,
    required String userID,
  }) async {
    try {
      final response = await api.post(
        BackendUrls.generateArticle,
        {
          'sessionID': sessionID,
          'userID': userID,
        },
      );

      if (response.containsKey('error')) {
        throw Exception("Error del servidor: ${response['error']}");
      }

      final responseCopy = Map<String, dynamic>.from(response);
      responseCopy.remove('sessionID');
      responseCopy.remove('userID');

      final dto = ArticleDto.fromJson(responseCopy);

      return dto;
    } catch (e) {
      throw Exception("Error al obtener el artículo: $e");
    }
  }

  @override
  Future<void> postDefaultData(
      String sessionId, String userId, ArticleDto defaultDto) async {
    try {
      final jsonToSend = {
        "userID": userId,
        "sessionID": sessionId,
        ...defaultDto.toJson(),
      };

      final result =
          await api.post(BackendUrls.componentArticleFormat, jsonToSend);

      if (result.containsKey('error')) {
        throw Exception("Error del servidor: ${result['error']}");
      }
    } catch (e) {
      throw Exception("Error al enviar el artículo: $e");
    }
  }

  @override
  Future<void> postArticleBuilderJson(
      String sessionId, String userId, ArticleBuilderEntity model) async {
    try {
      final jsonToSend = {
        "userID": userId,
        "sessionID": sessionId,
        ...model.toJson(),
      };
      print(jsonToSend);

      final result = await api.post(BackendUrls.saveForm, jsonToSend);

      if (result.containsKey('error')) {
        throw Exception("Error del servidor: ${result['error']}");
      }
    } catch (e) {
      throw Exception("Error al enviar el artículo: $e");
    }
  }

  @override
  Future<KeywordAnalysisResult> runAnalysis({
    required String sessionId,
    required String userId,
    required String mainKeyword,
    required bool isAutoMode,
  }) async {
    final response = {
      "headings": {"H2": 5, "H3": 8},
      "searchIntent": "N",
      "keywordDifficultyPercent": 20.0,
      "keywordDifficultyLabel": "Easy",
      "media": {"Images": 6, "Videos": 1},
      "content": {"Words": 1500, "Paragraphs": 15}
    };

    final keywordAnalysis = KeywordAnalysisResult.fromJson(response);
    return keywordAnalysis;
  }
}
