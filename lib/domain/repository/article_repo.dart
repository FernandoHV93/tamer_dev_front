import 'package:ia_web_front/data/models/roadmap_model.dart';
import 'package:ia_web_front/domain/entities/article_builder_entities.dart';

abstract class ArticleFunc {
  Future<void> postRoadmapJson(RoadmapModel model);
  Future<void> postArticleBuilderJson(ArticleBuilderEntity model);
}
