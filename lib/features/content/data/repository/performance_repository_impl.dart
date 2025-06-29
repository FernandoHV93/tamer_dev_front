import 'package:ia_web_front/features/websites/domain/entities/website_entity.dart';
import 'package:ia_web_front/features/content/domain/entities/inspected_website_entity.dart';
import 'package:ia_web_front/features/content/domain/entities/content_card_entity.dart';
import 'package:ia_web_front/features/content/domain/repository/performance_repository.dart';

class PerformanceRepositoryImpl implements PerformanceRepository {
  @override
  Future<InspectedWebsiteEntity> inspectWebsite(
    WebsiteEntity website,
    String sessionId,
    String userId,
  ) async {
    // Simula delay de red
    await Future.delayed(const Duration(seconds: 2));

    // Dummy cards con data más realista
    final cards = [
      ContentCardEntity(
        id: 'card_${website.id}_1',
        websiteId: website.id,
        title: 'SEO Optimization Guide',
        url: '${website.url}/seo-guide',
        keyWordsScore: 85,
        status: ContentCardStatus.ready,
      ),
      ContentCardEntity(
        id: 'card_${website.id}_2',
        websiteId: website.id,
        title: 'Content Marketing Strategy',
        url: '${website.url}/content-strategy',
        keyWordsScore: 92,
        status: ContentCardStatus.ready,
      ),
      ContentCardEntity(
        id: 'card_${website.id}_3',
        websiteId: website.id,
        title: 'Technical SEO Audit',
        url: '${website.url}/technical-audit',
        keyWordsScore: 78,
        status: ContentCardStatus.ready,
      ),
      ContentCardEntity(
        id: 'card_${website.id}_4',
        websiteId: website.id,
        title: 'Keyword Research Report',
        url: '${website.url}/keyword-research',
        keyWordsScore: 88,
        status: ContentCardStatus.ready,
      ),
    ];

    return InspectedWebsiteEntity(
      website: website,
      contentCards: cards,
      top3Keywords: 12,
      top10Keywords: 34,
      top100Keywords: 120,
      top3Delta: 2,
      top10Delta: 5,
      top100Delta: 10,
    );
  }
}
