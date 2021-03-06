import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../locator.dart';
import '../../core/controllers/app_state_manager.dart';

import 'custom_exception.dart';
import 'internet_provider.dart';

class GlobalApi {
  static const String basicUrl = 'https://woo.kuarkz.com';
  static const String apiUrl = '/wp-json/wc/v3/';
  static const String imagePreviewUrl = basicUrl + '/api/services/previewimage/';
  static const String downloadUrl = basicUrl + '/api/services/Download/';

  late InternetProvider internetProvider;

  String username = 'ck_84635d48e593ff12e14d7e58f94b2aa9104c95e2';
  String password = 'cs_7450af5e57d0ef5ffaf56743563fc0605b5d34a9';
  final String contentType;
  final String? acceptLanguage;

  late Map<String, String> apiHeaders;

  GlobalApi({this.contentType = 'application/json', this.acceptLanguage}) {
    internetProvider = InternetProvider();
    getHeaders();
  }

  Map<String, String> getHeaders({String? contentType}) {
    apiHeaders = {};
    apiHeaders['Content-Type'] = contentType ?? this.contentType;
    apiHeaders['Accept-Language'] = locator<AppStateManager>().appLanguage;

    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));
    apiHeaders['authorization'] = basicAuth;

    return apiHeaders;
  }

  Future<dynamic> postRequest(String subUrl, dynamic body, {Map<String, String>? headers}) async {
    // if (subUrl != '/connect/token') await locator<AuthenticationService>().checkAuthorizationToken();
    String url = getFullUrl(subUrl);
    try {
      final httpResponse = await internetProvider.postRequest(url, body, headers: headers ?? apiHeaders);
      return _responseHandel(httpResponse, url: url);
    } catch (err) {
      rethrow;
    }
  }

  Future<dynamic> getRequest(String subUrl, {Map<String, String>? headers}) async {
    // if (subUrl != '/connect/token') await locator<AuthenticationService>().checkAuthorizationToken();
    String url = getFullUrl(subUrl);
    try {
      final httpResponse = await internetProvider.getRequest(url, headers: headers ?? apiHeaders);
      return _responseHandel(httpResponse, url: url);
    } catch (err) {
      rethrow;
    }
  }

  String getFullUrl(String subUrl) => basicUrl + apiUrl + subUrl;

  dynamic _responseHandel(http.Response response, {String url = ''}) {
    try {
      if (response.statusCode.toString().startsWith('2')) {
        return json.decode(response.body);
      } else {
        var res = json.decode(response.body);
        debugPrint('///////////////// apiResponse.getErrorsString :' + response.body);
        throw CustomException(res['message'], res['data']['status']);
      }
    } catch (err) {
      debugPrint(err.toString());
      rethrow;
    }
  }
}
