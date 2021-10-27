import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:news_app/src/ui/pages/article_details_page.dart';
import 'package:news_app/src/ui/pages/dashboard/add_article_page.dart';
import 'package:news_app/src/ui/pages/dashboard/add_category_page.dart';

import '../../../main.dart';
import '../../../src/utils/custom_widgets/image_slider_page.dart';
import '../../../src/utils/custom_widgets/image_view_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final dynamic args = settings.arguments;
    log('settings.name:${settings.name}');
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const MyApp());

      case AddCategoryPage.routeName:
        return MaterialPageRoute(builder: (_) => AddCategoryPage(args));

      case AddArticlePage.routeName:
        return MaterialPageRoute(builder: (_) => AddArticlePage(args));

      case ArticleDetailsPage.routeName:
        return MaterialPageRoute(builder: (_) => ArticleDetailsPage(args));

      ////////////////{ image Route } ////////////////
      case ImageViewPage.routeName:
        return MaterialPageRoute(builder: (_) => ImageViewPage(image: args));

      case ImageSliderPage.routeName:
        if (args is List) return MaterialPageRoute(builder: (_) => ImageSliderPage(args[0], cuurentActiveItem: args[1]));
        return _errorRoute();

      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(appBar: AppBar(title: const Text('Error!')), body: const Center(child: Text('Route Page Error')));
    });
  }
}
