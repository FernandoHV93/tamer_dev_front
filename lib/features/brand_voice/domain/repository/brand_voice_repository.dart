import '../entities/brand_voice_entity.dart';

abstract class BrandVoiceRepository {
  Future<List<BrandVoice>> loadBrands(String sessionId, String userId);
  Future<BrandVoice> addBrand(
      String sessionId, String userId, BrandVoice brand);
  Future<void> deleteBrand(String sessionId, String userId, String brandId);
  Future<BrandVoice> updateBrand(
      String sessionId, String userId, BrandVoice brand);
}
