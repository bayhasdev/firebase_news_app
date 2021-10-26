import 'package:flutter/material.dart';
import 'package:news_app/src/ui/pages/dashboard/articles_page.dart';
import 'package:news_app/src/ui/pages/dashboard/categories_page.dart';
import 'package:news_app/src/ui/pages/dashboard/dashboard_page.dart';
import '../../ui/pages/setting_page.dart';

import '../../ui/pages/main_page.dart';
import '../../ui/pages/splash_page.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  SplashPage.routeName: (ctx) => const SplashPage(),
  MainPage.routeName: (ctx) => const MainPage(),
  SettingPage.routeName: (ctx) => const SettingPage(),
  DashboardPage.routeName: (ctx) => const DashboardPage(),
  CategoriesPage.routeName: (ctx) => CategoriesPage(),
  ArticlesPage.routeName: (ctx) => ArticlesPage(),
};
