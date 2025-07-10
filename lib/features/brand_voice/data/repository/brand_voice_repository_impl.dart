import 'dart:convert';
import 'package:ia_web_front/core/api/api.dart';
import 'package:ia_web_front/core/api/backend_urls.dart';
import '../../domain/entities/brand_voice_entity.dart';
import '../../domain/repository/brand_voice_repository.dart';
import '../../domain/entities/deep_analysis_wizard_entity.dart';
import 'package:http/http.dart' as HTTP;

class BrandVoiceRepositoryImpl implements BrandVoiceRepository {
  // final List<BrandVoice> _dummyBrands = [
  //   BrandVoice(
  //     id: '1',
  //     brandName: 'Acme Corp',
  //     toneOfVoice: 'Friendly',
  //     keyValues: ['Innovation', 'Trust'],
  //     targetAudience: 'Tech enthusiasts',
  //     brandIdentityInsights: 'Acme is known for its innovative products.',
  //   ),
  //   BrandVoice(
  //     id: '2',
  //     brandName: 'Globex',
  //     toneOfVoice: 'Professional',
  //     keyValues: ['Quality', 'Reliability'],
  //     targetAudience: 'Business clients',
  //     brandIdentityInsights: 'Globex delivers reliable solutions worldwide.',
  //   ),
  // ];

  @override
  Future<List<BrandVoice>> loadBrands(String sessionId, String userId) async {
    try {
      final response = await api.get(
        BackendUrls.loadBrands,
        queryParams: {
          'sessionID': sessionId,
          'userID': userId,
        },
      );
      if (response['error'] != null) {
        throw Exception('Error loading brands: ${response['error']}');
      }
      final List<dynamic> brandsData =
          response is List ? response : (response['brands'] ?? []);
      return brandsData.map((data) => BrandVoice.fromJson(data)).toList();
    } catch (e, st) {
      print('Error in loadBrands: $e\n$st');
      rethrow;
    }
  }

  @override
  Future<BrandVoice> addBrand(
      String sessionId, String userId, BrandVoice brand) async {
    try {
      final body = {
        'sessionID': sessionId,
        'userID': userId,
        ...brand.toJson(),
      };
      final response = await api.post(
        BackendUrls.addBrand,
        body,
      );
      if (response['error'] != null) {
        throw Exception('Error adding brand: ${response['error']}');
      }
      return BrandVoice.fromJson(response);
    } catch (e, st) {
      print('Error in addBrand: $e\n$st');
      rethrow;
    }
  }

  @override
  Future<void> deleteBrand(
      String sessionId, String userId, String brandId) async {
    try {
      final response = await api.delete(
        BackendUrls.deleteBrand(brandId),
        headers: null,
      );
      if (response['error'] != null) {
        throw Exception('Error deleting brand: ${response['error']}');
      }
    } catch (e, st) {
      print('Error in deleteBrand: $e\n$st');
      rethrow;
    }
  }

  @override
  Future<BrandVoice> updateBrand(
      String sessionId, String userId, BrandVoice brand) async {
    try {
      final body = {
        'sessionID': sessionId,
        'userID': userId,
        ...brand.toJson(),
      };
      final response = await api.put(
        BackendUrls.updateBrand(brand.id),
        body,
      );
      if (response['error'] != null) {
        throw Exception('Error updating brand: ${response['error']}');
      }
      return BrandVoice.fromJson(response);
    } catch (e, st) {
      print('Error in updateBrand: $e\n$st');
      rethrow;
    }
  }

  @override
  Future<BrandVoice> generateBrandVoice(String sessionId, String userId,
      DeepAnalysisWizardEntity wizardEntity) async {
    try {
      final body = {
        'sessionID': sessionId,
        'userID': userId,
        ...wizardEntity.toJson(),
      };
      final response = await api.post(
        BackendUrls.generateBrandVoice,
        body,
      );
      if (response['error'] != null) {
        throw Exception('Error generating brand voice: ${response['error']}');
      }
      return BrandVoice.fromJson(response);
    } catch (e, st) {
      print('Error in generateBrandVoice: $e\n$st');
      rethrow;
    }
  }

  @override
  Future<BrandVoice> analyzeContentAndGenerateBrandVoice(
      String sessionId, String userId, String pastedText) async {
    try {
      final body = {
        'sessionID': sessionId,
        'userID': userId,
        'pastedText': pastedText,
      };
      final response = await api.post(
        BackendUrls.analyzeContentAndGenerateBrandVoice,
        body,
      );
      if (response['error'] != null) {
        throw Exception('Error analyzing content: ${response['error']}');
      }
      return BrandVoice.fromJson(response);
    } catch (e, st) {
      print('Error in analyzeContentAndGenerateBrandVoice: $e\n$st');
      rethrow;
    }
  }

  @override
  Future<BrandVoice> analyzeFileAndGenerateBrandVoice(
      String sessionId, String userId, String filePath) async {
    try {
      final body = {
        'sessionID': sessionId,
        'userID': userId,
        'filePath': filePath,
      };
      final response = await api.post(
        BackendUrls.analyzeFileAndGenerateBrandVoice,
        body,
      );
      if (response['error'] != null) {
        throw Exception('Error analyzing file: ${response['error']}');
      }
      return BrandVoice.fromJson(response);
    } catch (e, st) {
      print('Error in analyzeFileAndGenerateBrandVoice: $e\n$st');
      rethrow;
    }
  }

  @override
  Future<BrandVoice> analyzeFileBytesAndGenerateBrandVoice(
      String sessionId, String userId, List<int> bytes, String fileName) async {
    try {
      final uri = Uri.parse(BackendUrls.baseUrl +
          BackendUrls.analyzeFileBytesAndGenerateBrandVoice);
      final request = HTTP.MultipartRequest('POST', uri)
        ..fields['sessionID'] = sessionId
        ..fields['userID'] = userId
        ..fields['fileName'] = fileName
        ..files.add(
            HTTP.MultipartFile.fromBytes('file', bytes, filename: fileName));
      final streamedResponse = await request.send();
      final responseString = await streamedResponse.stream.bytesToString();
      if (streamedResponse.statusCode != 200) {
        throw Exception(
            'Error analyzing file bytes: ${streamedResponse.statusCode}');
      }
      final response = json.decode(responseString);
      if (response['error'] != null) {
        throw Exception('Error analyzing file bytes: ${response['error']}');
      }
      return BrandVoice.fromJson(response);
    } catch (e, st) {
      print('Error in analyzeFileBytesAndGenerateBrandVoice: $e\n$st');
      rethrow;
    }
  }
}
