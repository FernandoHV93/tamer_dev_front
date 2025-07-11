import 'package:flutter/foundation.dart';
import 'package:ia_web_front/features/websites/domain/entities/website_entity.dart';
import 'package:ia_web_front/features/websites/domain/uses_cases/website_uses_cases.dart';

class WebsitesProvider extends ChangeNotifier {
  final WebsiteUseCases useCases;

  WebsitesProvider(this.useCases);

  List<WebsiteEntity> _websites = [];
  bool _isLoading = false;
  WebsiteEntity? _selectedWebsite;
  String? _error;

  List<WebsiteEntity> get websites => _websites;
  bool get isLoading => _isLoading;
  WebsiteEntity? get selectedWebsite => _selectedWebsite;
  String? get error => _error;

  void _setError(String? value) {
    _error = value;
    notifyListeners();
  }

  void clearError() {
    _setError(null);
  }

  void selectWebsite(String websiteId) {
    _selectedWebsite = _websites.firstWhere(
      (website) => website.id == websiteId,
      orElse: () => _websites.first,
    );
    notifyListeners();
  }

  Future<void> addWebsite(String name, String url, WebsiteStatus status,
      String sessionId, String userId) async {
    _setLoading(true);
    _setError(null);
    try {
      final newWebsite = WebsiteEntity(
        id: '',
        status: status,
        url: url,
        name: name,
        lastChecked: DateTime.now(),
      );

      final savedWebsite =
          await useCases.saveWebsite(sessionId, userId, newWebsite);

      _websites.add(savedWebsite);

      await refreshWebsites(sessionId, userId);

      _setLoading(false);
      notifyListeners();
    } catch (e) {
      _setLoading(false);
      _setError('Error adding website: ${e.toString()}');
      notifyListeners();
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
    _setLoading(true);
    _setError(null);
    final index = _websites.indexWhere((website) => website.id == websiteId);
    if (index != -1) {
      final updatedWebsite = _websites[index].copyWith(
        name: newName,
        url: newUrl,
        lastChecked: DateTime.now(),
        status: status,
      );

      try {
        await useCases.updateWebsite(sessionId, userId, updatedWebsite);

        await refreshWebsites(sessionId, userId);

        _setLoading(false);
        notifyListeners();
      } catch (e) {
        _setLoading(false);
        _setError('Error updating website: ${e.toString()}');
        notifyListeners();
      }
    }
  }

  Future<void> refreshWebsites(String sessionId, String userId) async {
    await loadWebsites(sessionId, userId);
  }

  Future<void> loadWebsites(String sessionId, String userId) async {
    _isLoading = true;
    _setError(null);
    notifyListeners();

    try {
      _websites = await useCases.loadWebsites(sessionId, userId);
      if (_websites.isNotEmpty && _selectedWebsite == null) {
        _selectedWebsite = _websites.first;
      }
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _setError('Error loading websites: ${e.toString()}');
      notifyListeners();
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> saveWebsite(
      String sessionId, String userId, WebsiteEntity website) async {
    _setLoading(true);
    _setError(null);
    try {
      final savedWebsite =
          await useCases.saveWebsite(sessionId, userId, website);
      // Añadir el website devuelto por el backend a la lista local
      _websites.add(savedWebsite);
      notifyListeners();
      // Luego refrescar desde el backend para asegurar sincronización
      await refreshWebsites(sessionId, userId);
      _setLoading(false);
      notifyListeners();
    } catch (e) {
      _setLoading(false);
      _setError('Error saving website: ${e.toString()}');
      notifyListeners();
    }
  }

  Future<void> updateWebsite(
      String sessionId, String userId, WebsiteEntity website) async {
    _setLoading(true);
    _setError(null);
    try {
      await useCases.updateWebsite(sessionId, userId, website);
      _setLoading(false);
      notifyListeners();
    } catch (e) {
      _setLoading(false);
      _setError('Error updating website: ${e.toString()}');
      notifyListeners();
    }
  }

  Future<void> deleteWebsite(
      String sessionId, String userId, String websiteId) async {
    _setLoading(true);
    _setError(null);
    try {
      await useCases.deleteWebsite(sessionId, userId, websiteId);
      // Recargamos desde el backend para asegurar sincronización
      await refreshWebsites(sessionId, userId);
      _setLoading(false);
      notifyListeners();
    } catch (e) {
      _setLoading(false);
      _setError('Error deleting website: ${e.toString()}');
      notifyListeners();
    }
  }

  Future<void> saveWebsitesData(String sessionId, String userId) async {
    _setLoading(true);
    _setError(null);
    try {
      await useCases.saveWebsitesData(sessionId, userId, _websites);
      _setLoading(false);
      notifyListeners();
    } catch (e) {
      _setLoading(false);
      _setError('Error saving websites data: ${e.toString()}');
      notifyListeners();
    }
  }
}
