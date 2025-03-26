import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yt_ecommerce_admin_panel/data/models/category_model.dart';

import 'formatter.dart';

class BrandModel {
  String id;
  String name;
  String image;
  bool isFeatured;
  int? productCount;
  DateTime? createAt;
  DateTime? updateAt;

  // Not mapped
  List<CategoryModel>? brandCategories;

  BrandModel({
    required this.id,
    required this.image,
    required this.name,
    this.isFeatured = false,
    this.productCount,
    this.createAt,
    this.updateAt,
    this.brandCategories,
  });

  /// Empty Helper Function
  static BrandModel empty() => BrandModel(id: '', image: '', name: '');

  String get formattedDate => TFormatter.formatDate(createAt);

  String get formattedUpdateAktDate => TFormatter.formatDate(updateAt);

  /// Convert model to Json structure
  toJson() {
    return {
      'Id': id,
      'Name': name,
      'Image': image,
      'CreateAkt': createAt,
      'IsFeatured': isFeatured,
      'ProductCount': productCount = 0,
      'UpdateAt': updateAt = DateTime.now(),
    };
  }

  // Map Json oriented document snapshot from Firebase to BrandModel
  factory BrandModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;

      return BrandModel(
        id: document.id,
        name: data['Name'] ?? '',
        image: data['Image'] ?? '',
        productCount: data['ProductCount'] ?? '',
        isFeatured: data['IsFeatured'] ?? false,
        createAt:
            data.containsKey('CreateAt') ? data['CreateAt'].toDate() : null,
        updateAt:
            data.containsKey('UpdateAt') ? data['UpdateAt'].toDate() : null,
      );
    } else {
      return BrandModel.empty();
    }
  }
  // Map Json to BrandModel
factory BrandModel.fromJson(Map<String, dynamic> document) {
  final data = document;
  if (data.isEmpty) return BrandModel.empty();
  
  return BrandModel(
    id: data['Id'] ?? '',
    name: data['Name'] ?? '',
    image: data['Image'] ?? '',
    isFeatured: data['IsFeatured'] ?? false,
    productCount: int.parse((data['ProductCount'] ?? 0).toString()),
    createAt: data.containsKey('CreateAkt') ? data['CreateAkt'].toDate() : null,
    updateAt: data.containsKey('UpdateAt') ? data['UpdateAt'].toDate() : null,
  );
}
}
