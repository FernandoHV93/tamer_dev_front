import 'dart:async';
import 'package:ia_web_front/features/content/domain/entities/content_card_entity.dart';
import 'package:ia_web_front/features/content/domain/entities/topic_entity.dart';
import 'package:ia_web_front/features/content/domain/repository/content_repository.dart';

class DummyContentRepositoryImpl implements ContentRepository {
  final List<ContentCardEntity> _cards = [
    ContentCardEntity(
      id: 'card1',
      websiteId: '1',
      title: 'SEO Audit',
      url: 'https://example.com/audit',
      keyWordsScore: 85,
      status: ContentCardStatus.ready,
    ),
    ContentCardEntity(
      id: 'card2',
      websiteId: '1',
      title: 'Content Plan',
      url: 'https://example.com/plan',
      keyWordsScore: 70,
      status: ContentCardStatus.ready,
    ),
    ContentCardEntity(
      id: 'card3',
      websiteId: '2',
      title: 'Competitor Analysis',
      url: 'https://example.com/competitors',
      keyWordsScore: 60,
      status: ContentCardStatus.notReady,
    ),
  ];

  final List<TopicEntity> _topics = [
    TopicEntity(
      id: 'topic1',
      cardId: 'card1',
      keyWord: 'SEO basics',
      date: '2024-06-01',
      status: TopicStatus.covered,
    ),
    TopicEntity(
      id: 'topic2',
      cardId: 'card1',
      keyWord: 'On-page SEO',
      date: '2024-06-02',
      status: TopicStatus.draft,
    ),
    TopicEntity(
      id: 'topic3',
      cardId: 'card2',
      keyWord: 'Content calendar',
      date: '2024-06-03',
      status: TopicStatus.initiated,
    ),
  ];

  @override
  Future<List<ContentCardEntity>> loadContentCardsByWebsiteId(
      String websiteId, String sessionId, String userId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    print(
        'Loading content cards for website: $websiteId, session: $sessionId, user: $userId');
    return _cards.where((c) => c.websiteId == websiteId).toList();
  }

  @override
  Future<List<TopicEntity>> loadTopicsByCardId(
      String cardId, String sessionId, String userId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    print(
        'Loading topics for card: $cardId, session: $sessionId, user: $userId');
    return _topics.where((t) => t.cardId == cardId).toList();
  }

  @override
  Future<void> addContentCard(
      ContentCardEntity card, String sessionId, String userId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    print(
        'Adding content card: ${card.title}, session: $sessionId, user: $userId');
    _cards.add(card);
  }

  @override
  Future<void> updateContentCard(
      ContentCardEntity card, String sessionId, String userId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    print(
        'Updating content card: ${card.title}, session: $sessionId, user: $userId');
    final idx = _cards.indexWhere((c) => c.id == card.id);
    if (idx != -1) _cards[idx] = card;
  }

  @override
  Future<void> deleteContentCard(
      String cardId, String sessionId, String userId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    print('Deleting content card: $cardId, session: $sessionId, user: $userId');
    _cards.removeWhere((c) => c.id == cardId);
  }

  @override
  Future<void> addTopic(
      TopicEntity topic, String sessionId, String userId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    print('Adding topic: ${topic.keyWord}, session: $sessionId, user: $userId');
    _topics.add(topic);
  }

  @override
  Future<void> updateTopic(
      TopicEntity topic, String sessionId, String userId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    print(
        'Updating topic: ${topic.keyWord}, session: $sessionId, user: $userId');
    final idx = _topics.indexWhere((t) => t.id == topic.id);
    if (idx != -1) _topics[idx] = topic;
  }

  @override
  Future<void> deleteTopic(
      String topicId, String sessionId, String userId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    print('Deleting topic: $topicId, session: $sessionId, user: $userId');
    _topics.removeWhere((t) => t.id == topicId);
  }
}
