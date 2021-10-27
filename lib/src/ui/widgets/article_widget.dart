import 'package:flutter/material.dart';
import 'package:news_app/src/core/models/article_model.dart';
import 'package:news_app/src/ui/pages/article_details_page.dart';
import 'package:news_app/src/utils/custom_widgets/image_widgets.dart';
import '../../../main_imports.dart';

class ArticleSingleItem extends StatelessWidget {
  final ArticleModel item;
  ArticleSingleItem(this.item);
  @override
  Widget build(BuildContext context) {
    double height = context.width * (9 / 16);
    return Card(
      margin: EdgeInsets.all(8),
      child: InkWell(
        onTap: () {
          context.navigateName(ArticleDetailsPage.routeName, data: item);
        },
        child: Column(
          children: [
            Hero(
              tag: item.image?.first ?? DateTime.now().toIso8601String(),
              child: ImageView(item.image?.first, height: height, width: context.width, fit: BoxFit.cover),
            ),
            context.addHeight(4),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(item.title ?? '', style: context.textTheme.headline4, maxLines: 3),
            ),
          ],
        ),
      ),
    );
  }
}
