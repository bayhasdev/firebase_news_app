import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../main_imports.dart';
import '../../config/constants/constants.dart';
import '../../utils/custom_widgets/messages.dart';
import '../../utils/utilities/global_var.dart';
import 'main_page.dart';

class SplashPage extends StatefulWidget {
  static const String routeName = '/SplashPage';
  const SplashPage({Key? key}) : super(key: key);
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    super.initState();
    initAppState();
  }

  void initAppState() async {
    try {
      await Future.delayed(const Duration(milliseconds: 500)).then((value) => context.navigateToReset(MainPage.routeName));
    } catch (err) {
      showDialog(
        context: context,
        builder: (context) => CustomDialog(
          message: err.toString(),
          actions: <Widget>[
            TextButton(child: Text(str.main.cancel), onPressed: () => Navigator.pop(context)),
            TextButton(
              child: Text(str.main.retry),
              onPressed: () {
                Navigator.pop(context);
                initAppState();
              },
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: context.width * .8,
          height: context.width * .8,
          child: PhysicalModel(
            elevation: 20.0,
            shadowColor: Colors.blue,
            color: Colors.transparent,
            child: Image.asset(kLogo),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }
}
