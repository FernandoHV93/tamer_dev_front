import 'package:flutter/material.dart';
import 'package:ia_web_front/features/article_builder/presentation/controller/article_builder_provider.dart';
import 'package:provider/provider.dart';
import 'package:ia_web_front/core/providers/session_provider.dart';
import 'package:ia_web_front/features/article_builder/presentation/components/article_distribution.dart';
import 'package:ia_web_front/features/article_builder/presentation/components/article_settings.dart';
import 'package:ia_web_front/features/article_builder/presentation/components/media_hub_card.dart';
import 'package:ia_web_front/features/article_builder/presentation/components/seo_structure.dart';
import 'package:ia_web_front/features/article_editor/presentation/article_editor_screen.dart';
import 'package:ia_web_front/features/article_builder/presentation/components/main_form.dart';

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

    try {
      // 1. Enviar datos por defecto
      await provider.sendDefaultData(
        sessionId: sessionProvider.sessionID,
        userId: sessionProvider.userID,
      );

      // 2. Generar el artículo y obtener el DTO
      final articleDto = await provider.fetchGeneratedArticle(
        sessionId: sessionProvider.sessionID,
        userId: sessionProvider.userID,
      );

      // 3. Navegar SOLO si todo salió bien, pasando el DTO
      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticleEditorScreen(
              initialArticleDto: articleDto, // Pasar el DTO como parámetro
            ),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error al generar el artículo: $e"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
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
              // Loading overlay
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
