import 'package:flutter/material.dart';
import 'package:ia_web_front/features/content/domain/entities/inspected_website_entity.dart';
import 'package:ia_web_front/features/content/domain/uses_cases/inspect_website_usecase.dart';
import 'package:ia_web_front/features/websites/domain/entities/website_entity.dart';
import 'package:ia_web_front/features/content/presentation/controller/content_provider.dart';

class PerformanceProvider extends ChangeNotifier {
  final InspectWebsiteUseCase inspectWebsiteUseCase;
  final ContentProvider contentProvider;

  PerformanceProvider(this.inspectWebsiteUseCase, this.contentProvider);

  bool _isLoading = false;
  String? _error;
  final List<InspectedWebsiteEntity> _inspectedWebsites = [];

  bool get isLoading => _isLoading;
  String? get error => _error;
  List<InspectedWebsiteEntity> get inspectedWebsites =>
      List.unmodifiable(_inspectedWebsites);

  Future<void> inspectWebsite(
      WebsiteEntity website, String sessionId, String userId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final inspected = await inspectWebsiteUseCase(website, sessionId, userId);
      _inspectedWebsites.add(inspected);

      // Automatically add the inspected data to ContentProvider
      await contentProvider.addInspectedData(inspected, sessionId, userId);

      debugPrint(
          'Website inspection completed and data added to content provider');
    } catch (e) {
      _error = e.toString();
      debugPrint('Error during website inspection: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clear() {
    _inspectedWebsites.clear();
    _error = null;
    notifyListeners();
  }
}
