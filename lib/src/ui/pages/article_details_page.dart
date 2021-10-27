import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:news_app/src/config/themes/colors.dart';
import 'package:news_app/src/core/models/article_model.dart';
import 'package:news_app/src/utils/custom_widgets/image_slider_page.dart';
import 'package:news_app/src/utils/custom_widgets/image_widgets.dart';
import 'dart:math' as math;
import '../../../main_imports.dart';

class ArticleDetailsPage extends StatelessWidget {
  static const String routeName = '/ArticleDetailsPage';

  final ArticleModel article;
  ArticleDetailsPage(this.article);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: context.appTheme.primaryColor,
      statusBarIconBrightness: Brightness.light,
    ));

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            SliverAppBar(
              pinned: true,
              floating: true,
              elevation: 0,
              expandedHeight: 50,
              toolbarHeight: 40,
              centerTitle: false,
              leading: const SizedBox(),
              backgroundColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                background: Material(
                  color: kCardBackground,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const BackButton(color: Colors.black),
                      Expanded(child: SizedBox()),
                      IconButton(onPressed: () {}, icon: const Icon(Icons.share, color: Colors.black)),
                    ],
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Hero(
                    tag: article.image?.first ?? DateTime.now().toIso8601String(),
                    child: CarouselSlider(
                      options: CarouselOptions(
                        autoPlay: true,
                        viewportFraction: 1,
                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                      ),
                      items: article.image!.map((e) {
                        double imageWidth = math.min(context.width, 500);
                        double imageHeight = imageWidth * (4 / 3);
                        return ImageView(
                          e,
                          height: imageHeight,
                          width: imageWidth,
                          imageHeight: 800,
                          imageWidth: 600,
                          tapped: true,
                          onTap: () => context.navigateName(ImageSliderPage.routeName, data: [article.image, e]),
                        );
                      }).toList(),
                    ),
                  ),
                  context.addHeight(24),
                  Text(
                    article.title ?? '',
                    style: context.textTheme.headline2,
                    textAlign: TextAlign.center,
                  ),
                  context.addHeight(16),
                  Text(
                    article.text ?? '',
                    style: context.textTheme.headline2,
                    textAlign: TextAlign.center,
                  ),
                  const Divider(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
