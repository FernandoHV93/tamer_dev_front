import 'package:flutter/material.dart';
import 'package:ia_web_front/features/article_builder/presentation/controller/article_builder_provider.dart';
import 'package:provider/provider.dart';
import 'package:ia_web_front/core/providers/session_provider.dart';
import 'package:ia_web_front/features/article_builder/presentation/components/article_distribution.dart';
import 'package:ia_web_front/features/article_builder/presentation/components/article_settings.dart';
import 'package:ia_web_front/features/article_builder/presentation/components/media_hub_card.dart';
import 'package:ia_web_front/features/article_builder/presentation/components/seo_structure.dart';
import 'package:ia_web_front/features/article_builder/presentation/components/main_form.dart';
import 'package:ia_web_front/features/home/controller/recent_articles_controller.dart';

class ArticleBuilderScreen extends StatelessWidget {
  const ArticleBuilderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ArticleBuilderProvider(),
      child: const _ArticleBuilderContent(),
    );
  }
}

class _ArticleBuilderContent extends StatelessWidget {
  const _ArticleBuilderContent();

  void _handleSave(BuildContext context) async {
    final provider = context.read<ArticleBuilderProvider>();
    final sessionProvider = SessionProvider.of(context);

    try {
      await provider.saveForm(
        sessionId: sessionProvider.sessionID,
        userId: sessionProvider.userID,
      );

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Formulario guardado exitosamente"),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error al guardar: $e"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _handleGenerateArticle(BuildContext context) async {
    final provider = context.read<ArticleBuilderProvider>();
    final sessionProvider = SessionProvider.of(context);
    final homeController =
        Provider.of<RecentArticlesController>(context, listen: false);
    final title =
        provider.articleBuilderEntity.articleGeneratorGeneral.articleTitle;

    Navigator.of(context).popUntil((route) => route.isFirst);
    homeController.startGeneratingArticle(
      title: title,
      sessionId: sessionProvider.sessionID,
      userId: sessionProvider.userID,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 30, 30, 30),
      body: Consumer<ArticleBuilderProvider>(
        builder: (context, provider, child) {
          return Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(200, 10, 200, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MainForm(
                        onSave: () => _handleSave(context),
                        onGenerate: () => _handleGenerateArticle(context),
                      ),
                      const SizedBox(height: 25),
                      const ArticleSettingsCard(),
                      const SizedBox(height: 25),
                      const MediaHubCard(),
                      const SizedBox(height: 25),
                      const SeoStructure(),
                      const SizedBox(height: 25),
                      const ArticleDistributionSection(),
                    ],
                  ),
                ),
              ),
              if (provider.isLoading)
                Container(
                  color: Colors.black54,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
