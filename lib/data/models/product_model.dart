import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yt_ecommerce_admin_panel/data/models/brand_model.dart';
import 'package:yt_ecommerce_admin_panel/data/models/formatter.dart';
import 'package:yt_ecommerce_admin_panel/data/models/product_attribute_model.dart';

import 'product_variaition_model.dart';

class ProductModel {
  String id;
  int stock;
  String? sku;
  double price;
  String title;
  DateTime? date;
  double salePrice;
  String thumbnail;
  bool? isFeatured;
  BrandModel? brand;
  String? categoryId;
  String productType;
  String? description;
  List<String>? images;
  int soldQuantity;
  List<ProductAttributeModel>? productAttributes;
  List<ProductVariationModel>? productVariations;

  ProductModel({
    required this.id,
    required this.title,
    required this.stock,
    required this.price,
    required this.thumbnail,
    required this.productType,
    this.soldQuantity = 0,
    this.sku,
    this.brand,
    this.date,
    this.salePrice = 0.0,
    this.isFeatured ,
    this.categoryId,
    this.description,
    this.images,
    this.productAttributes ,
    this.productVariations ,
  });

  String get formattedDate =>  TFormatter.formatDate(date); 

  static ProductModel empty() => ProductModel(
    id: '',
    title: '',
    stock: 0,
    price: 0,
    thumbnail: '',
    productType: '',
  );

   toJson() {
  return {
    'SKU': sku,
    'Title': title,
    'Stock': stock,
    'Price': price,
    'Images': images ?? [],
    'Thumbnail': thumbnail,
    'SalePrice': salePrice,
    'IsFeatured': isFeatured,
    'CategoryId': categoryId,
    'Brand': brand!.toJson(), 
    'Description': description,
    'ProductType': productType,
    'SoldQuantity': soldQuantity,
    'ProductAttributes': productAttributes != null ? productAttributes!.map((e) => e.toJson()).toList() : [],
    'ProductVariations': productVariations != null ? productVariations!.map((e) => e.toJson()).toList() : [],
  };
}

factory ProductModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
  final data = document.data()!;
  
  return ProductModel(
    id: document.id,
    title: data['Title'],
    price: double.parse((data['Price'] ?? 0.0).toString()),
    sku: data['SKU'],
    stock: data['Stock'] ?? 0,
    thumbnail: data['Thumbnail'] ?? '',
    productType: data['ProductType'] ?? '',
    soldQuantity: data.containsKey('SoldQuantity') ? data['SoldQuantity'] ?? 0: 0,
    isFeatured: data['IsFeatured'] ?? false,
    salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
    categoryId: data['CategoryId'] ?? '',
    description: data['Description'] ?? '',
    brand: BrandModel.fromJson(data['Brand'] ),
    images: data['Images'] != null ? List<String>.from(data['Images']) : [],
    productAttributes: (data['ProductAttributes'] as List<dynamic>)
        .map((e) => ProductAttributeModel.fromJson(e)).toList(),
    productVariations: (data['ProductVariations'] as List<dynamic>)
        .map((e) => ProductVariationModel.fromJson(e)).toList(),
  );
}

factory ProductModel.fromQuerySnapshot(QueryDocumentSnapshot<Object?> document) {
  final data = document.data() as Map<String, dynamic>;
  
  return ProductModel(
    id: document.id,
    title: data['Title'],
    price: double.parse((data['Price'] ?? 0.0).toString()),
    sku: data['SKU'],
    stock: data['Stock'] ?? 0,
    thumbnail: data['Thumbnail'] ?? '',
    productType: data['ProductType'] ?? '',
    soldQuantity: data.containsKey('SoldQuantity') ? data['SoldQuantity'] ?? 0: 0,
    isFeatured: data['IsFeatured'] ?? false,
    salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
    categoryId: data['CategoryId'] ?? '',
    description: data['Description'] ?? '',
    brand: BrandModel.fromJson(data['Brand'] ),
    images: data['Images'] != null ? List<String>.from(data['Images']) : [],
    productAttributes: (data['ProductAttributes'] as List<dynamic>)
        .map((e) => ProductAttributeModel.fromJson(e)).toList(),
    productVariations: (data['ProductVariations'] as List<dynamic>)
        .map((e) => ProductVariationModel.fromJson(e)).toList(),
  );
}
}