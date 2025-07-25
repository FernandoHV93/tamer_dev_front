import 'package:flutter/material.dart';
import 'package:ia_web_front/core/routes/web_routes.dart';
import 'package:ia_web_front/features/article_builder/presentation/article_builder.dart';
import 'package:ia_web_front/features/article_editor/presentation/article_editor_screen.dart';
import 'package:ia_web_front/features/home/home_screen.dart';
import 'package:ia_web_front/features/roadmap/presentation/roadmap_screen.dart';
import 'package:ia_web_front/features/websites/presentation/websites_view.dart';
import 'package:ia_web_front/features/content/presentation/content_view.dart';
import 'package:ia_web_front/features/api_settings/api_settings_screen.dart';
import 'package:ia_web_front/features/brand_voice/presentation/brand_voice_screen.dart';
import 'package:ia_web_front/features/brand_voice/presentation/provider/brand_voice_provider.dart';
import 'package:ia_web_front/features/brand_voice/presentation/provider/brand_form_provider.dart';
import 'package:ia_web_front/features/brand_voice/domain/usecases/brand_voice_usecases.dart';
import 'package:ia_web_front/features/brand_voice/data/repository/brand_voice_repository_impl.dart';
import 'package:provider/provider.dart';

class BrandVoiceProviders extends StatelessWidget {
  final Widget child;
  const BrandVoiceProviders({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => BrandVoiceProvider(
            BrandVoiceUseCases(
              BrandVoiceRepositoryImpl(),
            ),
          ),
        ),
        ChangeNotifierProvider(create: (_) => BrandFormProvider()),
      ],
      child: child,
    );
  }
}

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
      case WebRoutes.websites:
        return MaterialPageRoute(builder: (_) => const WebsitesView());
      case WebRoutes.content:
        return MaterialPageRoute(builder: (_) => const ContentView());
      case WebRoutes.apiSettings:
        return MaterialPageRoute(builder: (_) => const ApiSettingsScreen());
      case WebRoutes.brandVoice:
        return MaterialPageRoute(builder: (_) => const BrandVoiceScreen());
      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }
}
