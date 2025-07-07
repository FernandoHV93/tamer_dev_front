import 'package:flutter/material.dart';
import '../../domain/entities/brand_voice_entity.dart';
import '../../domain/usecases/brand_voice_usecases.dart';

enum BrandVoiceMethod { deep, contentAnalysis }

enum ContentAnalysisStep { options, upload, paste }

class BrandVoiceProvider extends ChangeNotifier {
  BrandVoiceMethod _selectedMethod = BrandVoiceMethod.deep;
  ContentAnalysisStep _contentAnalysisStep = ContentAnalysisStep.options;

  // Nueva lista de brands
  final List<BrandVoice> _savedBrands = [];
  List<BrandVoice> get savedBrands => List.unmodifiable(_savedBrands);

  final BrandVoiceUseCases useCases;
  BrandVoiceProvider(this.useCases);

  // Feedback visual
  bool _isLoading = false;
  String? _error;
  bool get isLoading => _isLoading;
  String? get error => _error;

  BrandVoiceMethod get selectedMethod => _selectedMethod;
  ContentAnalysisStep get contentAnalysisStep => _contentAnalysisStep;

  void selectMethod(BrandVoiceMethod method) {
    _selectedMethod = method;
    // Reset step al cambiar de método
    if (method == BrandVoiceMethod.contentAnalysis) {
      _contentAnalysisStep = ContentAnalysisStep.options;
    }
    notifyListeners();
  }

  void goToUpload() {
    _contentAnalysisStep = ContentAnalysisStep.upload;
    notifyListeners();
  }

  void goToPaste() {
    _contentAnalysisStep = ContentAnalysisStep.paste;
    notifyListeners();
  }

  void goBackToOptions() {
    _contentAnalysisStep = ContentAnalysisStep.options;
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? value) {
    _error = value;
    notifyListeners();
  }

  Future<void> loadBrands(String sessionId, String userId) async {
    _setLoading(true);
    _setError(null);
    try {
      final brands = await useCases.loadBrands(sessionId, userId);
      _savedBrands
        ..clear()
        ..addAll(brands);
    } catch (e) {
      _setError('Error loading brands: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
    notifyListeners();
  }

  Future<void> addBrand(
      String sessionId, String userId, BrandVoice brand) async {
    _setLoading(true);
    _setError(null);
    try {
      final created = await useCases.addBrand(sessionId, userId, brand);
      _savedBrands.add(created);
      notifyListeners();
      await loadBrands(sessionId, userId);
    } catch (e) {
      _setError('Error adding brand: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> deleteBrand(
      String sessionId, String userId, String brandId) async {
    _setLoading(true);
    _setError(null);
    try {
      await useCases.deleteBrand(sessionId, userId, brandId);
      _savedBrands.removeWhere((b) => b.id == brandId);
      notifyListeners();
      await loadBrands(sessionId, userId);
    } catch (e) {
      _setError('Error deleting brand: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> updateBrand(
      String sessionId, String userId, BrandVoice brand) async {
    _setLoading(true);
    _setError(null);
    try {
      final updated = await useCases.updateBrand(sessionId, userId, brand);
      final idx = _savedBrands.indexWhere((b) => b.id == brand.id);
      if (idx != -1) {
        _savedBrands[idx] = updated;
        notifyListeners();
      }
      await loadBrands(sessionId, userId);
    } catch (e) {
      _setError('Error updating brand: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }
}
