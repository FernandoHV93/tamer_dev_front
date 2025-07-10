import '../../domain/repository/api_settings_repository.dart';
import 'package:ia_web_front/core/api/backend_urls.dart';
import 'package:ia_web_front/core/api/api.dart';

class ApiSettingsRepositoryImpl implements ApiSettingsRepository {
  @override
  Future<Map<String, bool>> getProvidersStatus(
      {required String sessionId, required String userId}) async {
    final response = await api.get(
      BackendUrls.apiProvidersStatus,
      {
        'session_id': sessionId,
        'user_id': userId,
      },
    );
    print(response);
    if (response['error'] != null) {
      throw Exception('Failed to load AI providers status');
    }
    return Map<String, bool>.from(response);
  }

  @override
  Future<bool> connectProvider(
      {required String sessionId,
      required String userId,
      required String apiKey,
      required String providerName}) async {
    final response = await api.post(
      BackendUrls.connectApiProvider,
      {
        'sessionId': sessionId,
        'userID': userId,
        'apiKey': apiKey,
        'providerName': providerName,
      },
    );
    if (response['error'] != null) {
      throw Exception('Failed to connect AI provider');
    }
    return response['connected'] == true;
  }

  @override
  Future<bool> disconnectProvider(
      {required String sessionId,
      required String userId,
      required String providerName}) async {
    final response = await api.post(
      BackendUrls.disconnectApiProvider,
      {
        'sessionId': sessionId,
        'userID': userId,
        'providerName': providerName,
      },
    );
    if (response['error'] != null) {
      throw Exception('Failed to disconnect AI provider');
    }
    return response['disconnected'] == true;
  }
}
