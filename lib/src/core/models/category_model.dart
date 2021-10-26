import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String? id;
  String? name;
  String? parentId;
  Blob? image;

  CategoryModel({
    this.id,
    this.name,
    this.parentId,
    this.image,
  });

  CategoryModel copyWith({
    String? id,
    String? name,
    String? parentId,
    Blob? image,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      parentId: parentId ?? this.parentId,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'parentId': parentId,
      'image': image,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'],
      name: map['name'],
      parentId: map['parentId'],
      image: map['image'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) => CategoryModel.fromMap(json.decode(source));

  @override
  String toString() {
    return '$name';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CategoryModel && other.id == id && other.name == name && other.parentId == parentId && other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ parentId.hashCode ^ image.hashCode;
  }
}
