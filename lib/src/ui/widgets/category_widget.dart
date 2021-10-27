import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:news_app/src/config/constants/constants.dart';
import 'package:news_app/src/core/models/category_model.dart';
import '../../../main_imports.dart';

class CategorySingleItem extends StatelessWidget {
  final CategoryModel item;
  final Function(CategoryModel item) onTap;
  CategorySingleItem({required this.item, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          log(item.name ?? '');
          onTap(item);
        },
        child: Stack(
          children: [
            item.image == null ? Image.asset(kNoImage) : Image.memory(item.image!.bytes, fit: BoxFit.cover),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black54, Colors.black45, Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                child: Text(item.name ?? '', style: context.textTheme.headline4!.copyWith(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
