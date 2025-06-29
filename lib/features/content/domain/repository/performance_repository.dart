import 'package:ia_web_front/features/websites/domain/entities/website_entity.dart';
import 'package:ia_web_front/features/content/domain/entities/inspected_website_entity.dart';

abstract class PerformanceRepository {
  Future<InspectedWebsiteEntity> inspectWebsite(
    WebsiteEntity website,
    String sessionId,
    String userId,
  );
}
