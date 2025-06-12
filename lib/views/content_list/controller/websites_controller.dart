import 'package:flutter/foundation.dart';
import 'package:ia_web_front/data/models/website_model.dart';
import 'package:ia_web_front/domain/use_cases/content_list/contenlist_usescases.dart';

class WebsiteController extends ChangeNotifier {
  final ContentListUseCases useCases;

  WebsiteController(this.useCases);

  List<Website> _websites = [];
  bool _isLoading = false;

  List<InspectedWebsite> _inspectedWebsites = [];
  List<CompetitorWebsiteAnalysis> _competitorwebsites = [];

  List<Website> get websites => _websites;
  List<InspectedWebsite> get inspectedWebsites => _inspectedWebsites;
  List<CompetitorWebsiteAnalysis> get competitorwebsite => _competitorwebsites;
  bool get isLoading => _isLoading;

  Website? _currentWebsite;
  Website? get selectedWebsite => _currentWebsite;

  ContentCardModel? _selectedContentCard;
  ContentCardModel? get selectedContentCard => _selectedContentCard;

  void selectContentCard(ContentCardModel contentCard) {
    _selectedContentCard = contentCard;
    notifyListeners();
  }

  void selectWebsite(String websiteName) {
    _currentWebsite = _websites.firstWhere(
      (website) => website.name == websiteName,
    );
    _selectedContentCard = _currentWebsite?.contentCards?.isNotEmpty == true
        ? _currentWebsite!.contentCards!.first
        : null;
    notifyListeners();
  }

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

  void removeWebsite(int index) {
    if (index >= 0 && index < _websites.length) {
      _websites.removeAt(index);
      notifyListeners();
    }
  }

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

  void addContentCard(ContentCardModel contentCard, Website? selectedWebsite) {
    if (selectedWebsite != null) {
      final updatedContentCards = [
        ...?selectedWebsite.contentCards,
        contentCard
      ];
      final websiteIndex = _websites.indexOf(selectedWebsite);
      if (websiteIndex != -1) {
        _websites[websiteIndex] =
            selectedWebsite.copyWith(contentCards: updatedContentCards);
        _currentWebsite = _websites[websiteIndex];
      }
    } else if (_currentWebsite != null) {
      final updatedContentCards = [
        ...?_currentWebsite!.contentCards,
        contentCard
      ];
      final currentWebsiteIndex = _websites.indexOf(_currentWebsite!);
      if (currentWebsiteIndex != -1) {
        _websites[currentWebsiteIndex] =
            _currentWebsite!.copyWith(contentCards: updatedContentCards);
        _currentWebsite = _websites[currentWebsiteIndex];
      }
    }
    notifyListeners();
  }

  void removeContentCard(int contentCardIndex) {
    if (_currentWebsite != null) {
      final updatedContentCards = [...?_currentWebsite!.contentCards];
      if (contentCardIndex >= 0 &&
          contentCardIndex < updatedContentCards.length) {
        updatedContentCards.removeAt(contentCardIndex);
        _currentWebsite =
            _currentWebsite!.copyWith(contentCards: updatedContentCards);

        final websiteIndex = _websites
            .indexWhere((website) => website.name == _currentWebsite!.name);
        if (websiteIndex != -1) {
          _websites[websiteIndex] = _currentWebsite!;
        }
        notifyListeners();
      }
    }
  }

  void editContentCard(
      int contentCardIndex, String newTitle, Website newWebsite) {
    if (_currentWebsite != null) {
      final updatedContentCards = [...?_currentWebsite!.contentCards];
      if (contentCardIndex >= 0 &&
          contentCardIndex < updatedContentCards.length) {
        updatedContentCards[contentCardIndex] =
            updatedContentCards[contentCardIndex].copyWith(
          title: newTitle,
        );

        if (_currentWebsite!.name != newWebsite.name) {
          final newWebsiteIndex = _websites.indexOf(newWebsite);
          if (newWebsiteIndex != -1) {
            final updatedNewWebsiteCards = [
              ...?newWebsite.contentCards,
              updatedContentCards[contentCardIndex]
            ];
            _websites[newWebsiteIndex] =
                newWebsite.copyWith(contentCards: updatedNewWebsiteCards);

            // Elimina la tarjeta del website actual
            updatedContentCards.removeAt(contentCardIndex);
          }
        }

        // Actualiza el estado del website actual
        _currentWebsite =
            _currentWebsite!.copyWith(contentCards: updatedContentCards);

        // Actualiza el estado global de _websites
        final currentWebsiteIndex = _websites
            .indexWhere((website) => website.name == _currentWebsite!.name);
        if (currentWebsiteIndex != -1) {
          _websites[currentWebsiteIndex] = _currentWebsite!;
        }

        notifyListeners();
      }
    }
  }

  void addTopic(int contentCardIndex, Topics topic) {
    if (_currentWebsite != null) {
      final contentCards = [...?_currentWebsite!.contentCards];
      if (contentCardIndex >= 0 && contentCardIndex < contentCards.length) {
        final contentCard = contentCards[contentCardIndex];
        final updatedTopics = [...?contentCard.topics, topic];
        contentCards[contentCardIndex] =
            contentCard.copyWith(topics: updatedTopics);
        _selectedContentCard = contentCards[contentCardIndex];
        _currentWebsite = _currentWebsite!.copyWith(contentCards: contentCards);

        final websiteIndex = _websites
            .indexWhere((website) => website.name == _currentWebsite!.name);
        if (websiteIndex != -1) {
          _websites[websiteIndex] = _currentWebsite!;
        }

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
          _selectedContentCard = contentCards[contentCardIndex];
          _currentWebsite =
              _currentWebsite!.copyWith(contentCards: contentCards);

          final websiteIndex = _websites
              .indexWhere((website) => website.name == _currentWebsite!.name);
          if (websiteIndex != -1) {
            _websites[websiteIndex] = _currentWebsite!;
          }
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
              volume: updatedTopic.volume,
              position: updatedTopic.position);
          contentCards[contentCardIndex] =
              contentCard.copyWith(topics: updatedTopics);
          _currentWebsite =
              _currentWebsite!.copyWith(contentCards: contentCards);
          notifyListeners();
        }
      }
    }
  }

  Future<void> websiteInspection(
      String sessionId, String userId, Website website) async {
    try {
      final result = await useCases.inspectWebsite(sessionId, userId, website);

      if (result.containsKey('inspectedWebsite') &&
          result['inspectedWebsite'] != null) {
        final inspectedWebsiteData = result['inspectedWebsite'];

        final inspectedWebsite = InspectedWebsite.fromMap(inspectedWebsiteData);

        _inspectedWebsites
            .removeWhere((w) => w.website.url == inspectedWebsite.website.url);
        _inspectedWebsites.add(inspectedWebsite);
        notifyListeners();
      } else {
        print("Error: inspectedWebsite no está presente o es nulo.");
      }
    } catch (e) {
      print("Error inspecting website: $e");
    }
  }

  Future<void> analyzeCompetitor(
      String sessionId, String userId, Website website) async {
    try {
      final result =
          await useCases.analyzeCompetitor(sessionId, userId, website);

      final competitor =
          CompetitorWebsiteAnalysis.fromMap(result['competitor']);
      _competitorwebsites.add(competitor);

      notifyListeners();
    } catch (e) {
      print("Error analyzing competitor: $e");
    }
  }

  Future<void> loadWebsites(String sessionId, String userId) async {
    _isLoading = true;
    try {
      final result = await useCases.loadWebsites(sessionId, userId);
      _websites =
          (result['websites'] as List).map((e) => Website.fromMap(e)).toList();
    } catch (e) {
      print("Error loading websites: $e");
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> saveWebsitesData(String sessionId, String userId) async {
    try {
      await useCases.saveWebsitesData(sessionId, userId, _websites);
    } catch (e) {
      print("Error saving websites: $e");
    }
  }
}
