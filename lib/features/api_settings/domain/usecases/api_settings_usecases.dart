import '../repository/api_settings_repository.dart';

class ApiSettingsUseCases {
  final ApiSettingsRepository repository;
  ApiSettingsUseCases(this.repository);

  Future<Map<String, bool>> getProvidersStatus(
      {required String sessionId, required String userId}) {
    return repository.getProvidersStatus(sessionId: sessionId, userId: userId);
  }

  Future<bool> connectProvider({
    required String sessionId,
    required String userId,
    required String apiKey,
    required String providerName,
  }) {
    return repository.connectProvider(
      sessionId: sessionId,
      userId: userId,
      apiKey: apiKey,
      providerName: providerName,
    );
  }

  Future<bool> disconnectProvider({
    required String sessionId,
    required String userId,
    required String providerName,
  }) {
    return repository.disconnectProvider(
      sessionId: sessionId,
      userId: userId,
      providerName: providerName,
    );
  }
}
