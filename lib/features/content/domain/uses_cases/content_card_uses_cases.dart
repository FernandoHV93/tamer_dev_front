import '../entities/content_card_entity.dart';
import '../repository/content_repository.dart';

class ContentCardUsesCases {
  final ContentRepository repository;

  ContentCardUsesCases(this.repository);

  Future<List<ContentCardEntity>> loadContentCardsByWebsiteId(
      String websiteId, String sessionId, String userId) async {
    return await repository.loadContentCardsByWebsiteId(
        websiteId, sessionId, userId);
  }

  Future<void> addContentCard(
      ContentCardEntity card, String sessionId, String userId) async {
    await repository.addContentCard(card, sessionId, userId);
  }

  Future<void> updateContentCard(
      ContentCardEntity card, String sessionId, String userId) async {
    await repository.updateContentCard(card, sessionId, userId);
  }

  Future<void> deleteContentCard(
      String cardId, String sessionId, String userId) async {
    await repository.deleteContentCard(cardId, sessionId, userId);
  }
}
