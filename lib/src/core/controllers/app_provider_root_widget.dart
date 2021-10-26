import 'package:flutter/material.dart';
import '../../../locator.dart';
import 'app_state_manager.dart';
import 'category_provider.dart';
import 'article_provider.dart';
import 'package:provider/provider.dart';

class AppProviderRootWidget extends StatelessWidget {
  final Widget child;
  const AppProviderRootWidget({required this.child, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => locator<AppStateManager>()),
        ChangeNotifierProvider(create: (ctx) => locator<CategoryProvider>()),
        ChangeNotifierProvider(create: (ctx) => locator<ArticleProvider>()),
        // ChangeNotifierProvider(create: (context) => DrawerProvider()),
      ],
      child: child,
    );
  }
}
