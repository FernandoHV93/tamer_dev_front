import '../entities/content_card_entity.dart';
import '../entities/topic_entity.dart';

abstract class ContentRepository {
  Future<List<ContentCardEntity>> loadContentCardsByWebsiteId(
      String websiteId, String sessionId, String userId);
  Future<List<TopicEntity>> loadTopicsByCardId(
      String cardId, String sessionId, String userId);

  Future<void> addContentCard(
      ContentCardEntity card, String sessionId, String userId);
  Future<void> updateContentCard(
      ContentCardEntity card, String sessionId, String userId);
  Future<void> deleteContentCard(
      String cardId, String sessionId, String userId);

  Future<void> addTopic(TopicEntity topic, String sessionId, String userId);
  Future<void> updateTopic(TopicEntity topic, String sessionId, String userId);
  Future<void> deleteTopic(String topicId, String sessionId, String userId);
}
