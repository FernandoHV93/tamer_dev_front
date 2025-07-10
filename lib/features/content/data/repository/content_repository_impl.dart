import 'dart:async';
import 'package:ia_web_front/features/content/domain/entities/content_card_entity.dart';
import 'package:ia_web_front/features/content/domain/entities/topic_entity.dart';
import 'package:ia_web_front/features/content/domain/repository/content_repository.dart';
import 'package:ia_web_front/core/api/api.dart';
import 'package:ia_web_front/core/api/backend_urls.dart';

class ContentRepositoryImpl implements ContentRepository {
  @override
  Future<List<ContentCardEntity>> loadContentCardsByWebsiteId(
      String websiteId, String sessionId, String userId) async {
    final response = await api.get(
      BackendUrls.loadContentCards(websiteId),
    );
    if (response['error'] != null) {
      throw Exception('Error loading content cards:  ${response['error']}');
    }
    final List<dynamic> cardsData =
        response is List ? response : (response['content-cards'] ?? []);
    return cardsData.map((data) => ContentCardEntity.fromJson(data)).toList();
  }

  @override
  Future<void> addContentCard(
      ContentCardEntity card, String sessionId, String userId) async {
    final body = {
      'title': card.title,
      'url': card.url,
      'keyWordsScore': card.keyWordsScore,
      'status': card.status.name
    };
    final response = await api.post(
      BackendUrls.createContentCard(card.websiteId),
      body,
    );
    if (response['error'] != null) {
      throw Exception('Error creating content card: ${response['error']}');
    }
  }

  @override
  Future<void> updateContentCard(
      ContentCardEntity card, String sessionId, String userId) async {
    final body = {
      'title': card.title,
      'url': card.url,
      'keyWordsScore': card.keyWordsScore,
      'status': card.status.name
    };
    final response = await api.put(
      BackendUrls.updateContentCard(card.id),
      body,
    );
    if (response['error'] != null) {
      throw Exception('Error updating content card: ${response['error']}');
    }
  }

  @override
  Future<void> deleteContentCard(
      String cardId, String sessionId, String userId) async {
    final response = await api.delete(
      BackendUrls.deleteContentCard(cardId),
    );
    if (response['error'] != null) {
      throw Exception('Error deleting content card: ${response['error']}');
    }
  }

  @override
  Future<List<TopicEntity>> loadTopicsByCardId(
      String cardId, String sessionId, String userId) async {
    final response = await api.get(
      BackendUrls.loadTopicsByCardId(cardId),
    );
    if (response['error'] != null) {
      throw Exception('Error loading topics: ${response['error']}');
    }
    final List<dynamic> topicsData =
        response is List ? response : (response['topics'] ?? []);
    return topicsData.map((data) => TopicEntity.fromJson(data)).toList();
  }

  @override
  Future<void> addTopic(
      TopicEntity topic, String sessionId, String userId) async {
    final body = {
      'keyWord': topic.keyWord ?? '',
      'kd': topic.kd ?? '',
      'categories': topic.categories ?? '',
      'tags': topic.tags ?? '',
      'date': topic.date ?? '',
      'score': topic.score ?? '',
      'words': topic.words ?? '',
      'schemas': topic.schemas ?? '',
      'status': topic.status.name ?? '',
      'position': topic.position ?? 0,
      'volume': topic.volume ?? 0,
    };
    final response = await api.post(
      BackendUrls.addTopic(topic.cardId),
      body,
    );
    if (response['error'] != null) {
      throw Exception('Error creating topic: ${response['error']}');
    }
  }

  @override
  Future<void> updateTopic(
      TopicEntity topic, String sessionId, String userId) async {
    final body = {
      'keyWord': topic.keyWord ?? '',
      'kd': topic.kd ?? '',
      'categories': topic.categories ?? '',
      'tags': topic.tags ?? '',
      'date': topic.date ?? '',
      'score': topic.score ?? '',
      'words': topic.words ?? '',
      'schemas': topic.schemas ?? '',
      'status': topic.status ?? '',
      'position': topic.position ?? 0,
      'volume': topic.volume ?? 0,
    };
    final response = await api.put(
      BackendUrls.updateTopic(topic.id),
      body,
    );
    if (response['error'] != null) {
      throw Exception('Error updating topic: ${response['error']}');
    }
  }

  @override
  Future<void> deleteTopic(
      String topicId, String sessionId, String userId) async {
    final response = await api.delete(
      BackendUrls.deleteTopic(topicId),
      headers: {
        'sessionID': sessionId,
        'userID': userId,
      },
    );
    if (response['error'] != null) {
      throw Exception('Error deleting topic: ${response['error']}');
    }
  }
}
