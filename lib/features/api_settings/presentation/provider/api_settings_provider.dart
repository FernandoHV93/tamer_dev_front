import 'package:flutter/material.dart';
import '../../domain/usecases/api_settings_usecases.dart';

class ApiSettingsProvider extends ChangeNotifier {
  final ApiSettingsUseCases useCases;

  Map<String, bool> providersStatus = {};
  Map<String, String?> providerErrors = {};
  Map<String, bool> loadingByProvider = {};
  String? error;

  ApiSettingsProvider({required this.useCases});

  Future<void> loadProvidersStatus(String sessionId, String userId) async {
    error = null;
    notifyListeners();
    try {
      providersStatus = await useCases.getProvidersStatus(
          sessionId: sessionId, userId: userId);
    } catch (e) {
      error = e.toString();
    } finally {
      notifyListeners();
    }
  }

  Future<bool> connectProvider(String sessionId, String userId, String apiKey,
      String providerName) async {
    loadingByProvider[providerName] = true;
    error = null;
    notifyListeners();
    try {
      final result = await useCases.connectProvider(
        sessionId: sessionId,
        userId: userId,
        apiKey: apiKey,
        providerName: providerName,
      );
      if (result) {
        providersStatus[providerName] = true;
        providerErrors[providerName] = null;
      } else {
        providerErrors[providerName] =
            'Failed to connect. Please check your API key.';
      }
      return result;
    } catch (e) {
      providerErrors[providerName] = e.toString();
      return false;
    } finally {
      loadingByProvider[providerName] = false;
      notifyListeners();
    }
  }

  Future<bool> disconnectProvider(
      String sessionId, String userId, String providerName) async {
    loadingByProvider[providerName] = true;
    error = null;
    notifyListeners();
    try {
      final result = await useCases.disconnectProvider(
        sessionId: sessionId,
        userId: userId,
        providerName: providerName,
      );
      if (result) {
        providersStatus[providerName] = false;
        providerErrors[providerName] = null;
      } else {
        providerErrors[providerName] = 'Failed to disconnect.';
      }
      return result;
    } catch (e) {
      providerErrors[providerName] = e.toString();
      return false;
    } finally {
      loadingByProvider[providerName] = false;
      notifyListeners();
    }
  }
}
