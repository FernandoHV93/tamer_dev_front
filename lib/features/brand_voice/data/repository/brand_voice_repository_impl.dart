import '../../domain/entities/brand_voice_entity.dart';
import '../../domain/repository/brand_voice_repository.dart';

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
}
