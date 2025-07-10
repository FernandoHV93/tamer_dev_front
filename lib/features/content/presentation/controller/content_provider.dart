import 'package:flutter/material.dart';
import 'package:ia_web_front/features/content/domain/entities/content_card_entity.dart';
import 'package:ia_web_front/features/content/domain/entities/topic_entity.dart';
import 'package:ia_web_front/features/content/domain/entities/inspected_website_entity.dart';
import 'package:ia_web_front/features/content/domain/uses_cases/content_card_uses_cases.dart';
import 'package:ia_web_front/features/content/domain/uses_cases/topic_uses_cases.dart';

class ContentProvider extends ChangeNotifier {
  final ContentCardUsesCases _contentCardUsesCases;
  final TopicUsesCases _topicUsesCases;

  ContentProvider(this._contentCardUsesCases, this._topicUsesCases);

  // Estado para content cards
  List<ContentCardEntity> _contentCards = [];
  bool _isLoadingCards = false;
  String? _selectedWebsiteId;
  String? _selectedCardId;
  bool _isInsideCard = false;
  bool get isInsideCard => _isInsideCard;

  // Estado para topics por cardId
  final Map<String, List<TopicEntity>> _topicsByCardId = {};
  bool _isLoadingTopics = false;

  // Getters
  List<ContentCardEntity> get contentCards => _contentCards;
  bool get isLoadingCards => _isLoadingCards;
  String? get selectedWebsiteId => _selectedWebsiteId;
  String? get selectedCardId => _selectedCardId;
  bool get isLoadingTopics => _isLoadingTopics;

  // Acceso a los topics de una card
  List<TopicEntity> getTopicsForCard(String cardId) =>
      _topicsByCardId[cardId] ?? [];

  // Content Cards Methods
  Future<void> loadContentCardsByWebsiteId(
      String websiteId, String sessionId, String userId) async {
    _selectedWebsiteId = websiteId;
    print(_selectedWebsiteId);
    notifyListeners();
    _isLoadingCards = true;
    try {
      _contentCards = await _contentCardUsesCases.loadContentCardsByWebsiteId(
          websiteId, sessionId, userId);

      if (_contentCards.isNotEmpty) {
        _selectedCardId = _contentCards.first.id;
      } else {
        _selectedCardId = null;
      }

      await _loadAllTopicsForCards(_contentCards, sessionId, userId);
    } catch (e) {
      debugPrint('Error loading content cards: $e');
      _contentCards = [];
      _topicsByCardId.clear();
      _selectedCardId = null;
    } finally {
      _isLoadingCards = false;
      notifyListeners();
    }
  }

  Future<void> _loadAllTopicsForCards(
      List<ContentCardEntity> cards, String sessionId, String userId) async {
    _isLoadingTopics = true;
    notifyListeners();
    try {
      _topicsByCardId.clear();
      for (final card in cards) {
        final topics = await _topicUsesCases.loadTopicsByCardId(
            card.id, sessionId, userId);
        _topicsByCardId[card.id] = topics;
      }
    } catch (e) {
      debugPrint('Error loading topics for cards: $e');
    } finally {
      _isLoadingTopics = false;
      notifyListeners();
    }
  }

  Future<void> addContentCard(
      ContentCardEntity card, String sessionId, String userId) async {
    try {
      await _contentCardUsesCases.addContentCard(card, sessionId, userId);
      if (card.websiteId == _selectedWebsiteId) {
        _contentCards.add(card);
        // Cargar topics para la nueva card
        final topics = await _topicUsesCases.loadTopicsByCardId(
            card.id, sessionId, userId);
        _topicsByCardId[card.id] = topics;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error adding content card: $e');
    }
  }

  Future<void> updateContentCard(
      ContentCardEntity card, String sessionId, String userId) async {
    try {
      await _contentCardUsesCases.updateContentCard(card, sessionId, userId);
      final index = _contentCards.indexWhere((c) => c.id == card.id);
      if (index != -1) {
        _contentCards[index] = card;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error updating content card: $e');
    }
  }

  Future<void> deleteContentCard(
      String cardId, String sessionId, String userId) async {
    try {
      await _contentCardUsesCases.deleteContentCard(cardId, sessionId, userId);
      _contentCards.removeWhere((card) => card.id == cardId);
      _topicsByCardId.remove(cardId);
      if (_selectedCardId == cardId) {
        _selectedCardId = null;
      }
      notifyListeners();
    } catch (e) {
      debugPrint('Error deleting content card: $e');
    }
  }

  void selectCard(String cardId) {
    _selectedCardId = cardId;
    _isInsideCard = true;
    notifyListeners();
  }

  // Topics Methods
  Future<void> addTopic(
      TopicEntity topic, String sessionId, String userId) async {
    try {
      await _topicUsesCases.addTopic(topic, sessionId, userId);
      final list = _topicsByCardId[topic.cardId] ?? [];
      _topicsByCardId[topic.cardId] = [...list, topic];
      notifyListeners();
    } catch (e) {
      debugPrint('Error adding topic: $e');
    }
  }

  Future<void> updateTopic(
      TopicEntity topic, String sessionId, String userId) async {
    try {
      await _topicUsesCases.updateTopic(topic, sessionId, userId);
      final list = _topicsByCardId[topic.cardId] ?? [];
      final index = list.indexWhere((t) => t.id == topic.id);
      if (index != -1) {
        list[index] = topic;
        _topicsByCardId[topic.cardId] = List.from(list);
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error updating topic: $e');
    }
  }

  Future<void> deleteTopic(
      String topicId, String cardId, String sessionId, String userId) async {
    try {
      await _topicUsesCases.deleteTopic(topicId, sessionId, userId);
      final list = _topicsByCardId[cardId] ?? [];
      _topicsByCardId[cardId] = list.where((t) => t.id != topicId).toList();
      notifyListeners();
    } catch (e) {
      debugPrint('Error deleting topic: $e');
    }
  }

  // Utility Methods
  void clearSelection() {
    _selectedCardId = null;
    _isInsideCard = false;
    notifyListeners();
  }

  void clearAll() {
    _contentCards.clear();
    _topicsByCardId.clear();
    _selectedWebsiteId = null;
    _selectedCardId = null;
    _isLoadingCards = false;
    _isLoadingTopics = false;
    notifyListeners();
  }

  // Method to add data from website inspection
  Future<void> addInspectedData(
    InspectedWebsiteEntity inspectedWebsite,
    String sessionId,
    String userId,
  ) async {
    try {
      // Add all content cards from inspection
      for (final card in inspectedWebsite.contentCards) {
        await addContentCard(card, sessionId, userId);
      }

      // Generate and add topics for each card
      for (final card in inspectedWebsite.contentCards) {
        final topics = _generateTopicsForCard(card.id);
        for (final topic in topics) {
          await addTopic(topic, sessionId, userId);
        }
      }

      debugPrint(
          'Successfully added ${inspectedWebsite.contentCards.length} cards and their topics from inspection');
    } catch (e) {
      debugPrint('Error adding inspected data: $e');
    }
  }

  // Helper method to generate dummy topics for a card
  List<TopicEntity> _generateTopicsForCard(String cardId) {
    final topics = [
      TopicEntity(
        id: 'topic_${cardId}_1',
        cardId: cardId,
        keyWord: 'SEO optimization',
        date: DateTime.now().toIso8601String(),
        status: TopicStatus.covered,
        position: 1,
        volume: 1200,
        score: '85',
        words: '1500',
      ),
      TopicEntity(
        id: 'topic_${cardId}_2',
        cardId: cardId,
        keyWord: 'Content strategy',
        date: DateTime.now().toIso8601String(),
        status: TopicStatus.draft,
        position: 3,
        volume: 800,
        score: '72',
        words: '1200',
      ),
      TopicEntity(
        id: 'topic_${cardId}_3',
        cardId: cardId,
        keyWord: 'Keyword research',
        date: DateTime.now().toIso8601String(),
        status: TopicStatus.initiated,
        position: 5,
        volume: 1500,
        score: '90',
        words: '2000',
      ),
    ];
    return topics;
  }
}
