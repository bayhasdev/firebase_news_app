import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../core/controllers/app_state_manager.dart';
import '../../../locator.dart';
import '../../core/services/authentication_service.dart';
import 'custom_exception.dart';
import 'internet_provider.dart';
import 'sol_api_response.dart';

class SolApi {
  static const String apiUrl = 'https://new.syr-aw.com';
  static const String imagePreviewUrl = apiUrl + '/api/services/previewimage/';
  static const String downloadUrl = apiUrl + '/api/services/Download/';

  late InternetProvider internetProvider;

  String? accessToken;
  final String contentType;
  final String acceptLanguage;

  late Map<String, String> apiHeaders;

  SolApi({this.accessToken, this.contentType = 'application/json', this.acceptLanguage = '*'}) {
    internetProvider = InternetProvider();
    getHeaders();
  }

  Map<String, String> getHeaders({String? contentType}) {
    apiHeaders = {};
    apiHeaders['Content-Type'] = contentType ?? this.contentType;
    apiHeaders['Accept-Language'] = locator<AppStateManager>().appLanguage;
    if (accessToken != null) apiHeaders['authorization'] = 'Bearer $accessToken';

    return apiHeaders;
  }

  Future<dynamic> postRequest(String subUrl, dynamic body, {Map<String, String>? headers}) async {
    if (subUrl != '/connect/token') await locator<AuthenticationService>().checkAuthorizationToken();
    String url = getFullUrl(subUrl);
    try {
      final httpResponse = await internetProvider.postRequest(url, body, headers: headers ?? getHeaders());
      return _responseHandel(httpResponse, url: url);
    } catch (err) {
      rethrow;
    }
  }

  Future<dynamic> getRequest(String subUrl, {Map<String, String>? headers}) async {
    if (subUrl != '/connect/token') await locator<AuthenticationService>().checkAuthorizationToken();
    String url = getFullUrl(subUrl);
    try {
      final httpResponse = await internetProvider.getRequest(url, headers: headers ?? getHeaders());
      return _responseHandel(httpResponse, url: url);
    } catch (err) {
      rethrow;
    }
  }

  String getFullUrl(String subUrl) => apiUrl + subUrl;

  dynamic _responseHandel(http.Response response, {String url = ''}) {
    try {
      var responseJson = json.decode(response.body);
      SolApiResponse apiResponse = SolApiResponse();
      apiResponse.fromJson(responseJson);
      // print('apiResponse.data :' + apiResponse.data.toString());
      if (!apiResponse.success) {
        debugPrint('///////////////// apiResponse.getErrorsString :' + apiResponse.getErrorsString());
        throw FetchDataException(apiResponse.getErrorsString());
      }
      return apiResponse.data;
    } catch (err) {
      debugPrint(err.toString());
      rethrow;
    }
  }
}
