import 'package:flutter/material.dart';
import 'package:ia_web_front/core/routes/web_routes.dart';
import 'package:ia_web_front/views/article_builder/article_builder.dart';
import 'package:ia_web_front/views/article_editor_finish/article_editor_screen.dart';
import 'package:ia_web_front/views/content_list/content_list_screen.dart';
import 'package:ia_web_front/views/home/home_screen.dart';

import 'package:ia_web_front/views/roadmap/screen/roadmap_screen.dart';

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
        return MaterialPageRoute(builder: (_) => ContentDashboardPage());
      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }
}
