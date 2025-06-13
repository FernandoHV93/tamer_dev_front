import 'package:flutter/foundation.dart'; // Import necesario para debugPrint
import 'package:flutter/material.dart';
import 'package:ia_web_front/core/api/api.dart';
import 'package:ia_web_front/core/api/backend_urls.dart';
import 'package:ia_web_front/features/article_builder/domain/entities/article_builder_entities.dart';
import 'package:ia_web_front/features/article_builder/domain/repository/article_repo.dart';
import 'package:ia_web_front/features/article_editor/domain/entities/article_entity_dto.dart';

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

      debugPrint("Respuesta del servidor (GET Article Builder): $response");

      final dto = ArticleDto.fromJson(response);

      debugPrint('Mappeo hecho con exito ${dto.h1}');

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
        ...defaultDto
            .toJson(), // Spread operator para incluir todo el contenido del DTO
      };

      final result =
          await api.post(BackendUrls.componentArticleFormat, jsonToSend);

      if (result.containsKey('error')) {
        throw Exception("Error del servidor: ${result['error']}");
      }
      debugPrint("Respuesta del servidor (Article Builder): $result");
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
        ...model
            .toJson(), // Spread operator para incluir todo el contenido del modelo
      };

      final result = await api.post(BackendUrls.saveForm, jsonToSend);

      if (result.containsKey('error')) {
        throw Exception("Error del servidor: ${result['error']}");
      }
      debugPrint("Respuesta del servidor (Article Builder): $result");
    } catch (e) {
      throw Exception("Error al enviar el artículo: $e");
    }
  }
}
