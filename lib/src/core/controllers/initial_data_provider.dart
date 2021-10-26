import 'package:flutter/material.dart';

import '../../../locator.dart';
import '../../utils/providers/sol_api.dart';
import '../models/base_provider.dart';
import '../models/user_model.dart';
import '../services/authentication_service.dart';

class InitialDataProvider extends BaseProvider {
  final SolApi _api = locator<SolApi>();

  Future<void> getInitData() async {
    const String url = "/api/v1/account";
    try {
      var data = await _api.getRequest(url);
      debugPrint(data.toString());

      locator<AuthenticationService>().user = data['user'] != null ? UserModel.fromJson(data['user']) : null;
    } catch (error) {
      rethrow;
    }
  }
}
