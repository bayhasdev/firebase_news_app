import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:news_app/src/core/enums/viewstate.dart';
import 'package:news_app/src/core/models/base_provider.dart';
import 'package:news_app/src/core/models/category_model.dart';
import 'package:collection/collection.dart';

class CategoryProvider extends BaseProvider<CategoryModel> {
  CollectionReference collection = FirebaseFirestore.instance.collection('categories');

  CategoryProvider() {
    loadAllCategories();
  }

  CategoryModel? findLocal(String id) {
    List<CategoryModel?> list = dataList.toList();
    return list.firstWhereOrNull((element) => element!.id == id);
  }

  Future loadAllCategories() async {
    try {
      setState(ViewState.idle);
      QuerySnapshot<Object?> res = await collection.get();
      dataList.clear();
      for (var element in res.docs) {
        log(element.data().toString());
        CategoryModel cat = CategoryModel.fromMap(element.data() as Map<String, dynamic>);
        cat.id = element.id;
        dataList.add(cat);
      }
      setState(ViewState.idle);
    } catch (err) {
      setState(ViewState.idle);
      debugPrint(err.toString());
      rethrow;
    }
  }

  Future<CategoryModel> add(CategoryModel item) async {
    try {
      setState(ViewState.busy);
      var res = await collection.add(item.toMap());
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

  Future<void> update(CategoryModel item) async {
    try {
      setState(ViewState.busy);
      await collection.doc(item.id).update(item.toMap());
      setState(ViewState.idle);
    } catch (err) {
      setState(ViewState.idle);
      debugPrint(err.toString());
      rethrow;
    }
  }

  Future delete(CategoryModel item) async {
    try {
      setState(ViewState.busy);
      await collection.doc(item.id).delete();
      loadAllCategories();
      setState(ViewState.idle);
    } catch (err) {
      setState(ViewState.idle);
      debugPrint(err.toString());
      rethrow;
    }
  }
}
