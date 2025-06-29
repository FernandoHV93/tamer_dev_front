import 'package:ia_web_front/features/websites/domain/entities/website_entity.dart';
import 'package:ia_web_front/features/websites/domain/repository/website_repository.dart';

class WebsiteRepositoryImpl implements WebsiteRepository {
  // Variable para almacenar los datos dummy y poder ver los cambios
  List<WebsiteEntity> _dummyWebsites = [
    WebsiteEntity(
      id: '1',
      status: WebsiteStatus.Active,
      url: 'https://technews.com',
      name: 'Tech News',
      lastChecked: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    WebsiteEntity(
      id: '2',
      status: WebsiteStatus.Active,
      url: 'https://travelblog.org',
      name: 'World Travelers',
      lastChecked: DateTime.now().subtract(const Duration(days: 1)),
    ),
    WebsiteEntity(
      id: '3',
      status: WebsiteStatus.Inactive,
      url: 'https://foodrecipes.com',
      name: 'Culinary Delights',
      lastChecked: DateTime.now().subtract(const Duration(days: 3)),
    ),
    WebsiteEntity(
      id: '4',
      status: WebsiteStatus.Active,
      url: 'https://fitnesszone.com',
      name: 'Fitness Zone',
      lastChecked: DateTime.now().subtract(const Duration(hours: 6)),
    ),
  ];

  WebsiteRepositoryImpl();

  @override
  Future<List<WebsiteEntity>> loadWebsites(
      String sessionId, String userId) async {
    // Simulando delay de red
    await Future.delayed(const Duration(milliseconds: 500));
    print('Dummy: Loading ${_dummyWebsites.length} websites');

    // Retornamos una copia de la lista para evitar modificaciones directas
    return List.from(_dummyWebsites);
  }

  @override
  Future<void> saveWebsite(
      String sessionId, String userId, WebsiteEntity website) async {
    // Simulando delay de red
    await Future.delayed(const Duration(milliseconds: 300));
    print('Dummy: Saving website ${website.name}');

    // Agregamos el nuevo website a la lista dummy
    _dummyWebsites.add(website);
    print('Dummy: Total websites after save: ${_dummyWebsites.length}');
  }

  @override
  Future<void> updateWebsite(
      String sessionId, String userId, WebsiteEntity website) async {
    // Simulando delay de red
    await Future.delayed(const Duration(milliseconds: 300));
    print('Dummy: Updating website ${website.name}');

    // Actualizamos el website en la lista dummy
    final index = _dummyWebsites.indexWhere((w) => w.id == website.id);
    if (index != -1) {
      _dummyWebsites[index] = website;
      print('Dummy: Website updated successfully');
    } else {
      print('Dummy: Website not found for update');
    }
  }

  @override
  Future<void> deleteWebsite(
      String sessionId, String userId, String websiteId) async {
    // Simulando delay de red
    await Future.delayed(const Duration(milliseconds: 300));
    print('Dummy: Deleting website with ID $websiteId');

    // Eliminamos el website de la lista dummy
    _dummyWebsites.removeWhere((website) => website.id == websiteId);
    print('Dummy: Total websites after delete: ${_dummyWebsites.length}');
  }

  @override
  Future<void> saveWebsitesData(
      String sessionId, String userId, List<WebsiteEntity> websites) async {
    // Simulando delay de red
    await Future.delayed(const Duration(milliseconds: 500));
    print('Dummy: Saving ${websites.length} websites');

    // Actualizamos toda la lista dummy
    _dummyWebsites = List.from(websites);
    print('Dummy: Total websites after batch save: ${_dummyWebsites.length}');

    for (var website in websites) {
      print('  - ${website.name}: ${website.url}');
    }
  }

  // Método para debugging - ver el estado actual de los datos dummy
  void printCurrentWebsites() {
    print('=== Current Dummy Websites ===');
    for (var website in _dummyWebsites) {
      print(
          'ID: ${website.id}, Name: ${website.name}, Status: ${website.status}, URL: ${website.url}');
    }
    print('=============================');
  }
}
