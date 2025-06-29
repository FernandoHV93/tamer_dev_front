import 'package:flutter/material.dart';
import 'package:ia_web_front/features/content/domain/entities/inspected_website_entity.dart';
import 'package:ia_web_front/features/content/presentation/cards/content_card_entity_table_item.dart';
import 'package:provider/provider.dart';
import 'package:ia_web_front/features/content/presentation/controller/content_provider.dart';

class ContentBodyInspectedWebsite extends StatelessWidget {
  final InspectedWebsiteEntity inspectedWebsite;
  const ContentBodyInspectedWebsite(
      {super.key, required this.inspectedWebsite});

  @override
  Widget build(BuildContext context) {
    final contentCards = inspectedWebsite.contentCards;
    final contentProvider =
        Provider.of<ContentProvider>(context, listen: false);
    return Center(
      child: Column(children: [
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        const Text(
                          'Top 3',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black26),
                        ),
                        const Spacer(),
                        buildIndicator(inspectedWebsite.top3Delta),
                      ]),
                      Text(
                        '${inspectedWebsite.top3Keywords}',
                        style: const TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        const Text(
                          'Top 10',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black26),
                        ),
                        const Spacer(),
                        buildIndicator(inspectedWebsite.top10Delta),
                      ]),
                      Text(
                        '${inspectedWebsite.top10Keywords}',
                        style: const TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        const Text(
                          'Top 100',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black26),
                        ),
                        const Spacer(),
                        buildIndicator(inspectedWebsite.top100Delta),
                      ]),
                      Text(
                        '${inspectedWebsite.top100Keywords}',
                        style: const TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        Column(children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8), topRight: Radius.circular(8)),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Text('Title & Url',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18))),
                Expanded(
                    child: Text('Keywords',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18))),
                Expanded(
                    child: Text('Position',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18))),
                Expanded(
                    child: Text('',
                        style: TextStyle(fontWeight: FontWeight.bold))),
              ],
            ),
          ),
          if (contentCards.isEmpty)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search_off,
                    size: 64,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No hay content cards disponibles',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Los datos se cargarán cuando estén disponibles',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: contentCards.length,
              itemBuilder: (context, index) {
                final contentCard = contentCards[index];
                final topics = contentProvider.getTopicsForCard(contentCard.id);
                return ContentCardEntityTableItem(
                  contentCard: contentCard,
                  topics: topics,
                  onTap: () {},
                );
              },
            ),
        ]),
      ]),
    );
  }

  Widget buildIndicator(int value) {
    final isPositive = value >= 0;
    final color = isPositive ? Colors.green : Colors.red;
    final icon =
        isPositive ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: color,
          size: 20,
        ),
        const SizedBox(width: 4),
        Text(
          '${value.abs()}',
          style: TextStyle(
            fontSize: 16,
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
