import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/data/models/brand_model.dart';

import '../../../data/abstract/base_data_table_controller.dart';
import '../../../data/repositorise/brand_repository.dart';
import '../category/all_categories/category_controller.dart';

class BrandController extends TBaseController<BrandModel> {
  static BrandController get instance => Get.find();

  final _brandRepository = Get.put(BrandRepository());
  final categoryController = Get.put(CategoryController());

  @override
  Future<List<BrandModel>> fetchItems() async {
    // Fetch brands and brand categories
    final fetchedBrands = await _brandRepository.getAllBrands();
    final fetchedBrandCategories =
        await _brandRepository.getAllBrandCategories();

    // Fetch categories if not already loaded
    if (categoryController.allItems.isNotEmpty)
      await categoryController.fetchItems();

    // Map categories to brands
    for (var brand in fetchedBrands) {
      List<String> categoryIds = fetchedBrandCategories
          .where((brandCategory) => brandCategory.brandId == brand.id)
          .map((brandCategory) => brandCategory.categoryId)
          .toList();

      brand.brandCategories = categoryController.allItems
          .where((category) => categoryIds.contains(category.id))
          .toList();
          brand.brandCategories = categoryController.allItems.where((category) => categoryIds.contains(category.id)).toList();
    }
    return fetchedBrands;
  }

  @override
  bool containsSearchQuery(BrandModel item, String query) {
    return item.name.toLowerCase().contains(query.toLowerCase());
  }

  @override
  Future<void> deleteItem(BrandModel item) {
    return _brandRepository.deleteBrand(item);
  }

  void sortByName(int sortColumnIndex, bool ascending) {
    sortByParenty(sortColumnIndex, ascending, (BrandModel b) => b.name.toLowerCase());
  }
}
