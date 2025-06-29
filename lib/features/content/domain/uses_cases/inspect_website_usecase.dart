import 'package:ia_web_front/features/websites/domain/entities/website_entity.dart';
import 'package:ia_web_front/features/content/domain/entities/inspected_website_entity.dart';
import 'package:ia_web_front/features/content/domain/repository/performance_repository.dart';

class InspectWebsiteUseCase {
  final PerformanceRepository repository;
  InspectWebsiteUseCase(this.repository);

  Future<InspectedWebsiteEntity> call(
    WebsiteEntity website,
    String sessionId,
    String userId,
  ) async {
    return await repository.inspectWebsite(website, sessionId, userId);
  }
}
