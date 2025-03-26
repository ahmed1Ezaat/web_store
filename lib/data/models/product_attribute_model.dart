class ProductAttributeModel {
  String? name;
  final List<String>? values;

  ProductAttributeModel({this.name, this.values });

  /// Convert to JSON format
toJson() {
    return {
      'Name': name,
      'Values': values,
    };
  }

  /// Create model from Firebase document
  factory ProductAttributeModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    return ProductAttributeModel(
      name: data.containsKey('Name') ? data['Name'] : '',
      values: List<String>.from(data['Values']),
    );
  }
}