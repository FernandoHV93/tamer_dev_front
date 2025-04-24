import 'package:ia_web_front/data/models/roadmap_model.dart';

abstract class ArticleFunc {
  Future<void> postRoadmapJson(RoadmapModel model);
}
