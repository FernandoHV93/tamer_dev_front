import 'package:flutter/foundation.dart'; // Import necesario para debugPrint
import 'package:flutter/material.dart';
import 'package:ia_web_front/core/api/api.dart';
import 'package:ia_web_front/core/api/backend_urls.dart';
import 'package:ia_web_front/domain/entities/article_builder_entities.dart';
import 'package:ia_web_front/domain/entities/article_editor_entity.dart';
import 'package:ia_web_front/domain/repository/article_repo.dart';

class ArticleFuncImpl implements ArticleFunc {
  @override
  Future<List<ArticleEditorEntity>> getGeneratedArticle(
      String sessionID, String userID) async {
    try {
      // final result = await api.get(BackendUrls.generateArticle,
      //     params: {'sessionID': sessionID, 'userID': userID});

      // if (result.containsKey('error')) {
      //   throw Exception("Error del servidor: ${result['error']}");
      // }
      List<Map<String, dynamic>> data = [
        {
          "content":
              "Flutter is an open-source UI software development toolkit...",
          "formatting": {
            "isBold": true,
            "isItalic": false,
            "isUnderline": false,
            "textSize": "H1",
            "textAlign": "right"
          }
        },
        {
          "content":
              "It is used to develop applications for Android, iOS, Linux, macOS, Windows, and the web.",
          "formatting": {
            "isBold": false,
            "isItalic": true,
            "isUnderline": false,
            "textSize": "P",
            "textAlign": "left"
          }
        },
        {
          "content":
              "Flutter widgets incorporate all critical platform differences such as scrolling, navigation, and icons.",
          "formatting": {
            "isBold": false,
            "isItalic": false,
            "isUnderline": true,
            "textSize": "H2",
            "textAlign": "right"
          }
        },
        {
          "content": "The framework is open-source and maintained by Google.",
          "formatting": {
            "isBold": true,
            "isItalic": true,
            "isUnderline": false,
            "textSize": "H3",
            "textAlign": "center"
          }
        },
        {
          "content":
              "Flutter's hot reload helps you quickly and easily experiment, build UIs, add features, and fix bugs.",
          "formatting": {
            "isBold": false,
            "isItalic": false,
            "isUnderline": false,
            "textSize": "P",
            "textAlign": "left"
          }
        }
      ];
      // debugPrint("Respuesta del servidor (Roadmap): $result");
      return data.map((e) {
        return ArticleEditorEntity(
            content: e['content'],
            isBold: e['formatting']['isBold'],
            isItalic: e['formatting']['isItalic'],
            isUnderline: e['formatting']['isUnderline'],
            textSize: e['formatting']['textSize'],
            textAlign: e['formatting']['textAlign'] == 'left'
                ? TextAlign.left
                : e['formatting']['textAlign'] == 'right'
                    ? TextAlign.right
                    : e['formatting']['textAlign'] == 'center'
                        ? TextAlign.center
                        : TextAlign.justify);
      }).toList();
    } catch (e) {
      throw Exception("Error al enviar el roadmap: $e");
    }
  }

  @override
  Future<void> postArticleBuilderJson(ArticleBuilderEntity model) async {
    try {
      final result = await api.post(BackendUrls.saveForm, model.toJson());

      if (result.containsKey('error')) {
        throw Exception("Error del servidor: ${result['error']}");
      }

      // Mostrar la respuesta del servidor en el debug
      debugPrint("Respuesta del servidor (Article Builder): $result");
    } catch (e) {
      // Manejo de errores
      throw Exception("Error al enviar el artículo: $e");
    }
  }
}
