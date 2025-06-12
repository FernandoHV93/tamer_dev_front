import 'package:flutter/material.dart';
import 'package:ia_web_front/data/models/website_model.dart';
import 'package:ia_web_front/views/content_list/content_body/widgets/content_card_table_item.dart';

class ContentBodyInspectedWebsite extends StatelessWidget {
  final InspectedWebsite inspectedWebsite;
  const ContentBodyInspectedWebsite(
      {super.key, required this.inspectedWebsite});

  @override
  Widget build(BuildContext context) {
    final contentCards = inspectedWebsite.website.contentCards;
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
                        Text(
                          'Top 3',
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black26),
                        ),
                        Spacer(),
                        buildIndicator(inspectedWebsite.top3PositionScaled),
                      ]),
                      Text(
                        '${inspectedWebsite.rankTop3Keywords}',
                        style: const TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold),
                      ), // Agrega más campos según los datos disponibles
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
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
                        Text(
                          'Top 10',
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black26),
                        ),
                        Spacer(),
                        buildIndicator(inspectedWebsite.top10PositionScaled),
                      ]),
                      Text(
                        '${inspectedWebsite.rankTop10Keywords}',
                        style: const TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold),
                      ), // Agrega más campos según los datos disponibles
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
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
                        Text(
                          'Top 100',
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black26),
                        ),
                        Spacer(),
                        buildIndicator(inspectedWebsite.top100PositionScaled),
                      ]),
                      Text(
                        '${inspectedWebsite.rankTop100Keywords}',
                        style: const TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold),
                      ), // Agrega más campos según los datos disponibles
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Column(children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.only(
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
          if (contentCards == null || contentCards.isEmpty)
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
                return ContentCardTableItem(
                  contentCard: contentCard,
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
