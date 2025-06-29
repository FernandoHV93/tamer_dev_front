import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ia_web_front/core/providers/session_provider.dart';
import 'package:ia_web_front/features/content/presentation/controller/content_provider.dart';

import 'package:ia_web_front/features/content/presentation/widgets/loading_indicator.dart';

import '../topics/add_topic_dialog.dart';
import '../topics/remove_topic_dialog.dart';
import '../topics/topic_item.dart';

class InsideCard extends StatelessWidget {
  final ContentProvider contentProvider;
  final SessionProvider sessionProvider;
  final VoidCallback backOnPressed;

  const InsideCard({
    super.key,
    required this.contentProvider,
    required this.sessionProvider,
    required this.backOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    final selectedCard = contentProvider.contentCards.firstWhere(
      (card) => card.id == contentProvider.selectedCardId,
      orElse: () => throw Exception('Selected card not found'),
    );

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              IconButton(
                icon: SvgPicture.asset(
                  'assets/images/icons/left-arrow.svg',
                  height: 20,
                  width: 20,
                  color: const Color.fromARGB(255, 25, 25, 25),
                ),
                onPressed: backOnPressed,
              ),
              const SizedBox(width: 8),
              const Text(
                'Back to Cards List',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 103, 103, 103),
                ),
              ),
              const SizedBox(width: 15),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 247, 247, 246),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: PopupMenuButton<String>(
                  initialValue: selectedCard.title,
                  child: Text(
                    selectedCard.title,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  itemBuilder: (context) => contentProvider.contentCards
                      .map((card) => PopupMenuItem<String>(
                            value: card.title,
                            child: Text(card.title),
                          ))
                      .toList(),
                  onSelected: (title) {
                    final newSelectedCard = contentProvider.contentCards
                        .firstWhere((card) => card.title == title);
                    contentProvider.selectCard(newSelectedCard.id);
                  },
                ),
              ),
              const Spacer(),
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
                    builder: (context) => AddTopicDialog(
                      contentProvider: contentProvider,
                      sessionProvider: sessionProvider,
                      cardId: selectedCard.id,
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
                      'Add Topic',
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
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(113, 151, 191, 255),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/images/icons/search.svg',
                  height: 30,
                  width: 30,
                  color: const Color.fromARGB(255, 49, 56, 255),
                ),
                const SizedBox(width: 8),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Quick Tip',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 11, 67, 135),
                      ),
                    ),
                    Text(
                      'Double-click any row or use the edit icon to start editing/creating an article. All changes are saved automatically.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 123, 127, 146),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    'Keyword',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Text(
                    'KD',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Date',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Score',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Words',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Schemas',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Categories',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Tags',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Status',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Actions',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          if (contentProvider.isLoadingTopics)
            const LoadingIndicator(text: 'Loading topics...')
          else
            ListView.builder(
              shrinkWrap: true,
              itemCount: contentProvider.selectedCardId != null
                  ? contentProvider
                      .getTopicsForCard(contentProvider.selectedCardId!)
                      .length
                  : 0,
              itemBuilder: (context, index) {
                final topic = contentProvider
                    .getTopicsForCard(contentProvider.selectedCardId!)[index];
                return TopicItem(
                  topic: topic,
                  onEdit: () {
                    // TODO: Implementar edición de topic
                  },
                  onDelete: () {
                    showDialog(
                      context: context,
                      builder: (context) => RemoveTopicDialog(
                        onDelete: () {
                          contentProvider.deleteTopic(
                            topic.id,
                            topic.cardId,
                            sessionProvider.sessionID,
                            sessionProvider.userID,
                          );
                          Navigator.of(context).pop();
                        },
                      ),
                    );
                  },
                );
              },
            ),
        ],
      ),
    );
  }
}
