import 'package:flutter/material.dart';
import 'package:news_app/locator.dart';
import 'package:news_app/src/core/controllers/article_provider.dart';
import 'package:news_app/src/core/controllers/category_provider.dart';
import 'package:news_app/src/core/models/category_model.dart';
import 'package:news_app/src/ui/pages/dashboard/dashboard_page.dart';
import 'package:news_app/src/ui/widgets/article_widget.dart';
import 'package:news_app/src/ui/widgets/category_widget.dart';
import 'package:news_app/src/utils/custom_widgets/loading.dart';
import 'package:news_app/src/utils/utilities/global_var.dart';
import 'package:provider/provider.dart';
import 'setting_page.dart';
import '../../../main_imports.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  static const String routeName = '/MainPage';
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late CategoryProvider categoryProvider;
  late ArticleProvider articleProvider;
  CategoryModel? selectedCategory;

  @override
  void initState() {
    super.initState();
    locator<ArticleProvider>().loadPublicArtical(catId: selectedCategory?.id);
  }

  @override
  Widget build(BuildContext context) {
    categoryProvider = Provider.of<CategoryProvider>(context);
    articleProvider = Provider.of<ArticleProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Page'),
        actions: [
          IconButton(onPressed: () => context.navigateName(SettingPage.routeName), icon: const Icon(Icons.settings)),
          IconButton(onPressed: () => context.navigateName(DashboardPage.routeName), icon: const Icon(Icons.dashboard_outlined)),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => articleProvider.loadPublicArtical(catId: selectedCategory?.id),
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    context.addHeight(8),
                    if (GlobalVar.checkListNotEmpty(categoryProvider.dataList))
                      Card(
                        child: SizedBox(
                          height: 120,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: categoryProvider.dataList
                                .map((e) => CategorySingleItem(
                                      item: e,
                                      onTap: (item) {
                                        selectedCategory = item;
                                        articleProvider.loadPublicArtical(catId: selectedCategory?.id);
                                      },
                                    ))
                                .toList(),
                          ),
                        ),
                      ),
                    if (articleProvider.isBusy) LoadingWidget(),
                    ...articleProvider.publicArticalList.map((e) => ArticleSingleItem(e)).toList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
