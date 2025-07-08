import '../../domain/entities/brand_voice_entity.dart';
import '../../domain/repository/brand_voice_repository.dart';
import '../../domain/entities/deep_analysis_wizard_entity.dart';

class BrandVoiceRepositoryImpl implements BrandVoiceRepository {
  final List<BrandVoice> _dummyBrands = [
    BrandVoice(
      id: '1',
      brandName: 'Acme Corp',
      toneOfVoice: 'Friendly',
      keyValues: ['Innovation', 'Trust'],
      targetAudience: 'Tech enthusiasts',
      brandIdentityInsights: 'Acme is known for its innovative products.',
    ),
    BrandVoice(
      id: '2',
      brandName: 'Globex',
      toneOfVoice: 'Professional',
      keyValues: ['Quality', 'Reliability'],
      targetAudience: 'Business clients',
      brandIdentityInsights: 'Globex delivers reliable solutions worldwide.',
    ),
  ];

  @override
  Future<List<BrandVoice>> loadBrands(String sessionId, String userId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List<BrandVoice>.from(_dummyBrands);
  }

  @override
  Future<BrandVoice> addBrand(
      String sessionId, String userId, BrandVoice brand) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final newBrand =
        brand.copyWith(id: DateTime.now().millisecondsSinceEpoch.toString());
    _dummyBrands.add(newBrand);
    return newBrand;
  }

  @override
  Future<void> deleteBrand(
      String sessionId, String userId, String brandId) async {
    await Future.delayed(const Duration(milliseconds: 150));
    _dummyBrands.removeWhere((b) => b.id == brandId);
  }

  @override
  Future<BrandVoice> updateBrand(
      String sessionId, String userId, BrandVoice brand) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final idx = _dummyBrands.indexWhere((b) => b.id == brand.id);
    if (idx != -1) {
      _dummyBrands[idx] = brand;
    }
    return brand;
  }

  @override
  Future<BrandVoice> generateBrandVoice(String sessionId, String userId,
      DeepAnalysisWizardEntity wizardEntity) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // Dummy mapping para demo
    return BrandVoice(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      brandName: wizardEntity.brandIdentitySection.vision.isNotEmpty
          ? wizardEntity.brandIdentitySection.vision
          : 'Generated Brand',
      toneOfVoice: wizardEntity.toneAndLanguageSection.tone.isNotEmpty
          ? wizardEntity.toneAndLanguageSection.tone
          : 'Professional',
      keyValues: [
        wizardEntity.fundamentalValuesSection.meaning,
        wizardEntity.fundamentalValuesSection.essential,
        wizardEntity.fundamentalValuesSection.convey,
      ].where((e) => e.isNotEmpty).toList(),
      targetAudience: wizardEntity.generalAudienceDataSection.occupation,
      brandIdentityInsights: wizardEntity.brandIdentitySection.impact,
    );
  }

  @override
  Future<BrandVoice> analyzeContentAndGenerateBrandVoice(
      String sessionId, String userId, String pastedText) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return BrandVoice(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      brandName: pastedText.isNotEmpty
          ? pastedText.substring(
              0, pastedText.length > 20 ? 20 : pastedText.length)
          : 'Analyzed Brand',
      toneOfVoice: 'Analyzed Tone',
      keyValues: ['Analyzed', 'From', 'Text'],
      targetAudience: 'Analyzed Audience',
      brandIdentityInsights: 'Insights generated from pasted text.',
    );
  }

  @override
  Future<BrandVoice> analyzeFileAndGenerateBrandVoice(
      String sessionId, String userId, String filePath) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final fileName = filePath.split('/').last;
    return BrandVoice(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      brandName: fileName,
      toneOfVoice: 'File Analyzed Tone',
      keyValues: ['File', 'Analyzed', 'Brand'],
      targetAudience: 'File Audience',
      brandIdentityInsights: 'Insights generated from file: $fileName',
    );
  }
}
