import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ia_web_front/core/providers/session_provider.dart';
import 'package:ia_web_front/features/content/presentation/controller/content_provider.dart';

import 'add_card_dialog.dart';
import 'content_card.dart';
import 'edit_card_dialog.dart';
import 'remove_card_dialog.dart';

class ContentCardsList extends StatelessWidget {
  final ContentProvider contentProvider;
  final SessionProvider sessionProvider;
  final Function(String) onCardPressed;

  const ContentCardsList({
    super.key,
    required this.contentProvider,
    required this.sessionProvider,
    required this.onCardPressed,
  });

  @override
  Widget build(BuildContext context) {
    final contentCards = contentProvider.contentCards;
    // Show empty state if no cards
    if (contentCards.isEmpty) {
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
              const Text(
                'Your content plan is empty',
                textAlign: TextAlign.center,
                style: TextStyle(
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AddCardDialog(
                      contentProvider: contentProvider,
                      sessionProvider: sessionProvider,
                    ),
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

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 24),
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
                      builder: (context) => AddCardDialog(
                        contentProvider: contentProvider,
                        sessionProvider: sessionProvider,
                      ),
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
                  onPressed: () => onCardPressed(contentCard.id),
                  onEdit: () {
                    showDialog(
                      context: context,
                      builder: (context) => EditCardDialog(
                        contentCard: contentCard,
                        contentProvider: contentProvider,
                        sessionProvider: sessionProvider,
                      ),
                    );
                  },
                  onDelete: () {
                    showDialog(
                      context: context,
                      builder: (context) => RemoveCardDialog(
                        onDelete: () {
                          contentProvider.deleteContentCard(
                            contentCard.id,
                            sessionProvider.sessionID,
                            sessionProvider.userID,
                          );
                          Navigator.of(context).pop();
                        },
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
