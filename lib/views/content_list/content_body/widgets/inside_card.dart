import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ia_web_front/data/models/website_model.dart';
import 'package:ia_web_front/views/content_list/content_body/widgets/add_topic_dialog.dart';
import 'package:ia_web_front/views/content_list/content_body/widgets/topic_item.dart';
import 'package:ia_web_front/views/content_list/controller/websites_controller.dart';
import 'package:provider/provider.dart';

class InsideCard extends StatelessWidget {
  final List<ContentCardModel> contentCards;
  final VoidCallback backOnPressed;

  const InsideCard(
      {super.key, required this.contentCards, required this.backOnPressed});

  @override
  Widget build(BuildContext context) {
    return Consumer<WebsiteController>(
      builder: (context, websiteController, child) {
        final selectedcontentCard = websiteController.selectedContentCard ??
            websiteController.selectedWebsite?.contentCards?.first;
        final contentCards =
            websiteController.selectedWebsite?.contentCards ?? [];
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
                  Text('Back to Cards List',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 103, 103, 103))),
                  const SizedBox(width: 15),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 247, 247, 246),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: PopupMenuButton<String>(
                      initialValue:
                          selectedcontentCard?.title ?? 'Add a Card first',
                      child: Text(
                        selectedcontentCard!
                            .title, // Muestra el nombre de la tarjeta seleccionada
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      itemBuilder: (context) => contentCards.isNotEmpty
                          ? contentCards
                              .map((card) => PopupMenuItem<String>(
                                    value: card.title,
                                    child: Text(card.title),
                                  ))
                              .toList()
                          : [
                              PopupMenuItem<String>(
                                value: 'Add a Card First',
                                child: Text('Add a Card First'),
                              ),
                            ],
                      onSelected: (title) {
                        final newSelectedCard = websiteController
                            .selectedWebsite!.contentCards
                            ?.firstWhere((card) => card.title == title);
                        if (newSelectedCard != null) {
                          websiteController.selectContentCard(newSelectedCard);
                        }
                      },
                    ),
                  ),
                  Spacer(),
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
                        builder: (context) => AddTopicDialog(),
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
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(113, 151, 191, 255),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // changes position of shadow
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Quick Tip',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 11, 67, 135)),
                        ),
                        Text(
                          'Double-click any row or use the edit icon to start editing/creating an article. All changes are saved automatically.',
                          style: TextStyle(
                            fontSize: 16,
                            color: const Color.fromARGB(255, 123, 127, 146),
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
                  borderRadius: BorderRadius.circular(8),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Text('Keyword',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    Expanded(
                        child: Text('KD',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    Expanded(
                        child: Text('Date',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    Expanded(
                        child: Text('Score',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    Expanded(
                        child: Text('Words',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    Expanded(
                        child: Text('Schemas',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    Expanded(
                      child: Text('Categories',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Expanded(
                        child: Text('Tags',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    Expanded(
                        child: Text('Status',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    Expanded(
                        child: Text('Actions',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                  ],
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: selectedcontentCard.topics?.length ?? 0,
                itemBuilder: (context, index) {
                  return TopicItem(
                    topic: selectedcontentCard.topics![index],
                    onEdit: () {},
                    onDelete: () {
                      websiteController.removeTopic(
                        contentCards.indexWhere(
                            (card) => card.title == selectedcontentCard.title),
                        selectedcontentCard.topics!.indexWhere((topic) =>
                            topic.keyWord ==
                            selectedcontentCard.topics![index].keyWord),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
