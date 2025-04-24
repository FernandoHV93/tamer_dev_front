import 'package:ia_web_front/data/models/roadmap_model.dart';
import 'package:ia_web_front/domain/repository/article_repo.dart';

class GenerateArticleFromRoadmap {
  final ArticleFunc repository;

  GenerateArticleFromRoadmap(this.repository);

  Future<void> execute(RoadmapModel model) async {
    await repository.postRoadmapJson(model);
  }
}
