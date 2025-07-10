import 'package:flutter/material.dart';
import 'package:ia_web_front/core/providers/session_provider.dart';
import 'package:ia_web_front/core/routes/route_generator.dart';
import 'package:ia_web_front/core/routes/web_routes.dart';
import 'package:ia_web_front/features/article_editor/presentation/controllers/textformat_controller.dart';
import 'package:ia_web_front/features/article_editor/presentation/controllers/widgets_controller.dart';
import 'package:ia_web_front/features/roadmap/presentation/controller/roadmap_controller.dart';
import 'package:ia_web_front/features/home/controller/recent_articles_controller.dart';
import 'package:ia_web_front/features/home/usecases/load_recent_articles.dart';
import 'package:ia_web_front/features/home/data/recent_articles_repo_impl.dart';
import 'package:ia_web_front/features/websites/data/repository/website_repository_impl.dart';
import 'package:ia_web_front/features/websites/domain/uses_cases/website_uses_cases.dart';
import 'package:ia_web_front/features/websites/presentation/controller/websites_provider.dart';
import 'package:ia_web_front/features/content/data/repository/content_repository_impl.dart';
import 'package:ia_web_front/features/content/domain/uses_cases/content_card_uses_cases.dart';
import 'package:ia_web_front/features/content/domain/uses_cases/topic_uses_cases.dart';
import 'package:ia_web_front/features/content/presentation/controller/content_provider.dart';
import 'package:ia_web_front/features/content/data/repository/performance_repository_impl.dart';
import 'package:ia_web_front/features/content/domain/uses_cases/inspect_website_usecase.dart';
import 'package:ia_web_front/features/content/presentation/controller/performance_provider.dart';
import 'features/brand_voice/data/repository/brand_voice_repository_impl.dart';
import 'features/brand_voice/domain/usecases/brand_voice_usecases.dart';
import 'features/brand_voice/presentation/provider/brand_voice_provider.dart';
import 'features/brand_voice/presentation/provider/brand_form_provider.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:provider/provider.dart';

void main() {
  final websiteRepo = WebsiteRepositoryImpl();
  final websiteUseCases = WebsiteUseCases(websiteRepo);

  final contentRepository = ContentRepositoryImpl();
  final contentCardUseCases = ContentCardUsesCases(contentRepository);
  final topicUseCases = TopicUsesCases(contentRepository);

  final performanceRepo = PerformanceRepositoryImpl();
  final inspectWebsiteUseCase = InspectWebsiteUseCase(performanceRepo);

  final brandVoiceRepo = BrandVoiceRepositoryImpl();
  final brandVoiceUseCases = BrandVoiceUseCases(brandVoiceRepo);

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WidgetsController()),
        ChangeNotifierProvider(create: (_) => TextFormatController()),
        ChangeNotifierProvider(create: (_) => RoadmapController()),
        ChangeNotifierProvider(
          create: (_) => RecentArticlesController(
            loadRecentArticlesUseCase:
                LoadRecentArticles(RecentArticlesRepoImpl()),
          ),
        ),
        ChangeNotifierProvider<WebsitesProvider>(
          create: (_) => WebsitesProvider(websiteUseCases),
        ),
        ChangeNotifierProvider<ContentProvider>(
          create: (_) => ContentProvider(contentCardUseCases, topicUseCases),
        ),
        ChangeNotifierProxyProvider<ContentProvider, PerformanceProvider>(
          create: (context) => PerformanceProvider(
            inspectWebsiteUseCase,
            context.read<ContentProvider>(),
          ),
          update: (context, contentProvider, previous) =>
              previous ??
              PerformanceProvider(
                inspectWebsiteUseCase,
                contentProvider,
              ),
        ),
        ChangeNotifierProvider<BrandVoiceProvider>(
          create: (_) => BrandVoiceProvider(brandVoiceUseCases),
        ),
        ChangeNotifierProvider<BrandFormProvider>(
          create: (_) => BrandFormProvider(),
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
                ? ThemeData.dark().textTheme.apply(fontSizeFactor: 0.8)
                : ThemeData.dark().textTheme,
            fontFamily: 'Roboto',
          ),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            FlutterQuillLocalizations.delegate,
          ],
        );
      },
    );
  }
}
