import 'package:get_it/get_it.dart';
import 'package:news_app/src/core/controllers/category_provider.dart';
import 'package:news_app/src/core/controllers/article_provider.dart';

import 'src/core/controllers/app_state_manager.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => AppStateManager());
  locator.registerLazySingleton(() => CategoryProvider());
  locator.registerLazySingleton(() => ArticleProvider());
  // locator.registerLazySingleton(() => Api());
}
