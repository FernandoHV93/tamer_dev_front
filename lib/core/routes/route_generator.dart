import 'package:flutter/material.dart';
import 'package:ia_web_front/core/routes/web_routes.dart';
import 'package:ia_web_front/views/article_builder/article_builder.dart';
import 'package:ia_web_front/views/article_editor_finish/article_editor_screen.dart';

// import 'package:ia_web_front/views/article_editor_finish/article_editor_screen.dart';
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
        return MaterialPageRoute(
            builder: (_) => ArticleBuilderScreen(
                  sessionID: settings.arguments as String,
                  userID: settings.arguments as String,
                ));
      case WebRoutes.articleEditor:
        return MaterialPageRoute(
            builder: (_) => ArticleEditorScreen(
                  sessionID: settings.arguments as String,
                  userID: settings.arguments as String,
                ));
      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }
}
