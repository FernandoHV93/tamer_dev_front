import 'package:flutter/material.dart';
import 'package:ia_web_front/core/providers/session_provider.dart';
import 'package:ia_web_front/features/article_builder/presentation/article_builder.dart';
import 'package:ia_web_front/features/article_editor/presentation/article_editor_screen.dart';
import 'package:ia_web_front/features/content_list/data/models/website_model.dart';
import 'package:ia_web_front/features/content_list/presentation/content_list_screen.dart';
import 'package:ia_web_front/features/content_list/presentation/controller/websites_controller.dart';
import 'package:ia_web_front/features/home/components/article_list_item.dart';
import 'package:ia_web_front/features/home/components/feature_button.dart';
import 'package:provider/provider.dart';
import 'controller/recent_articles_controller.dart';
import 'package:ia_web_front/features/article_editor/presentation/controllers/widgets_controller.dart';
import 'package:ia_web_front/features/roadmap/presentation/roadmap_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final sessionProvider = SessionProvider.of(context);
      final websiteController =
          Provider.of<WebsiteController>(context, listen: false);
      await websiteController.loadWebsites(
        sessionProvider.sessionID,
        sessionProvider.userID,
      );
      websiteController.selectWebsite(websiteController.websites
          .firstWhere(
            (website) => website.status == WebsiteStatus.Active,
          )
          .name);
      final controller =
          Provider.of<RecentArticlesController>(context, listen: false);
      await controller.loadRecentArticles();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF181A20),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 24),
          children: [
            FeatureButton(
              iconPath: 'assets/images/icons/docs.svg',
              title: 'Content',
              description:
                  'Clone SERP winners in seconds. Your CTA lands where conversions peak.',
              badgeText: 'Conversion Rocket',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ContentDashboardPage(selectedAppBarTab: 1)));
              },
            ),
            FeatureButton(
              iconPath: 'assets/images/icons/pen-tool.svg',
              title: 'Article Builder',
              description:
                  'Create the perfect article using only the title. Generate and publish it in 1 click.',
              badgeText: 'Lightning-Fast',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ArticleBuilderScreen()));
              },
            ),
            FeatureButton(
              iconPath: 'assets/images/icons/worldwide.svg',
              title: 'Websites',
              description:
                  'Manage and organize all your websites in one centralized dashboard.',
              badgeText: 'Management',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ContentDashboardPage(selectedAppBarTab: 0)));
              },
            ),
            FeatureButton(
              iconPath: 'assets/images/icons/network.svg',
              title: 'Roadmap',
              description:
                  'Visualiza y organiza tu hoja de ruta de proyectos de manera interactiva.',
              badgeText: 'Planning',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RoadmapScreen(),
                  ),
                );
              },
            ),
            FeatureButton(
              iconPath: 'assets/images/icons/edit.svg',
              title: 'Article Editor',
              description:
                  'Fine-tune and perfect your articles with advanced editing tools.',
              badgeText: 'Advanced',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ArticleEditorScreen()));
              },
            ),
            FeatureButton(
              iconPath: 'assets/images/icons/target.svg',
              title: 'Brand Voice',
              description:
                  'Maintain consistent brand voice across all your content and communications.',
              badgeText: 'Consistency',
              onPressed: () {},
            ),
            FeatureButton(
              iconPath: 'assets/images/icons/settings.svg',
              title: 'API Settings',
              description:
                  'Configure API connections and manage integrations with external services.',
              badgeText: 'Configuration',
              onPressed: () {},
            ),
            // Sección Last Articles
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Last Articles',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Consumer<RecentArticlesController>(
              builder: (context, controller, _) {
                if (controller.isGenerating) {
                  if (controller.generatingError != null) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.error, color: Colors.white),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                controller.generatingError!,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            TextButton(
                              onPressed: controller.retryGeneratingArticle,
                              child: const Text('Retry',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2563EB),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              'Generating article: "${controller.generatingArticleTitle ?? ''}"',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            Consumer<RecentArticlesController>(
              builder: (context, controller, _) {
                final articles = controller.articles;
                if (articles.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                return Column(
                  children: articles
                      .map((preview) => ArticleListItem(
                            preview: preview,
                            onView: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChangeNotifierProvider(
                                    create: (_) => WidgetsController(),
                                    child: ArticleEditorScreen(
                                      initialArticleDto: preview.article,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ))
                      .toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
