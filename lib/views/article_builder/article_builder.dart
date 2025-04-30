import 'package:flutter/material.dart';
import 'package:ia_web_front/views/article_builder/components/article_distribution.dart';
import 'package:ia_web_front/views/article_builder/components/article_form.dart';
import 'package:ia_web_front/views/article_builder/components/article_settings.dart';
import 'package:ia_web_front/views/article_builder/components/top_title_card.dart';
import 'package:ia_web_front/views/article_builder/components/media_hub_card.dart';
import 'package:ia_web_front/views/article_builder/components/seo_structure.dart';

class ArticleBuilderScreen extends StatefulWidget {
  const ArticleBuilderScreen({super.key});

  @override
  State<ArticleBuilderScreen> createState() => _ArticleBuilderScreenState();
}

class _ArticleBuilderScreenState extends State<ArticleBuilderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(200, 10, 200, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              TopTitleCard(),
              SizedBox(height: 20),
              ArticleForm(),
              SizedBox(height: 25),
              ArticleSettingsCard(),
              SizedBox(height: 25),
              MediaHubCard(),
              SizedBox(height: 25),
              SeoStructure(),
              SizedBox(
                height: 25,
              ),
              ArticleDistributionSection(),
            ],
          ),
        ),
      ),
    );
  }
}
