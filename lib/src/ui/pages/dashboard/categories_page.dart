import 'package:flutter/material.dart';
import 'package:news_app/src/config/constants/constants.dart';
import 'package:news_app/src/config/themes/app_theme.dart';
import 'package:news_app/src/config/themes/colors.dart';
import 'package:news_app/src/core/controllers/category_provider.dart';
import 'package:news_app/src/core/models/category_model.dart';
import 'package:news_app/src/ui/pages/dashboard/add_category_page.dart';
import 'package:news_app/src/utils/custom_widgets/messages.dart';
import 'package:provider/provider.dart';
import '../../../../main_imports.dart';

class CategoriesPage extends StatefulWidget {
  static const String routeName = '/CategoriesPage';
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  late CategoryProvider categoryProvider;
  @override
  Widget build(BuildContext context) {
    categoryProvider = Provider.of<CategoryProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: SafeArea(
        child: ListView(
          padding: AppTheme.standardPadding,
          children: categoryProvider.dataList
              .map(
                (e) => Card(
                  child: ListTile(
                    leading: e.image == null ? Image.asset(kNoImage) : Image.memory(e.image!.bytes),
                    title: Text(e.name ?? ''),
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
                                categoryProvider.delete(e);
                              },
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.edit_outlined, color: kGreen),
                          onPressed: () async {
                            await context.navigateName(AddCategoryPage.routeName, data: e);
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
        onPressed: () => context.navigateName(AddCategoryPage.routeName, data: CategoryModel()),
      ),
    );
  }
}
