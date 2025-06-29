import '../entities/topic_entity.dart';
import '../repository/content_repository.dart';

class TopicUsesCases {
  final ContentRepository repository;

  TopicUsesCases(this.repository);

  Future<List<TopicEntity>> loadTopicsByCardId(
      String cardId, String sessionId, String userId) async {
    return await repository.loadTopicsByCardId(cardId, sessionId, userId);
  }

  Future<void> addTopic(
      TopicEntity topic, String sessionId, String userId) async {
    await repository.addTopic(topic, sessionId, userId);
  }

  Future<void> updateTopic(
      TopicEntity topic, String sessionId, String userId) async {
    await repository.updateTopic(topic, sessionId, userId);
  }

  Future<void> deleteTopic(
      String topicId, String sessionId, String userId) async {
    await repository.deleteTopic(topicId, sessionId, userId);
  }
}
