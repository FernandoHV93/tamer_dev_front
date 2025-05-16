import 'package:flutter/foundation.dart'; // Import necesario para debugPrint
import 'package:flutter/material.dart';
import 'package:ia_web_front/core/api/api.dart';
import 'package:ia_web_front/core/api/backend_urls.dart';
import 'package:ia_web_front/domain/entities/article_builder_entities.dart';
import 'package:ia_web_front/domain/entities/article_entity_dto.dart';
import 'package:ia_web_front/domain/repository/article_repo.dart';

class ArticleFuncImpl implements ArticleFunc {
  @override
  Future<ArticleDto> fetchArticleBuilderJson({
    required String sessionID,
    required String userID,
  }) async {
    Map<String, dynamic> response = {
      "userID": "12345",
      "sessionID": "abcde6789",
      "H1": {
        "N": true,
        "I": true,
        "U": true,
        "text": "Título Principal",
        "aligment": "center",
        "size": "24px"
      },
      "body": [
        {
          "title": {
            "N": true,
            "I": true,
            "U": true,
            "text": "Subtítulo de Sección",
            "aligment": "left",
            "size": "20px"
          },
          "tables": [
            {
              "rows": [
                [
                  {
                    "N": true,
                    "I": true,
                    "U": true,
                    "text": "Celda 1",
                    "aligment": "center",
                    "size": "16px"
                  },
                  {
                    "N": true,
                    "I": true,
                    "U": true,
                    "text": "Celda 2",
                    "aligment": "center",
                    "size": "16px"
                  }
                ]
              ],
              "columns": [
                {
                  "N": true,
                  "I": true,
                  "U": true,
                  "text": "Encabezado",
                  "aligment": "left",
                  "size": "18px"
                }
              ]
            }
          ],
          "images": [
            {
              "N": true,
              "I": true,
              "U": true,
              "text": "Imagen descriptiva",
              "aligment": "center",
              "size": "auto",
              "url": "https://heroui.com/images/card-example-2.jpeg",
              "isImage": true,
              "properties": {
                "width": "600px",
                "height": "400px",
                "style": "border-radius: 8px"
              }
            }
          ],
          "codes": [
            {
              "N": true,
              "I": true,
              "U": true,
              "text": "Código de ejemplo",
              "aligment": "left",
              "size": "14px",
              "code": "console.log('Hola mundo');"
            }
          ],
          "text": [
            {
              "N": false,
              "I": true,
              "U": true,
              "text": "Este es un párrafo de prueba con formato.",
              "aligment": "justify",
              "size": "16px"
            }
          ],
          "links": [
            {
              "N": true,
              "I": true,
              "U": true,
              "text": "Visita nuestro sitio web",
              "aligment": "center",
              "size": "16px",
              "url": "https://example.com"
            }
          ],
          "citations": [
            {
              "N": true,
              "I": true,
              "U": true,
              "text": "Referencia bibliográfica",
              "aligment": "right",
              "size": "14px",
              "citation": "Autor, Año, Título"
            }
          ]
        }
      ]
    };
    try {
      // final response = await api.post(
      //   BackendUrls.generateArticle,
      //   {
      //     'sessionID': sessionID,
      //     'userID': userID,
      //   },
      // );

      // if (response.containsKey('error')) {
      //   throw Exception("Error del servidor: ${response['error']}");
      // }

      // debugPrint("Respuesta del servidor (GET Article Builder): $response");

      final dto = ArticleDto.fromJson(response);

      debugPrint('Mappeo hecho con exito ${dto.h1}');

      return dto;
    } catch (e) {
      throw Exception("Error al obtener el artículo: $e");
    }
  }

  @override
  Future<void> postDefaultData(ArticleDto defaultDto) async {
    try {
      final result = await api.post(
          BackendUrls.componentArticleFormat, defaultDto.toJson());

      if (result.containsKey('error')) {
        throw Exception("Error del servidor: ${result['error']}");
      }
      debugPrint("Respuesta del servidor (Article Builder): $result");
    } catch (e) {
      throw Exception("Error al enviar el artículo: $e");
    }
  }

  @override
  Future<void> postArticleBuilderJson(ArticleBuilderEntity model) async {
    try {
      final result = await api.post(BackendUrls.saveForm, model.toJson());

      if (result.containsKey('error')) {
        throw Exception("Error del servidor: ${result['error']}");
      }
      debugPrint("Respuesta del servidor (Article Builder): $result");
    } catch (e) {
      throw Exception("Error al enviar el artículo: $e");
    }
  }
}
