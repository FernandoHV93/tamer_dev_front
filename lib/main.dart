import 'package:flutter/material.dart';
import 'package:ia_web_front/core/providers/session_provider.dart';
import 'package:ia_web_front/core/routes/route_generator.dart';
import 'package:ia_web_front/core/routes/web_routes.dart';
import 'package:ia_web_front/data/repository_impl/content_list_impl.dart';
import 'package:ia_web_front/domain/use_cases/content_list/contenlist_usescases.dart';
import 'package:ia_web_front/views/article_editor_finish/controllers/textformat_controller.dart';
import 'package:ia_web_front/views/article_editor_finish/controllers/widgets_controller.dart';
import 'package:ia_web_front/views/content_list/controller/websites_controller.dart';
import 'package:ia_web_front/views/roadmap/controller/roadmap_controller.dart';
import 'package:provider/provider.dart';

void main() {
  final contentRepo = ContentListImpl(); // tu implementación
  final contentListUseCases = ContentListUseCases(contentRepo);

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WidgetsController()),
        ChangeNotifierProvider(create: (_) => TextFormatController()),
        Provider<ContentListUseCases>.value(value: contentListUseCases),
        ChangeNotifierProvider<WebsiteController>(
          create: (_) => WebsiteController(contentListUseCases),
        ),
        ChangeNotifierProvider(create: (_) => RoadmapController())
      ],
      child: SessionProvider(
          sessionID: 'exampleSessionId',
          userID: 'exampleUserId',
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
          ),
        );
      },
    );
  }
}
