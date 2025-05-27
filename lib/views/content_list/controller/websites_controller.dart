import 'package:flutter/foundation.dart';
import 'package:ia_web_front/data/models/website_model.dart';

class WebsiteController extends ChangeNotifier {
  List<Website> _websites = [];

  List<Website> get websites => _websites;

  Website? _currentWebsite;
  Website? get selectedWebsite => _currentWebsite;

  void selectWebsite(String websiteName) {
    _currentWebsite = _websites.firstWhere(
      (website) => website.name == websiteName,
    );
    print('Sitio web seleccionado: ${_currentWebsite?.name}');
    notifyListeners();
  }

  // Operación: Añadir nuevo website
  void addWebsite(String name, String url, WebsiteStatus status) {
    final newWebsite = Website(
      status: status,
      url: url,
      name: name,
      lastChecked: DateTime.now(),
    );

    _websites.add(newWebsite);
    notifyListeners();
  }

  // Operación: Eliminar website
  void removeWebsite(int index) {
    if (index >= 0 && index < _websites.length) {
      _websites.removeAt(index);
      notifyListeners();
    }
  }

  // Operación: Cambiar estado
  void toggleStatus(int index) {
    if (index >= 0 && index < _websites.length) {
      final website = _websites[index];
      _websites[index] = website.copyWith(
        status: website.status == WebsiteStatus.Active
            ? WebsiteStatus.Inactive
            : WebsiteStatus.Active,
      );
      notifyListeners();
    }
  }

  // Operación: Editar website
  void editWebsite(
      int index, String newName, String newUrl, WebsiteStatus status) {
    if (index >= 0 && index < _websites.length) {
      _websites[index] = _websites[index].copyWith(
        name: newName,
        url: newUrl,
        lastChecked: DateTime.now(),
        status: status,
      );
      notifyListeners();
    }
  }

  // -------------------- Métodos para ContentCardModel --------------------

  void addContentCard(ContentCardModel contentCard) {
    if (_currentWebsite != null) {
      final updatedContentCards = [
        ...?_currentWebsite!.contentCards,
        contentCard
      ];
      _currentWebsite =
          _currentWebsite!.copyWith(contentCards: updatedContentCards);
      notifyListeners();
    }
  }

  void removeContentCard(int contentCardIndex) {
    if (_currentWebsite != null) {
      final updatedContentCards = [...?_currentWebsite!.contentCards];
      if (contentCardIndex >= 0 &&
          contentCardIndex < updatedContentCards.length) {
        updatedContentCards.removeAt(contentCardIndex);
        _currentWebsite =
            _currentWebsite!.copyWith(contentCards: updatedContentCards);
        notifyListeners();
      }
    }
  }

  void editContentCard(int contentCardIndex, ContentCardModel updatedCard) {
    if (_currentWebsite != null) {
      final updatedContentCards = [...?_currentWebsite!.contentCards];
      if (contentCardIndex >= 0 &&
          contentCardIndex < updatedContentCards.length) {
        updatedContentCards[contentCardIndex] =
            updatedContentCards[contentCardIndex].copyWith(
          title: updatedCard.title,
          volume: updatedCard.volume,
          keyWordsScore: updatedCard.keyWordsScore,
          topics: updatedCard.topics,
        );
        _currentWebsite =
            _currentWebsite!.copyWith(contentCards: updatedContentCards);
        notifyListeners();
      }
    }
  }

  // -------------------- Métodos para Topics --------------------

  void addTopic(int contentCardIndex, Topics topic) {
    if (_currentWebsite != null) {
      final contentCards = [...?_currentWebsite!.contentCards];
      if (contentCardIndex >= 0 && contentCardIndex < contentCards.length) {
        final contentCard = contentCards[contentCardIndex];
        final updatedTopics = [...?contentCard.topics, topic];
        contentCards[contentCardIndex] =
            contentCard.copyWith(topics: updatedTopics);
        _currentWebsite = _currentWebsite!.copyWith(contentCards: contentCards);
        notifyListeners();
      }
    }
  }

  void removeTopic(int contentCardIndex, int topicIndex) {
    if (_currentWebsite != null) {
      final contentCards = [...?_currentWebsite!.contentCards];
      if (contentCardIndex >= 0 && contentCardIndex < contentCards.length) {
        final contentCard = contentCards[contentCardIndex];
        final updatedTopics = [...?contentCard.topics];
        if (topicIndex >= 0 && topicIndex < updatedTopics.length) {
          updatedTopics.removeAt(topicIndex);
          contentCards[contentCardIndex] =
              contentCard.copyWith(topics: updatedTopics);
          _currentWebsite =
              _currentWebsite!.copyWith(contentCards: contentCards);
          notifyListeners();
        }
      }
    }
  }

  void editTopic(int contentCardIndex, int topicIndex, Topics updatedTopic) {
    if (_currentWebsite != null) {
      final contentCards = [...?_currentWebsite!.contentCards];
      if (contentCardIndex >= 0 && contentCardIndex < contentCards.length) {
        final contentCard = contentCards[contentCardIndex];
        final updatedTopics = [...?contentCard.topics];
        if (topicIndex >= 0 && topicIndex < updatedTopics.length) {
          updatedTopics[topicIndex] = updatedTopics[topicIndex].copyWith(
            keyWord: updatedTopic.keyWord,
            date: updatedTopic.date,
            score: updatedTopic.score,
            words: updatedTopic.words,
            schemas: updatedTopic.schemas,
            status: updatedTopic.status,
          );
          contentCards[contentCardIndex] =
              contentCard.copyWith(topics: updatedTopics);
          _currentWebsite =
              _currentWebsite!.copyWith(contentCards: contentCards);
          notifyListeners();
        }
      }
    }
  }

  // (Opcional) Cargar datos iniciales
  void loadDemoWebsites() {
    _websites = [
      Website(
        status: WebsiteStatus.Active,
        name: 'Mi Blog',
        url: 'https://midominio.com',
        lastChecked: DateTime.now(),
        contentCards: [
          ContentCardModel(
            title: 'Card 1 - Mi Blog',
            volume: 100,
            keyWordsScore: 80,
            topics: [
              Topics(
                keyWord: 'Flutter',
                date: '2023-05-01',
                score: '90',
                words: '500',
                schemas: 'Schema 1',
                status: TopicStatus.Covered,
              ),
              Topics(
                keyWord: 'Dart',
                date: '2023-05-02',
                score: '85',
                words: '400',
                schemas: 'Schema 2',
                status: TopicStatus.Draft,
              ),
            ],
          ),
          ContentCardModel(
            title: 'Card 2 - Mi Blog',
            volume: 200,
            keyWordsScore: 70,
            topics: [
              Topics(
                keyWord: 'State Management',
                date: '2023-05-03',
                score: '75',
                words: '600',
                schemas: 'Schema 3',
                status: TopicStatus.Initiated,
              ),
            ],
          ),
          ContentCardModel(
            title: 'Card 2 - Mi Blog',
            volume: 200,
            keyWordsScore: 70,
            topics: [
              Topics(
                keyWord: 'State Management',
                date: '2023-05-03',
                score: '75',
                words: '600',
                schemas: 'Schema 3',
                status: TopicStatus.Initiated,
              ),
            ],
          ),
          ContentCardModel(
            title: 'Card 2 - Mi Blog',
            volume: 200,
            keyWordsScore: 70,
            topics: [
              Topics(
                keyWord: 'State Management',
                date: '2023-05-03',
                score: '75',
                words: '600',
                schemas: 'Schema 3',
                status: TopicStatus.Initiated,
              ),
            ],
          ),
        ],
      ),
      Website(
        status: WebsiteStatus.Inactive,
        name: 'Tienda Online',
        url: 'https://tienda.com',
        lastChecked: DateTime.now().subtract(const Duration(days: 7)),
        contentCards: [
          ContentCardModel(
            title: 'Card 1 - Tienda Online',
            volume: 150,
            keyWordsScore: 65,
            topics: [
              Topics(
                keyWord: 'E-commerce',
                date: '2023-05-04',
                score: '80',
                words: '700',
                schemas: 'Schema 4',
                status: TopicStatus.Covered,
              ),
            ],
          ),
        ],
      ),
    ];
    notifyListeners();
  }
}
