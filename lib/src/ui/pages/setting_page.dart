import 'package:flutter/material.dart';
import '../../core/controllers/app_state_manager.dart';
import '../../core/enums/theme_type.dart';
import '../../utils/custom_widgets/init_widget.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  static const String routeName = '/SettingPage';
  const SettingPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    AppStateManager appStateManager = Provider.of<AppStateManager>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('SettingPage'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text('language'),
              trailing: Text(appStateManager.appLanguage),
              onTap: () {
                try {
                  appStateManager.setAppLanguage('en');
                  InitWidget.restartApp(context);
                } catch (err) {
                  debugPrint(err.toString());
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text('Theme'),
              trailing: Text(appStateManager.appThemeType.value),
              onTap: () {
                try {
                  if (appStateManager.appThemeType == ThemeType.light) {
                    appStateManager.setAppTheme(ThemeType.dark);
                  } else {
                    appStateManager.setAppTheme(ThemeType.light);
                  }
                } catch (err) {
                  debugPrint(err.toString());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
