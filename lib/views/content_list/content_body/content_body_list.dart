import 'package:flutter/material.dart';
import 'package:ia_web_front/views/content_list/content_body/widgets/content_card.dart';

class ContentCardsList extends StatelessWidget {
  const ContentCardsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ContentCard(
            title: 'SEO Fundamentals',
            kdScore: 45,
            volume: '25',
            completed: 2,
            total: 3),
        SizedBox(
          width: 10,
        ),
        ContentCard(
            title: 'SEO Fundamentals',
            kdScore: 45,
            volume: '25',
            completed: 2,
            total: 3),
        SizedBox(
          width: 10,
        ),
        ContentCard(
            title: 'SEO Fundamentals',
            kdScore: 45,
            volume: '25',
            completed: 2,
            total: 3),
      ],
    );
  }
}
