import 'package:flutter/material.dart';
import 'package:ia_web_front/core/routes/web_routes.dart';
import 'package:ia_web_front/features/article_builder/presentation/article_builder.dart';
import 'package:ia_web_front/features/article_editor/presentation/article_editor_screen.dart';
import 'package:ia_web_front/features/content_list/presentation/content_list_screen.dart';
import 'package:ia_web_front/features/home/home_screen.dart';
import 'package:ia_web_front/features/roadmap/presentation/roadmap_screen.dart';

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
        return MaterialPageRoute(builder: (_) => ArticleEditorScreen());
      case WebRoutes.contents:
        return MaterialPageRoute(
            builder: (_) => ContentDashboardPage(selectedAppBarTab: 1));
      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }
}
