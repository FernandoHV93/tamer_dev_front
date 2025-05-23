import 'package:flutter/foundation.dart';
import 'package:ia_web_front/data/models/website_model.dart';

class WebsiteController extends ChangeNotifier {
  List<Website> _websites = [];

  List<Website> get websites => _websites;

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

  // (Opcional) Cargar datos iniciales
  void loadDemoWebsites() {
    _websites = [
      Website(
        status: WebsiteStatus.Active,
        name: 'Mi Blog',
        url: 'https://midominio.com',
        lastChecked: DateTime.now(),
      ),
      Website(
        status: WebsiteStatus.Inactive,
        name: 'Tienda Online',
        url: 'https://tienda.com',
        lastChecked: DateTime.now().subtract(const Duration(days: 7)),
      ),
    ];
    notifyListeners();
  }
}
