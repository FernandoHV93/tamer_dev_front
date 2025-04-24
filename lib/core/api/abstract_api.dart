abstract interface class POST {
  Future<Map<String, dynamic>> post(String url, Map<String, dynamic> data);
}

abstract interface class GET {
  Future<Map<String, dynamic>> get(String url);
}

abstract interface class DELETE {
  Future<Map<String, dynamic>> delete(String url);
}

abstract interface class PUT {
  Future<Map<String, dynamic>> put(String url, Map<String, dynamic> data);
}

abstract interface class PATCH {
  Future<Map<String, dynamic>> patch(String url, Map<String, dynamic> data);
}
