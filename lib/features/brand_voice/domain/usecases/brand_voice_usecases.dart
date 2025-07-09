import '../entities/brand_voice_entity.dart';
import '../repository/brand_voice_repository.dart';
import '../entities/deep_analysis_wizard_entity.dart';

class BrandVoiceUseCases {
  final BrandVoiceRepository repository;
  BrandVoiceUseCases(this.repository);

  Future<List<BrandVoice>> loadBrands(String sessionId, String userId) {
    return repository.loadBrands(sessionId, userId);
  }

  Future<BrandVoice> addBrand(
      String sessionId, String userId, BrandVoice brand) {
    return repository.addBrand(sessionId, userId, brand);
  }

  Future<void> deleteBrand(String sessionId, String userId, String brandId) {
    return repository.deleteBrand(sessionId, userId, brandId);
  }

  Future<BrandVoice> updateBrand(
      String sessionId, String userId, BrandVoice brand) {
    return repository.updateBrand(sessionId, userId, brand);
  }

  Future<BrandVoice> generateBrandVoice(
      String sessionId, String userId, DeepAnalysisWizardEntity wizardEntity) {
    return repository.generateBrandVoice(sessionId, userId, wizardEntity);
  }

  Future<BrandVoice> analyzeContentAndGenerateBrandVoice(
      String sessionId, String userId, String pastedText) {
    return repository.analyzeContentAndGenerateBrandVoice(
        sessionId, userId, pastedText);
  }

  Future<BrandVoice> analyzeFileAndGenerateBrandVoice(
      String sessionId, String userId, String filePath) {
    return repository.analyzeFileAndGenerateBrandVoice(
        sessionId, userId, filePath);
  }

  Future<BrandVoice> analyzeFileBytesAndGenerateBrandVoice(
      String sessionId, String userId, List<int> bytes, String fileName) {
    return repository.analyzeFileBytesAndGenerateBrandVoice(
        sessionId, userId, bytes, fileName);
  }
}
