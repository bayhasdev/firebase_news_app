import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:news_app/src/config/themes/app_theme.dart';
import 'package:news_app/src/core/controllers/article_provider.dart';
import 'package:news_app/src/core/controllers/category_provider.dart';
import 'package:news_app/src/core/models/article_model.dart';
import 'package:news_app/src/core/models/category_model.dart';
import 'package:news_app/src/utils/custom_widgets/button.dart';
import 'package:news_app/src/utils/custom_widgets/dropdown_widget.dart';
import 'package:news_app/src/utils/custom_widgets/loading.dart';
import 'package:news_app/src/utils/utilities/global_var.dart';
import 'package:provider/provider.dart';
import '../../../../main_imports.dart';

class AddArticlePage extends StatefulWidget {
  static const String routeName = '/AddArticlePage';
  final ArticleModel item;
  AddArticlePage(this.item);
  @override
  _AddArticlePageState createState() => _AddArticlePageState();
}

class _AddArticlePageState extends State<AddArticlePage> {
  @override
  Widget build(BuildContext context) {
    String title = widget.item.id == null ? str.main.add : str.formAndAction.update;
    ArticleProvider provider = Provider.of<ArticleProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('$title Article'),
      ),
      body: SafeArea(
        child: FullScreenLoading(
          inAsyncCall: provider.isBusy,
          child: ListView(
            padding: AppTheme.standardPadding,
            children: [
              TextFormField(
                initialValue: widget.item.title,
                keyboardType: TextInputType.name,
                decoration: AppTheme.getTextFieldDecoration(lable: str.formAndAction.title),
                onChanged: (value) {
                  widget.item.title = value;
                },
              ),
              context.addHeight(16),
              TextFormField(
                initialValue: widget.item.text,
                keyboardType: TextInputType.name,
                decoration: AppTheme.getTextFieldDecoration(lable: 'text'),
                onChanged: (value) {
                  widget.item.text = value;
                },
              ),
              context.addHeight(16),
              Consumer<CategoryProvider>(
                builder: (context, value, child) {
                  return DropDownWidget<CategoryModel>(
                    initValue: widget.item.id == null ? value.dataList.first : value.findLocal(widget.item.categoryId!),
                    hint: 'Category',
                    borderShap: true,
                    dataList: value.dataList,
                    onChange: (item) {
                      log(item.toString());
                      widget.item.categoryId = item.id;
                    },
                  );
                },
              ),
              context.addHeight(32),
              ButtonWidget(
                text: str.formAndAction.save,
                onPressed: () async {
                  if (widget.item.id == null) {
                    await provider.add(widget.item);
                  } else {
                    await provider.update(widget.item);
                  }
                  context.pop();
                },
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
