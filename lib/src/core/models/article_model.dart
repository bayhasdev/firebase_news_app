import 'dart:convert';

import 'package:flutter/foundation.dart';

class ArticleModel {
  String? id;
  String? title;
  String? text;
  String? categoryId;
  List<String>? image;

  ArticleModel({
    this.id,
    this.title,
    this.text,
    this.categoryId,
    this.image,
  }) {
    if (image == null) image = [];
  }

  ArticleModel copyWith({
    String? id,
    String? title,
    String? text,
    String? categoryId,
    List<String>? image,
  }) {
    return ArticleModel(
      id: id ?? this.id,
      title: title ?? this.title,
      text: text ?? this.text,
      categoryId: categoryId ?? this.categoryId,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'text': text,
      'categoryId': categoryId,
      'image': image?.join(',') ?? '',
    };
  }

  factory ArticleModel.fromMap(Map<String, dynamic> map) {
    return ArticleModel(
      id: map['id'] != null ? map['id'] : null,
      title: map['title'] != null ? map['title'] : null,
      text: map['text'] != null ? map['text'] : null,
      categoryId: map['categoryId'] != null ? map['categoryId'] : null,
      image: map['image'] != null ? map['image'].split(',') : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ArticleModel.fromJson(String source) => ArticleModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ArticleModel(id: $id, title: $title, text: $text, categoryId: $categoryId, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ArticleModel &&
        other.id == id &&
        other.title == title &&
        other.text == text &&
        other.categoryId == categoryId &&
        listEquals(other.image, image);
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ text.hashCode ^ categoryId.hashCode ^ image.hashCode;
  }
}
