import 'package:ia_web_front/core/api/api.dart';
import 'package:ia_web_front/core/api/backend_urls.dart';
import 'package:ia_web_front/data/models/roadmap_model.dart';
import 'package:ia_web_front/domain/repository/article_repo.dart';

class ArticleFuncImpl implements ArticleFunc {
  @override
  Future<void> postRoadmapJson(RoadmapModel model) async {
    try {
      final result =
          await api.post(BackendUrls.generateArticle, model.toJson());

      if (result.containsKey('error')) {
        throw Exception("Error del servidor: ${result['error']}");
      }
    } catch (e) {
      // Manejo de errores
      throw Exception("Error al enviar el roadmap: $e");
    }

    // Aquí puedes manejar la respuesta del servidor si es necesario
  }
}
