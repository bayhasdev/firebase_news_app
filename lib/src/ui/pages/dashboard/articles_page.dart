import 'package:flutter/material.dart';
import 'package:news_app/locator.dart';
import 'package:news_app/src/config/themes/app_theme.dart';
import 'package:news_app/src/config/themes/colors.dart';
import 'package:news_app/src/core/controllers/article_provider.dart';
import 'package:news_app/src/core/models/article_model.dart';
import 'package:news_app/src/ui/pages/dashboard/add_article_page.dart';
import 'package:news_app/src/utils/custom_widgets/messages.dart';
import 'package:provider/provider.dart';
import '../../../../main_imports.dart';

class ArticlesPage extends StatefulWidget {
  static const String routeName = '/ArticlesPage';
  @override
  _ArticlesPageState createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> {
  late ArticleProvider articleProvider;

  @override
  void initState() {
    Future.microtask(() {
      locator<ArticleProvider>().loadArticles();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    articleProvider = Provider.of<ArticleProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Articles'),
      ),
      body: SafeArea(
        child: ListView(
          padding: AppTheme.standardPadding,
          children: articleProvider.dataList
              .map(
                (e) => Card(
                  child: ListTile(
                    title: Text(e.title ?? ''),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.delete, color: kRed),
                          onPressed: () {
                            DeleteConfermationDialog().delete(
                              context: context,
                              explainMsg: 'are you sure to DELETE?',
                              deleteFun: () async {
                                // categoryProvider.delete(e);
                              },
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.edit_outlined, color: kGreen),
                          onPressed: () async {
                            await context.navigateName(AddArticlePage.routeName, data: e);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => context.navigateName(AddArticlePage.routeName, data: ArticleModel()),
      ),
    );
  }
}
