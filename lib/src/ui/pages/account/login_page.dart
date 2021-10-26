import 'package:flutter/material.dart';

import '../../../../main_imports.dart';
import '../../../config/constants/constants.dart';
import '../../../config/themes/app_theme.dart';
import '../../../core/controllers/user_provider.dart';
import '../../../core/enums/viewstate.dart';
import '../../../utils/custom_widgets/base_view.dart';
import '../../../utils/custom_widgets/button.dart';
import '../../../utils/custom_widgets/loading.dart';
import '../../../utils/custom_widgets/messages.dart';
import '../../../utils/custom_widgets/text_field.dart';
import '../../../utils/utilities/global_var.dart';
import '../../../utils/utilities/validation.dart';
import '../main_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static const String routeName = '/LoginPage';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String email = 'bayhas100sol@gmail.com', password = "";
  late UserProvider userProvider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BaseView<UserProvider>(
          modelProvider: UserProvider(),
          builder: (context, modelNotifier) {
            userProvider = modelNotifier;
            if (userProvider.state == ViewState.busy) {
              return const FullScreenLoading(inAsyncCall: true, child: SizedBox());
            } else {
              return ListView(
                padding: AppTheme.standardPadding,
                children: [
                  context.addHeight(context.width * .15),
                  Wrap(
                    spacing: 50.0,
                    verticalDirection: VerticalDirection.up,
                    alignment: WrapAlignment.spaceEvenly,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    runSpacing: context.width * .1,
                    children: [
                      Image.asset(kLogo, width: context.width * 0.7),
                      _formCard(),
                    ],
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget _formCard() {
    return SizedBox(
      width: context.width,
      child: Card(
        margin: AppTheme.standardPadding,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FittedBox(child: Text(str.formAndAction.logIn, style: context.textTheme.headline2)),
                context.addHeight(16),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: TextFormFieldWidget(
                    initialValue: email,
                    labelText: str.formAndAction.email,
                    validator: (val) => ValidationUtil.emailValidation(val, true),
                    onChanged: (val) => email = val,
                  ),
                ),
                context.addHeight(16),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: PasswordTextFormField(
                    initialValue: password,
                    keyboardType: TextInputType.visiblePassword,
                    labelText: str.formAndAction.password,
                    validator: (val) => ValidationUtil.stringLengthValidation(val, str.msg.passwordShort),
                    onChanged: (val) => password = val,
                  ),
                ),
                context.addHeight(24),
                ButtonWidget(text: str.formAndAction.logIn, onPressed: loginFun),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void loginFun() async {
    try {
      await userProvider.login(email, password);
      if (userProvider.authenticationService.isLogin()) context.navigateToReset(MainPage.routeName);
    } catch (err) {
      showDialog(context: context, builder: (context) => CustomDialog(message: err.toString()));
    }
  }
}
