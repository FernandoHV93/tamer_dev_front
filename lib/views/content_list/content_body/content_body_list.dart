import 'package:flutter/material.dart';
import 'package:ia_web_front/data/models/website_model.dart';
import 'package:ia_web_front/views/content_list/content_body/widgets/content_card.dart';
import 'package:ia_web_front/views/content_list/controller/websites_controller.dart';
import 'package:provider/provider.dart';

class ContentCardsList extends StatelessWidget {
  final void Function(ContentCardModel) onPressed;
  const ContentCardsList({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final websiteController = Provider.of<WebsiteController>(context);
    final selectedWebsite = websiteController.selectedWebsite;

    final contentCards = selectedWebsite?.contentCards ?? [];

    return SingleChildScrollView(
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: contentCards.map((contentCard) {
          return ContentCard(
            contentCard: contentCard,
            onPressed: () => onPressed(contentCard),
          );
        }).toList(),
      ),
    );
  }
}
