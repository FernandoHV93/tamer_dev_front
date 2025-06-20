import 'package:flutter/material.dart';
import 'package:ia_web_front/core/providers/session_provider.dart';
import 'package:ia_web_front/features/article_builder/presentation/article_builder.dart';
import 'package:ia_web_front/features/article_editor/presentation/article_editor_screen.dart';
import 'package:ia_web_front/features/content_list/data/models/website_model.dart';
import 'package:ia_web_front/features/content_list/presentation/content_list_screen.dart';
import 'package:ia_web_front/features/content_list/presentation/controller/websites_controller.dart';
import 'package:ia_web_front/features/home/components/feature_button.dart';
import 'package:provider/provider.dart';

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
              iconPath: 'assets/images/icons/article_builder.svg',
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
          ],
        ),
      ),
    );
  }
}
