import '../entities/brand_voice_entity.dart';
import '../repository/brand_voice_repository.dart';

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
}
