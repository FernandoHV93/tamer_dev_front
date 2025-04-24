import 'dart:convert';

import 'package:http/http.dart' as HTTP;

import 'package:ia_web_front/core/api/abstract_api.dart';
import 'package:ia_web_front/core/api/backend_urls.dart';

class API implements PUT, GET, DELETE, POST {
  const API(
      {required this.ApiProviderGET,
      required this.ApiProviderPOST,
      required this.ApiProviderPUT,
      required this.ApiProviderDELETE,
      required this.ApiProviderPATCH});

  final ApiProviderGET;
  final ApiProviderPOST;
  final ApiProviderPUT;
  final ApiProviderDELETE;
  final ApiProviderPATCH;

  @override
  Future<Map<String, dynamic>> delete(String url) async {
    var uri = Uri.parse(BackendUrls.baseUrl + url);
    final response = await ApiProviderDELETE(uri);
    if (response.statusCode != 200) return {'error': response.statusCode};
    return json.decode(response.body);
  }

  @override
  Future<Map<String, dynamic>> get(String url,
      {Map<String, dynamic>? queryParams}) async {
    var uri = Uri.parse(BackendUrls.baseUrl + url);
    if (queryParams != null) {
      uri = uri.replace(queryParameters: queryParams);
    }
    final response = await ApiProviderGET(uri);
    if (response.statusCode != 200) return {'error': response.statusCode};
    return json.decode(response.body);
  }

  @override
  Future<Map<String, dynamic>> put(
      String url, Map<String, dynamic> data) async {
    var uri = Uri.parse(BackendUrls.baseUrl + url);
    final response = await ApiProviderPUT(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(data),
    );
    if (response.statusCode != 200) return {'error': response.statusCode};
    return json.decode(response.body);
  }

  @override
  Future<Map<String, dynamic>> post(
      String url, Map<String, dynamic> data) async {
    var uri = Uri.parse(BackendUrls.baseUrl + url);
    final response = await ApiProviderPOST(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: data,
    );
    if (response.statusCode != 200) return {'error': response.statusCode};
    return json.decode(response.body);
  }

  Future<Map<String, dynamic>> patch(
      String url, Map<String, dynamic> data) async {
    var uri = Uri.parse(BackendUrls.baseUrl + url);
    final response = await ApiProviderPATCH(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(data),
    );
    if (response.statusCode != 200) return {'error': response.statusCode};
    return json.decode(response.body);
  }
}

class Endpoints {
  var api;
  late Function get;
  late Function post;
  late Function put;
  late Function delete;
  late Function patch;

  Endpoints() {
    Function GET = HTTP.get;
    Function POST = HTTP.post;
    Function PUT = HTTP.put;
    Function DELETE = HTTP.delete;
    Function PATCH = HTTP.patch;
    get = API(
            ApiProviderGET: GET,
            ApiProviderPOST: POST,
            ApiProviderPUT: PUT,
            ApiProviderDELETE: DELETE,
            ApiProviderPATCH: PATCH)
        .get;
    post = API(
            ApiProviderGET: GET,
            ApiProviderPOST: POST,
            ApiProviderPUT: PUT,
            ApiProviderDELETE: DELETE,
            ApiProviderPATCH: PATCH)
        .post;
    delete = API(
            ApiProviderGET: GET,
            ApiProviderPOST: POST,
            ApiProviderPUT: PUT,
            ApiProviderDELETE: DELETE,
            ApiProviderPATCH: PATCH)
        .delete;
    put = API(
            ApiProviderGET: GET,
            ApiProviderPOST: POST,
            ApiProviderPUT: PUT,
            ApiProviderDELETE: DELETE,
            ApiProviderPATCH: PATCH)
        .put;
    patch = API(
            ApiProviderGET: GET,
            ApiProviderPOST: POST,
            ApiProviderPUT: PUT,
            ApiProviderDELETE: DELETE,
            ApiProviderPATCH: PATCH)
        .patch;
  }
}

var api = Endpoints();
