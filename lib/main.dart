import 'package:flutter/material.dart';
import 'package:ia_web_front/core/providers/session_provider.dart';
import 'package:ia_web_front/core/routes/route_generator.dart';
import 'package:ia_web_front/core/routes/web_routes.dart';
import 'package:ia_web_front/features/article_editor/presentation/controllers/textformat_controller.dart';
import 'package:ia_web_front/features/article_editor/presentation/controllers/widgets_controller.dart';
import 'package:ia_web_front/features/content_list/data/repository/content_list_impl.dart';
import 'package:ia_web_front/features/content_list/domain/uses_cases/contenlist_usescases.dart';
import 'package:ia_web_front/features/content_list/presentation/controller/websites_controller.dart';
import 'package:ia_web_front/features/roadmap/presentation/controller/roadmap_controller.dart';
import 'package:ia_web_front/features/home/controller/recent_articles_controller.dart';
import 'package:ia_web_front/features/home/usecases/load_recent_articles.dart';
import 'package:ia_web_front/features/home/data/recent_articles_repo_impl.dart';
import 'package:ia_web_front/features/websites/data/repository/website_repository_impl.dart';
import 'package:ia_web_front/features/websites/domain/uses_cases/website_uses_cases.dart';
import 'package:ia_web_front/features/websites/presentation/controller/websites_provider.dart';

import 'package:provider/provider.dart';

void main() {
  final contentRepo = ContentListImpl();
  final contentListUseCases = ContentListUseCases(contentRepo);

  // Configuración para el feature de websites
  final websiteRepo = WebsiteRepositoryImpl();
  final websiteUseCases = WebsiteUseCases(websiteRepo);

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WidgetsController()),
        ChangeNotifierProvider(create: (_) => TextFormatController()),
        Provider<ContentListUseCases>.value(value: contentListUseCases),
        ChangeNotifierProvider<WebsiteController>(
          create: (_) => WebsiteController(contentListUseCases),
        ),
        ChangeNotifierProvider(create: (_) => RoadmapController()),
        ChangeNotifierProvider(
          create: (_) => RecentArticlesController(
            loadRecentArticlesUseCase:
                LoadRecentArticles(RecentArticlesRepoImpl()),
          ),
        ),
        // Nuevo provider para websites
        ChangeNotifierProvider<WebsitesProvider>(
          create: (_) => WebsitesProvider(websiteUseCases),
        ),
      ],
      child: SessionProvider(
          sessionID: 'Mayo8.com',
          userID: 'Mayo8.com',
          child: const MainApp())));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return MaterialApp(
          onGenerateRoute: RouteGenerator.onGenerate,
          initialRoute: WebRoutes.home,
          theme: ThemeData(
            useMaterial3: true,
            textTheme: constraints.maxWidth < 600
                ? ThemeData.light().textTheme.apply(fontSizeFactor: 0.8)
                : ThemeData.light().textTheme,
            fontFamily: 'Roboto',
          ),
        );
      },
    );
  }
}
