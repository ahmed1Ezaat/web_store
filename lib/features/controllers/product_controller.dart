import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/data/abstract/base_data_table_controller.dart';
import 'package:yt_ecommerce_admin_panel/data/models/product_model.dart';
import 'package:yt_ecommerce_admin_panel/data/repositorise/product_repository.dart';

import '../../utils/constants/emums.dart';

class ProductController extends TBaseController<ProductModel> {
  static ProductController get instance => Get.find();

  final _productRepository = Get.put(ProductRepository());

  @override
  Future<List<ProductModel>> fetchItems() async {
    return await _productRepository.getAllProducts();
  }

  @override
  bool containsSearchQuery(ProductModel item, String query) {
    return item.title.toLowerCase().contains(query.toLowerCase()) ||
        item.brand!.name.toLowerCase().contains(query.toLowerCase()) ||
        item.stock.toString().contains(query) ||
        item.price.toString().contains(query);
  }

  @override
  Future<void> deleteItem(ProductModel item) async {
    await _productRepository.deleteProduct(item);
  }

  // Sorting by product name
  void sortByName(int sortColumnIndex, bool ascending) {
    sortByParenty(
      sortColumnIndex,
      ascending,
      (ProductModel product) => product.title.toLowerCase(),
    );
  }

  /// فرز المنتجات حسب السعر
  void sortByPrice(int sortColumnIndex, bool ascending) {
    sortByParenty(sortColumnIndex, ascending,
        (ProductModel product) => product.salePrice);
  }

  /// فرز المنتجات حسب الكمية في المخزن
  void sortByStock(int sortColumnIndex, bool ascending) {
    sortByParenty(
      sortColumnIndex,
      ascending,
      (ProductModel product) => product.stock,
    );
  }

  /// فرز المنتجات حسب الكمية المباعة
  void sortBySoldItems(int sortColumnIndex, bool ascending) {
    sortByParenty(
      sortColumnIndex,
      ascending,
      (ProductModel product) => product.soldQuantity,
    );
  }

  /// الحصول على سعر المنتج أو نطاق الأسعار// تحديد سعر المنتج أو نطاق الأسعار للاختلافات
  String getProductPrice(ProductModel product) {
    // للمنتجات البسيطة أو بدون اختلافات
    if (product.productType == ProductType.single.toString() ||
        product.productVariations!.isEmpty) {
      return (product.salePrice > 0.0 ? product.salePrice : product.price)
          .toString();
    } else {
      double smallesPrice = double.infinity;
      double largesPrice = 0.0;

      for (var variation in product.productVariations!) {
        double priceToConsider =
            variation.salePrice > 0.0 ? variation.salePrice : variation.price;

        if (priceToConsider < smallesPrice) {
          smallesPrice = priceToConsider;
        }

        if (priceToConsider > largesPrice) {
          largesPrice = priceToConsider;
        }
      }

      if (smallesPrice.isEqual(largesPrice)) {
        return largesPrice.toString();
        } else {
          return '$smallesPrice - \$$largesPrice';
        }
      }
    }

    // -- حساب نسبة الخصم
String? calculateSalePercentage(double originalPrice, double? salePrice) {
  if (salePrice == null || salePrice <= 0.0) return null;
  if (originalPrice <= 0) return null;
  
  double percentage = ((originalPrice - salePrice) / originalPrice) * 100;
  return percentage.toStringAsFixed(0);
}

// -- حساب إجمالي المخزون
String getProductStockTotal(ProductModel product) {
  return product.productType == ProductType.single.toString()
      ? product.stock.toString() 
      : product.productVariations!
          .fold<int>(0, (previousValue, element) => previousValue + element.stock).toString();
}

// -- حساب الكمية المباعة
String getProductSoldQuantity(ProductModel product) {
  return product.productType == ProductType.single.toString()
      ? product.soldQuantity.toString()
      : product.productVariations!
          .fold<int>(0, (previousValue, element) => previousValue + element.soldQuantity)
          .toString();
}

// -- حالة المخزون
String getProductStockStatus(ProductModel product) {
  return product.stock > 0 ? 'In Stock' : 'Out of Stock';
}
  }

