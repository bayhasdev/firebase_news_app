import 'package:flutter/material.dart';
import 'package:news_app/src/config/themes/app_theme.dart';
import 'package:news_app/src/ui/pages/dashboard/articles_page.dart';
import 'package:news_app/src/ui/pages/dashboard/categories_page.dart';
import '../../../../main_imports.dart';

class DashboardPage extends StatelessWidget {
  static const String routeName = '/DashboardPage';

  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Page'),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Card(
              margin: AppTheme.standardPadding,
              child: InkWell(
                onTap: () => context.navigateName(CategoriesPage.routeName),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Center(
                    child: Text(
                      'categories',
                      style: context.textTheme.headline3,
                    ),
                  ),
                ),
              ),
            ),
            Card(
              margin: AppTheme.standardPadding,
              child: InkWell(
                onTap: () => context.navigateName(ArticlesPage.routeName),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Center(
                    child: Text(
                      'Articles',
                      style: context.textTheme.headline3,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
