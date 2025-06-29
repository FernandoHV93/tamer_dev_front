import 'package:ia_web_front/features/websites/domain/entities/website_entity.dart';
import 'package:ia_web_front/features/content/domain/entities/content_card_entity.dart';

class InspectedWebsiteEntity {
  final WebsiteEntity website;
  final List<ContentCardEntity> contentCards;
  final int top3Keywords;
  final int top10Keywords;
  final int top100Keywords;
  final int top3Delta;
  final int top10Delta;
  final int top100Delta;

  InspectedWebsiteEntity({
    required this.website,
    required this.contentCards,
    required this.top3Keywords,
    required this.top10Keywords,
    required this.top100Keywords,
    required this.top3Delta,
    required this.top10Delta,
    required this.top100Delta,
  });
}
