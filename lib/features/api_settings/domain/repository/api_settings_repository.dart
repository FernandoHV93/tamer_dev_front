abstract class ApiSettingsRepository {
  Future<Map<String, bool>> getProvidersStatus(
      {required String sessionId, required String userId});
  Future<bool> connectProvider(
      {required String sessionId,
      required String userId,
      required String apiKey,
      required String providerName});
  Future<bool> disconnectProvider(
      {required String sessionId,
      required String userId,
      required String providerName});
}
