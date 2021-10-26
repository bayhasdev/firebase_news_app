import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:news_app/src/core/enums/viewstate.dart';
import 'package:news_app/src/core/models/article_model.dart';
import 'package:news_app/src/core/models/base_provider.dart';

class ArticleProvider extends BaseProvider<ArticleModel> {
  CollectionReference collection = FirebaseFirestore.instance.collection('articles');

  ArticleProvider() {
    loadArticles();
  }

  Future loadArticles() async {
    try {
      setState(ViewState.idle);

      QuerySnapshot<Object?> res = await collection.get();
      dataList.clear();
      for (var element in res.docs) {
        Map<String, dynamic> res = element.data() as Map<String, dynamic>;
        log('res : ${res.toString()}');
        res['categoryId'] = (res['categoryId'] as DocumentReference).id;
        ArticleModel art = ArticleModel.fromMap(res);
        art.id = element.id;
        dataList.add(art);
      }
      setState(ViewState.idle);
    } catch (err) {
      setState(ViewState.idle);
      debugPrint(err.toString());
      rethrow;
    }
  }

  Future<ArticleModel> add(ArticleModel item) async {
    try {
      setState(ViewState.busy);
      var res = await collection.add(articalToMap(item));
      setState(ViewState.idle);
      item.id = res.id;
      dataList.insert(0, item);
      return item;
    } catch (err) {
      setState(ViewState.idle);
      debugPrint(err.toString());
      rethrow;
    }
  }

  Future<void> update(ArticleModel item) async {
    try {
      setState(ViewState.busy);
      await collection.doc(item.id).update(articalToMap(item));
      setState(ViewState.idle);
    } catch (err) {
      setState(ViewState.idle);
      debugPrint(err.toString());
      rethrow;
    }
  }

  Future delete(ArticleModel item) async {
    try {
      setState(ViewState.busy);
      await collection.doc(item.id).delete();
      loadArticles();
      setState(ViewState.idle);
    } catch (err) {
      setState(ViewState.idle);
      debugPrint(err.toString());
      rethrow;
    }
  }

  Map<String, Object?> articalToMap(ArticleModel item) {
    var map = item.toMap();
    map.remove('id');
    map['categoryId'] = FirebaseFirestore.instance.doc('categories/${item.categoryId}');
    return map;
  }
}
