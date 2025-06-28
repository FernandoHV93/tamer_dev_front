import 'package:flutter/foundation.dart';
import 'package:ia_web_front/features/websites/domain/entities/website_entity.dart';
import 'package:ia_web_front/features/websites/domain/uses_cases/website_uses_cases.dart';

class WebsitesProvider extends ChangeNotifier {
  final WebsiteUseCases useCases;

  WebsitesProvider(this.useCases);

  List<WebsiteEntity> _websites = [];
  bool _isLoading = false;
  WebsiteEntity? _selectedWebsite;

  List<WebsiteEntity> get websites => _websites;
  bool get isLoading => _isLoading;
  WebsiteEntity? get selectedWebsite => _selectedWebsite;

  void selectWebsite(String websiteId) {
    _selectedWebsite = _websites.firstWhere(
      (website) => website.id == websiteId,
      orElse: () => _websites.first,
    );
    notifyListeners();
  }

  Future<void> addWebsite(String name, String url, WebsiteStatus status,
      String sessionId, String userId) async {
    final newWebsite = WebsiteEntity(
      id: DateTime.now()
          .millisecondsSinceEpoch
          .toString(), // Temporal ID generation
      status: status,
      url: url,
      name: name,
      lastChecked: DateTime.now(),
    );

    try {
      // Primero guardamos en la capa de datos
      await useCases.saveWebsite(sessionId, userId, newWebsite);

      // Si se guardó exitosamente, agregamos a la lista local
      _websites.add(newWebsite);
      notifyListeners();

      print("Website added successfully: ${newWebsite.name}");
    } catch (e) {
      print("Error adding website: $e");
      rethrow;
    }
  }

  void removeWebsite(String websiteId) {
    _websites.removeWhere((website) => website.id == websiteId);
    if (_selectedWebsite?.id == websiteId) {
      _selectedWebsite = _websites.isNotEmpty ? _websites.first : null;
    }
    notifyListeners();
  }

  void toggleStatus(String websiteId) {
    final index = _websites.indexWhere((website) => website.id == websiteId);
    if (index != -1) {
      final website = _websites[index];
      _websites[index] = website.copyWith(
        status: website.status == WebsiteStatus.Active
            ? WebsiteStatus.Inactive
            : WebsiteStatus.Active,
      );
      notifyListeners();
    }
  }

  Future<void> editWebsite(String websiteId, String newName, String newUrl,
      WebsiteStatus status, String sessionId, String userId) async {
    final index = _websites.indexWhere((website) => website.id == websiteId);
    if (index != -1) {
      final updatedWebsite = _websites[index].copyWith(
        name: newName,
        url: newUrl,
        lastChecked: DateTime.now(),
        status: status,
      );

      try {
        // Primero actualizamos en la capa de datos
        await useCases.updateWebsite(sessionId, userId, updatedWebsite);

        // Si se actualizó exitosamente, actualizamos la lista local
        _websites[index] = updatedWebsite;
        notifyListeners();

        print("Website updated successfully: ${updatedWebsite.name}");
      } catch (e) {
        print("Error updating website: $e");
        rethrow;
      }
    }
  }

  Future<void> loadWebsites(String sessionId, String userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _websites = await useCases.loadWebsites(sessionId, userId);
      if (_websites.isNotEmpty && _selectedWebsite == null) {
        _selectedWebsite = _websites.first;
      }
    } catch (e) {
      print("Error loading websites: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> saveWebsite(
      String sessionId, String userId, WebsiteEntity website) async {
    try {
      await useCases.saveWebsite(sessionId, userId, website);
    } catch (e) {
      print("Error saving website: $e");
      rethrow;
    }
  }

  Future<void> updateWebsite(
      String sessionId, String userId, WebsiteEntity website) async {
    try {
      await useCases.updateWebsite(sessionId, userId, website);
    } catch (e) {
      print("Error updating website: $e");
      rethrow;
    }
  }

  Future<void> deleteWebsite(
      String sessionId, String userId, String websiteId) async {
    try {
      await useCases.deleteWebsite(sessionId, userId, websiteId);
      removeWebsite(websiteId);
    } catch (e) {
      print("Error deleting website: $e");
      rethrow;
    }
  }

  Future<void> saveWebsitesData(String sessionId, String userId) async {
    try {
      await useCases.saveWebsitesData(sessionId, userId, _websites);
    } catch (e) {
      print("Error saving websites data: $e");
      rethrow;
    }
  }
}
