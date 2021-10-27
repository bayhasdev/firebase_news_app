import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:news_app/src/core/enums/viewstate.dart';
import 'package:news_app/src/core/models/article_model.dart';
import 'package:news_app/src/core/models/base_provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:collection/collection.dart';

class ArticleProvider extends BaseProvider<ArticleModel> {
  CollectionReference collection = FirebaseFirestore.instance.collection('articles');

  List<ArticleModel> publicArticalList = [];

  Future loadPublicArtical({String? catId}) async {
    try {
      setState(ViewState.busy);
      QuerySnapshot<Object?> res;
      if (catId == null)
        res = await collection.get();
      else
        res = await collection.where('categoryId', isEqualTo: FirebaseFirestore.instance.doc('categories/$catId')).get();
      publicArticalList.clear();
      for (var element in res.docs) {
        Map<String, dynamic> res = element.data() as Map<String, dynamic>;
        log('res : ${res.toString()}');
        res['categoryId'] = (res['categoryId'] as DocumentReference).id;
        ArticleModel art = ArticleModel.fromMap(res);
        art.id = element.id;
        publicArticalList.add(art);
      }
      setState(ViewState.idle);
    } catch (err) {
      setState(ViewState.idle);
      debugPrint(err.toString());
      rethrow;
    }
  }

  Future loadArticles() async {
    try {
      setState(ViewState.busy);

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

  Future<ArticleModel> add(ArticleModel item, List images) async {
    try {
      setState(ViewState.busy);
      item.image = await uploadImage(item, images);

      var res = await collection.add(articalToMap(item));
      item.id = res.id;

      dataList.insert(0, item);

      setState(ViewState.idle);
      return item;
    } catch (err) {
      setState(ViewState.idle);
      debugPrint(err.toString());
      rethrow;
    }
  }

  Future<void> update(ArticleModel item, List images) async {
    try {
      setState(ViewState.busy);

      item.image = await uploadImage(item, images);

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
      for (final image in item.image!) {
        await firebase_storage.FirebaseStorage.instance.refFromURL('$image').delete();
      }
      await collection.doc(item.id).delete();
      loadArticles();
      setState(ViewState.idle);
    } catch (err) {
      setState(ViewState.idle);
      debugPrint(err.toString());
      rethrow;
    }
  }

  Future uploadImage(ArticleModel item, List images) async {
    List<String> imageList = [];
    for (final image in images) {
      if (!(image is String)) {
        String imagePath = image.path;
        String ImageName = DateTime.now().microsecondsSinceEpoch.toString();
        String imageExtention = imagePath.substring(imagePath.lastIndexOf("."));
        firebase_storage.TaskSnapshot res =
            await firebase_storage.FirebaseStorage.instance.ref('articles/$ImageName$imageExtention').putFile(File(image.path));
        String url = await res.ref.getDownloadURL();
        imageList.add(url);
      } else {
        imageList.add(image);
      }
    }
    var deletedImage = item.image!.whereNot((element) => imageList.contains(element));
    for (final deleltItem in deletedImage) {
      log(deleltItem);
      await firebase_storage.FirebaseStorage.instance.refFromURL('$deleltItem').delete();
    }
    item.image = imageList;
    return imageList;
  }

  Map<String, Object?> articalToMap(ArticleModel item) {
    var map = item.toMap();
    map.remove('id');
    map['categoryId'] = FirebaseFirestore.instance.doc('categories/${item.categoryId}');
    return map;
  }
}
