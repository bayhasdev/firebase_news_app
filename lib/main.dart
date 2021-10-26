import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:news_app/src/utils/utilities/global_var.dart';
import 'package:provider/provider.dart';

import 'src/core/controllers/app_state_manager.dart';
import 'locale_delegate.dart';
import 'locator.dart';
import 'src/config/constants/constants.dart';
import 'src/config/routes/route_generator.dart';
import 'src/config/routes/routes.dart';
import 'src/core/controllers/app_provider_root_widget.dart';
import 'src/ui/pages/splash_page.dart';
import 'src/utils/custom_widgets/init_widget.dart';
import '../../../main_imports.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized: Ensure that plugin services are initialized
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  await locator<AppStateManager>().initializAppState();
  runApp(
    const AppProviderRootWidget(
      child: InitWidget(
        child: AppRootWidget(),
      ),
    ),
  );
}

class AppRootWidget extends StatefulWidget {
  const AppRootWidget({Key? key}) : super(key: key);

  @override
  State<AppRootWidget> createState() => _AppRootWidgetState();
}

class _AppRootWidgetState extends State<AppRootWidget> {
  late AppStateManager appStateManager;

  @override
  Widget build(BuildContext context) {
    log('**************************************** AppRootWidget.build');
    final appStateManager = Provider.of<AppStateManager>(context);

    return MaterialApp(
      title: kAppName,
      localizationsDelegates: const [
        LocalDelegate(),
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],

      supportedLocales: LocalDelegate.supportedLocales,
      // Returns a locale which will be used by the app
      localeResolutionCallback: (locale, supportedLocales) {
        if (appStateManager.appLanguage.isNotEmpty) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == appStateManager.appLanguage) return supportedLocale;
          }
        }
        // If the locale of the device is not supported, use the first one
        // from the list (English, in this case).
        return supportedLocales.first;
      },

      theme: appStateManager.getAppThemeData(),

      debugShowCheckedModeBanner: false,

      home: const MyApp(),

      // Initially display FirstPage
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      routes: appRoutes,
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static const String routeName = '/';
  @override
  Widget build(BuildContext context) {
    str = context.str!;
    return const SplashPage();
    // return GlobalVar.appFirstLunch ? ChangeNotifierProvider(create: (context) => SetupWizardNotifier(), child: SetupWizardPage()) : SplashPage();
  }
}
