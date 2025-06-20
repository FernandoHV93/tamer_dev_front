import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ia_web_front/features/content_list/data/models/website_model.dart';
import 'package:ia_web_front/features/content_list/presentation/content_body/widgets/add_card_dialog.dart';
import 'package:ia_web_front/features/content_list/presentation/content_body/widgets/content_card.dart';
import 'package:ia_web_front/features/content_list/presentation/content_body/widgets/edit_card_dialog.dart';
import 'package:ia_web_front/features/content_list/presentation/content_body/widgets/remove_card_dialog.dart';
import 'package:ia_web_front/features/content_list/presentation/controller/websites_controller.dart';

import 'package:provider/provider.dart';

class ContentCardsList extends StatelessWidget {
  final void Function(ContentCardModel) onPressed;

  const ContentCardsList({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Consumer<WebsiteController>(
      builder: (context, websiteController, child) {
        final selectedWebsite = websiteController.selectedWebsite;

        // Show empty state if no website is selected or if it has no cards.
        if (selectedWebsite == null ||
            (selectedWebsite.contentCards?.isEmpty ?? true)) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.post_add_rounded,
                    size: 80,
                    color: Colors.grey.shade300,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Your content plan for "${selectedWebsite?.name ?? 'this website'}" is empty',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Click the button below to add your first content card and start building your strategy.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 23, 87, 223),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      if (selectedWebsite == null) return;
                      showDialog(
                        context: context,
                        builder: (context) => const AddCardDialog(),
                      );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          'assets/images/icons/add.svg',
                          height: 25,
                          width: 25,
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Add Your First Card',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        final contentCards = selectedWebsite.contentCards!;

        return Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 23, 87, 223),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => const AddCardDialog(),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/images/icons/add.svg',
                          height: 25,
                          width: 25,
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Add Card',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Wrap(
                spacing: 12,
                runSpacing: 8,
                children: contentCards.map((contentCard) {
                  return ContentCard(
                    contentCard: contentCard,
                    onPressed: () => onPressed(contentCard),
                    onEdit: () {
                      showDialog(
                        context: context,
                        builder: (context) =>
                            EditCardDialog(contentCard: contentCard),
                      );
                    },
                    onDelete: () {
                      showDialog(
                          context: context,
                          builder: (context) => RemoveCardDialog(onDelete: () {
                                websiteController.removeContentCard(
                                  contentCards.indexWhere((card) =>
                                      card.title == contentCard.title),
                                );
                                Navigator.of(context).pop();
                              }));
                    },
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}
