import '../entities/brand_voice_entity.dart';
import '../entities/deep_analysis_wizard_entity.dart';

abstract class BrandVoiceRepository {
  Future<List<BrandVoice>> loadBrands(String sessionId, String userId);
  Future<BrandVoice> addBrand(
      String sessionId, String userId, BrandVoice brand);
  Future<void> deleteBrand(String sessionId, String userId, String brandId);
  Future<BrandVoice> updateBrand(
      String sessionId, String userId, BrandVoice brand);
  Future<BrandVoice> generateBrandVoice(
      String sessionId, String userId, DeepAnalysisWizardEntity wizardEntity);
  Future<BrandVoice> analyzeContentAndGenerateBrandVoice(
      String sessionId, String userId, String pastedText);
  Future<BrandVoice> analyzeFileAndGenerateBrandVoice(
      String sessionId, String userId, String filePath);
  Future<BrandVoice> analyzeFileBytesAndGenerateBrandVoice(
      String sessionId, String userId, List<int> bytes, String fileName);
}
