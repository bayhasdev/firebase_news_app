import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../locator.dart';
import '../../config/constants/shard_preference_kay.dart';
import '../../utils/providers/sol_api.dart';
import '../models/authorization_model.dart';
import '../models/base_provider.dart';
import '../models/user_model.dart';

class AuthenticationService extends BaseProvider {
  final SolApi _api = locator<SolApi>();
  AuthorizationModel? _authorizationModel;

  UserModel? _user;

  UserModel get user => _user!;
  set user(UserModel? user) {
    _user = user;
    notifyListeners();
  }

  bool isLogin() {
    return _user != null;
  }

  Future<void> login(String email, String password) async {
    try {
      Map<String, String> body = {"grant_type": "password", "username": email, "password": password, "scope": "offline_access"};
      Map<String, String> headers = _api.getHeaders(contentType: 'application/x-www-form-urlencoded');

      debugPrint(headers.toString());
      var data = await _api.postRequest('/connect/token', body, headers: headers);
      _authorizationModel = AuthorizationModel.fromJson(data);
      saveAuthorizationData();
      // _api.accessToken = _authorizationModel.accessToken;
      await getUserData();
    } catch (err) {
      rethrow;
    }
  }

  Future getUserData() async {
    var data = await _api.getRequest("/api/v1/account");
    user = data['user'] != null ? UserModel.fromJson(data['user']) : null;
  }

  Future<void> getAuthorizationData() async {
    try {
      if (_authorizationModel == null) {
        final prefs = await SharedPreferences.getInstance();
        if (prefs.containsKey(authorizationKey)) {
          final authorizationData = json.decode(prefs.getString(authorizationKey)!) as Map<String, Object>;
          _authorizationModel = AuthorizationModel.fromJson(authorizationData);
          // _api.accessToken = _authorizationModel.accessToken;
        }
      }
    } catch (error) {
      rethrow;
    }
  }

  void saveAuthorizationData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(authorizationKey, json.encode(_authorizationModel!.toJson()));
  }

  Future<void> checkAuthorizationToken() async {
    // log('/////////////////////////////////////////////////////////////// check Authorization ');
    await getAuthorizationData();
    try {
      if (_authorizationModel != null && _authorizationModel!.accessToken!.isNotEmpty) {
        Duration diff = DateTime.parse(_authorizationModel!.expiresIn!).difference(DateTime.now());
        // log('///////// _authorization.expiresIn : ${_authorization.expiresIn} ');
        //log('///////// diff.inMinutes : ${diff.inMinutes} ');
        // check if accessToken is valid more than 10 Minutes
        if (diff.isNegative || diff.inMinutes < 10) {
          //log('/////////////////////////////////////////////////////////////// Request refresh_token ');
          Map<String, String> body = {"grant_type": "refresh_token", "refresh_token": _authorizationModel!.refreshToken!};
          Map<String, String> headers = _api.getHeaders(contentType: 'application/x-www-form-urlencoded');

          var data = await _api.postRequest('/connect/token', body, headers: headers);
          //Request refresh_token response comes without refreshToken
          _authorizationModel = AuthorizationModel.fromJson(data)..refreshToken = _authorizationModel!.refreshToken;
          _api.accessToken = _authorizationModel?.accessToken!;
          saveAuthorizationData();
        }
      }
    } catch (error) {
      logOut();
      debugPrint(error.toString());
    }
  }

  void logOut() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(authorizationKey)) {
      prefs.remove(authorizationKey);
    }
    _user = null;
    _authorizationModel = null;
    _api.accessToken = null;
    notifyListeners();
  }
}
