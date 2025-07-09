import 'package:flutter/material.dart';
import '../../domain/entities/brand_voice_entity.dart';
import '../../domain/usecases/brand_voice_usecases.dart';

enum BrandVoiceMethod { deep, contentAnalysis }

enum ContentAnalysisStep { options, upload, paste }

class BrandVoiceProvider extends ChangeNotifier {
  BrandVoiceMethod? _selectedMethod;
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

  BrandVoiceMethod? get selectedMethod => _selectedMethod;
  ContentAnalysisStep get contentAnalysisStep => _contentAnalysisStep;

  void selectMethod(BrandVoiceMethod? method) {
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

  void setError(String? value) {
    _setError(value);
  }

  Future<void> loadBrands(String sessionId, String userId) async {
    _isLoading = true;
    _error = null;
    try {
      final brands = await useCases.loadBrands(sessionId, userId);
      _savedBrands
        ..clear()
        ..addAll(brands);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = 'Error loading brands: ${e.toString()}';
      notifyListeners();
    }
  }

  Future<void> addBrand(
      String sessionId, String userId, BrandVoice brand) async {
    _isLoading = true;
    _error = null;
    try {
      final created = await useCases.addBrand(sessionId, userId, brand);
      _savedBrands.add(created);
      await loadBrands(sessionId, userId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = 'Error adding brand: ${e.toString()}';
      notifyListeners();
    }
  }

  Future<void> deleteBrand(
      String sessionId, String userId, String brandId) async {
    _isLoading = true;
    _error = null;
    try {
      await useCases.deleteBrand(sessionId, userId, brandId);
      _savedBrands.removeWhere((b) => b.id == brandId);
      await loadBrands(sessionId, userId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = 'Error deleting brand: ${e.toString()}';
      notifyListeners();
    }
  }

  Future<void> updateBrand(
      String sessionId, String userId, BrandVoice brand) async {
    _isLoading = true;
    _error = null;
    try {
      final updated = await useCases.updateBrand(sessionId, userId, brand);
      final idx = _savedBrands.indexWhere((b) => b.id == brand.id);
      if (idx != -1) {
        _savedBrands[idx] = updated;
      }
      await loadBrands(sessionId, userId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = 'Error updating brand: ${e.toString()}';
      notifyListeners();
    }
  }

  Future<BrandVoice?> analyzeContentAndGenerateBrandVoice(
      String sessionId, String userId, String pastedText) async {
    _setLoading(true);
    _setError(null);
    try {
      final brandVoice = await useCases.analyzeContentAndGenerateBrandVoice(
        sessionId,
        userId,
        pastedText,
      );
      await addBrand(sessionId, userId, brandVoice);
      _setLoading(false);
      notifyListeners();
      return brandVoice;
    } catch (e) {
      _setLoading(false);
      _setError('Error analyzing content: [${e.toString()}');
      return null;
    }
  }

  Future<BrandVoice?> analyzeFileAndGenerateBrandVoice(
      String sessionId, String userId, String filePath) async {
    _setLoading(true);
    _setError(null);
    try {
      final brandVoice = await useCases.analyzeFileAndGenerateBrandVoice(
        sessionId,
        userId,
        filePath,
      );
      await addBrand(sessionId, userId, brandVoice);
      _setLoading(false);
      notifyListeners();
      return brandVoice;
    } catch (e) {
      _setLoading(false);
      _setError('Error analyzing file: [${e.toString()}');
      return null;
    }
  }

  Future<BrandVoice?> analyzeFileBytesAndGenerateBrandVoice(
      String sessionId, String userId, List<int> bytes, String fileName) async {
    _setLoading(true);
    _setError(null);
    try {
      final brandVoice = await useCases.analyzeFileBytesAndGenerateBrandVoice(
        sessionId,
        userId,
        bytes,
        fileName,
      );
      await addBrand(sessionId, userId, brandVoice);
      _setLoading(false);
      notifyListeners();
      return brandVoice;
    } catch (e) {
      _setLoading(false);
      _setError('Error analyzing file (web): [${e.toString()}');
      return null;
    }
  }
}
