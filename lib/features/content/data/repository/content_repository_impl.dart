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
    // final response = await api.get(
    //   BackendUrls.loadContentCards(websiteId),
    // );
    // if (response['error'] != null) {
    //   throw Exception('Error loading content cards:  ${response['error']}');
    // }
    // final List<dynamic> cardsData =
    //     response is List ? response : (response['content-cards'] ?? []);
    // return cardsData.map((data) => ContentCardEntity.fromJson(data)).toList();

    // Dummy data
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      ContentCardEntity(
        id: 'card1',
        websiteId: websiteId,
        title: 'Dummy Card 1',
        url: 'https://dummy1.com',
        keyWordsScore: 80,
        status: ContentCardStatus.done,
      ),
      ContentCardEntity(
        id: 'card2',
        websiteId: websiteId,
        title: 'Dummy Card 2',
        url: 'https://dummy2.com',
        keyWordsScore: 60,
        status: ContentCardStatus.in_progress,
      ),
    ];
  }

  @override
  Future<void> addContentCard(
      ContentCardEntity card, String sessionId, String userId) async {
    // final body = {
    //   'title': card.title,
    //   'url': card.url,
    //   'keyWordsScore': card.keyWordsScore,
    //   'status': card.status.name
    // };
    // final response = await api.post(
    //   BackendUrls.createContentCard(card.websiteId),
    //   body,
    // );
    // if (response['error'] != null) {
    //   throw Exception('Error creating content card: ${response['error']}');
    // }
    await Future.delayed(const Duration(milliseconds: 300));
    return;
  }

  @override
  Future<void> updateContentCard(
      ContentCardEntity card, String sessionId, String userId) async {
    // final body = {
    //   'title': card.title,
    //   'url': card.url,
    //   'keyWordsScore': card.keyWordsScore,
    //   'status': card.status.name
    // };
    // final response = await api.put(
    //   BackendUrls.updateContentCard(card.id),
    //   body,
    // );
    // if (response['error'] != null) {
    //   throw Exception('Error updating content card: ${response['error']}');
    // }
    await Future.delayed(const Duration(milliseconds: 300));
    return;
  }

  @override
  Future<void> deleteContentCard(
      String cardId, String sessionId, String userId) async {
    // final response = await api.delete(
    //   BackendUrls.deleteContentCard(cardId),
    // );
    // if (response['error'] != null) {
    //   throw Exception('Error deleting content card: ${response['error']}');
    // }
    await Future.delayed(const Duration(milliseconds: 300));
    return;
  }

  @override
  Future<List<TopicEntity>> loadTopicsByCardId(
      String cardId, String sessionId, String userId) async {
    // final response = await api.get(
    //   BackendUrls.loadTopicsByCardId(cardId),
    // );
    // if (response['error'] != null) {
    //   throw Exception('Error loading topics: ${response['error']}');
    // }
    // final List<dynamic> topicsData =
    //     response is List ? response : (response['topics'] ?? []);
    // return topicsData.map((data) => TopicEntity.fromJson(data)).toList();

    // Dummy topics
    await Future.delayed(const Duration(milliseconds: 400));
    return [
      TopicEntity(
        id: 'topic1',
        cardId: cardId,
        keyWord: 'SEO',
        kd: '45',
        categories: 'Marketing',
        tags: 'seo,web',
        date: '2024-06-01',
        score: 'A',
        words: '1200',
        schemas: 'schema1',
        status: TopicStatus.initiated,
        position: 1,
        volume: 1000,
      ),
      TopicEntity(
        id: 'topic2',
        cardId: cardId,
        keyWord: 'Flutter',
        kd: '30',
        categories: 'Development',
        tags: 'flutter,mobile',
        date: '2024-06-02',
        score: 'B',
        words: '900',
        schemas: 'schema2',
        status: TopicStatus.initiated,
        position: 2,
        volume: 800,
      ),
    ];
  }

  @override
  Future<void> addTopic(
      TopicEntity topic, String sessionId, String userId) async {
    // final body = {
    //   'keyWord': topic.keyWord ?? '',
    //   'kd': topic.kd ?? '',
    //   'categories': topic.categories ?? '',
    //   'tags': topic.tags ?? '',
    //   'date': topic.date ?? '',
    //   'score': topic.score ?? '',
    //   'words': topic.words ?? '',
    //   'schemas': topic.schemas ?? '',
    //   'status': topic.status.name ?? '',
    //   'position': topic.position ?? 0,
    //   'volume': topic.volume ?? 0,
    // };
    // final response = await api.post(
    //   BackendUrls.addTopic(topic.cardId),
    //   body,
    // );
    // if (response['error'] != null) {
    //   throw Exception('Error creating topic: ${response['error']}');
    // }
    await Future.delayed(const Duration(milliseconds: 300));
    return;
  }

  @override
  Future<void> updateTopic(
      TopicEntity topic, String sessionId, String userId) async {
    // final body = {
    //   'keyWord': topic.keyWord ?? '',
    //   'kd': topic.kd ?? '',
    //   'categories': topic.categories ?? '',
    //   'tags': topic.tags ?? '',
    //   'date': topic.date ?? '',
    //   'score': topic.score ?? '',
    //   'words': topic.words ?? '',
    //   'schemas': topic.schemas ?? '',
    //   'status': topic.status ?? '',
    //   'position': topic.position ?? 0,
    //   'volume': topic.volume ?? 0,
    // };
    // final response = await api.put(
    //   BackendUrls.updateTopic(topic.id),
    //   body,
    // );
    // if (response['error'] != null) {
    //   throw Exception('Error updating topic: ${response['error']}');
    // }
    await Future.delayed(const Duration(milliseconds: 300));
    return;
  }

  @override
  Future<void> deleteTopic(
      String topicId, String sessionId, String userId) async {
    // final response = await api.delete(
    //   BackendUrls.deleteTopic(topicId),
    //   headers: {
    //     'sessionID': sessionId,
    //     'userID': userId,
    //   },
    // );
    // if (response['error'] != null) {
    //   throw Exception('Error deleting topic: ${response['error']}');
    // }
    await Future.delayed(const Duration(milliseconds: 300));
    return;
  }
}
