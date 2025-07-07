import 'package:flutter/material.dart';
import 'brand_voice_provider.dart';

class BrandFormProvider extends ChangeNotifier {
  String _brandName = '';
  String _toneOfVoice = '';
  List<String> _keyValues = [];
  String _targetAudience = '';
  String _brandIdentityInsights = '';

  BrandVoice? _editingBrand;
  BrandVoice? get editingBrand => _editingBrand;
  bool get isEditing => _editingBrand != null;

  String get brandName => _brandName;
  String get toneOfVoice => _toneOfVoice;
  List<String> get keyValues => List.unmodifiable(_keyValues);
  String get targetAudience => _targetAudience;
  String get brandIdentityInsights => _brandIdentityInsights;

  bool get isFormValid =>
      _brandName.isNotEmpty &&
      _toneOfVoice.isNotEmpty &&
      _keyValues.isNotEmpty &&
      _targetAudience.isNotEmpty &&
      _brandIdentityInsights.isNotEmpty;

  void setBrandName(String value) {
    _brandName = value;
    notifyListeners();
  }

  void setToneOfVoice(String value) {
    _toneOfVoice = value;
    notifyListeners();
  }

  void addKeyValue(String value) {
    if (value.isNotEmpty && !_keyValues.contains(value)) {
      _keyValues.add(value);
      notifyListeners();
    }
  }

  void removeKeyValue(String value) {
    _keyValues.remove(value);
    notifyListeners();
  }

  void setTargetAudience(String value) {
    _targetAudience = value;
    notifyListeners();
  }

  void setBrandIdentityInsights(String value) {
    _brandIdentityInsights = value;
    notifyListeners();
  }

  void resetForm() {
    _brandName = '';
    _toneOfVoice = '';
    _keyValues.clear();
    _targetAudience = '';
    _brandIdentityInsights = '';
    _editingBrand = null;
    notifyListeners();
  }

  void setEditingBrand(BrandVoice brand) {
    _editingBrand = brand;
    _brandName = brand.brandName;
    _toneOfVoice = brand.toneOfVoice;
    _keyValues = List<String>.from(brand.keyValues);
    _targetAudience = brand.targetAudience;
    // _brandIdentityInsights = ''; // Si lo agregas al modelo, aquí lo asignas
    notifyListeners();
  }

  void saveEdit(BrandVoiceProvider brandProvider) {
    if (_editingBrand != null) {
      final index = brandProvider.savedBrands.indexOf(_editingBrand!);
      if (index != -1) {
        final updated = BrandVoice(
          brandName: _brandName,
          toneOfVoice: _toneOfVoice,
          keyValues: List<String>.from(_keyValues),
          targetAudience: _targetAudience,
        );
        brandProvider.updateBrand(index, updated);
      }
      resetForm();
    }
  }
}
