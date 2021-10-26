import 'dart:convert';

class ArticleModel {
  String? id;
  String? title;
  String? text;
  String? categoryId;
  String? image;
  ArticleModel({
    this.id,
    this.title,
    this.text,
    this.categoryId,
    this.image,
  });

  ArticleModel copyWith({
    String? id,
    String? title,
    String? text,
    String? categoryId,
    String? image,
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
      'image': image,
    };
  }

  factory ArticleModel.fromMap(Map<String, dynamic> map) {
    return ArticleModel(
      id: map['id'],
      title: map['title'],
      text: map['text'],
      categoryId: map['categoryId'],
      image: map['image'],
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
        other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ text.hashCode ^ categoryId.hashCode ^ image.hashCode;
  }
}
