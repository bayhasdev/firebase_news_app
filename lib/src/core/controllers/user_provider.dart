import '../../../locator.dart';
import '../enums/viewstate.dart';
import '../models/base_provider.dart';
import '../services/authentication_service.dart';

class UserProvider extends BaseProvider {
  AuthenticationService authenticationService = locator<AuthenticationService>();

  Future<void> login(String email, String password) async {
    try {
      setState(ViewState.busy);
      await authenticationService.login(email, password);
    } catch (err) {
      setState(ViewState.idle);
      rethrow;
    }
    setState(ViewState.idle);
  }
}
