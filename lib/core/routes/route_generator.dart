import 'package:flutter/material.dart';
import 'package:ia_web_front/core/routes/web_routes.dart';
import 'package:ia_web_front/domain/entities/article_editor_entity.dart';
import 'package:ia_web_front/views/article_builder/article_builder.dart';
import 'package:ia_web_front/views/article_editor/article_editor_screen.dart';
import 'package:ia_web_front/views/home/home_screen.dart';
import 'package:ia_web_front/views/roadmap/roadmap_screen.dart';

class RouteGenerator {
  static Route? onGenerate(RouteSettings settings) {
    final route = settings.name;
    switch (route) {
      case WebRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case WebRoutes.roadmap:
        return MaterialPageRoute(builder: (_) => const RoadmapScreen());
      case WebRoutes.articleBuilder:
        return MaterialPageRoute(builder: (_) => ArticleBuilderScreen());
      case WebRoutes.articleEditor:
        return MaterialPageRoute(
            builder: (_) => ArticleEditorScreen(
                  articleEditorEntities:
                      settings.arguments as List<ArticleEditorEntity>?,
                ));
      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }
}
