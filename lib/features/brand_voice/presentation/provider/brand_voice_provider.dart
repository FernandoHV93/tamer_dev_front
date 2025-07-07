import 'package:flutter/material.dart';

enum BrandVoiceMethod { deep, contentAnalysis }

enum ContentAnalysisStep { options, upload, paste }

class BrandVoice {
  final String brandName;
  final String toneOfVoice;
  final List<String> keyValues;
  final String targetAudience;

  BrandVoice({
    required this.brandName,
    required this.toneOfVoice,
    required this.keyValues,
    required this.targetAudience,
  });
}

class BrandVoiceProvider extends ChangeNotifier {
  BrandVoiceMethod _selectedMethod = BrandVoiceMethod.deep;
  ContentAnalysisStep _contentAnalysisStep = ContentAnalysisStep.options;

  // Nueva lista de brands
  final List<BrandVoice> _savedBrands = [];
  List<BrandVoice> get savedBrands => List.unmodifiable(_savedBrands);

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

  // Métodos para brands
  void addBrand(BrandVoice brand) {
    _savedBrands.add(brand);
    notifyListeners();
  }

  void removeBrand(BrandVoice brand) {
    _savedBrands.remove(brand);
    notifyListeners();
  }

  void updateBrand(int index, BrandVoice updated) {
    if (index >= 0 && index < _savedBrands.length) {
      _savedBrands[index] = updated;
      notifyListeners();
    }
  }
}
