import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/data/repositorise/category_repository.dart';

import '../../../../data/abstract/base_data_table_controller.dart';
import '../../../../data/models/category_model.dart';

class CategoryController extends TBaseController<CategoryModel> {
  static CategoryController get instance => Get.find();

  final _categoryRepository = Get.put(CategoryRepository());

  @override
  bool containsSearchQuery(CategoryModel item, String query) {
    return item.name.toLowerCase().contains(query.toLowerCase());
  }

  @override
  Future<void> deleteItem(CategoryModel item) {
    throw _categoryRepository.deleteCategory(item.id);
  }

  @override
  Future<List<CategoryModel>> fetchItems() async {
    return await _categoryRepository.getAllCategories();
  }

  void sortByName(int sortColumnIndex, bool ascending) {
    sortByParenty(sortColumnIndex, ascending, (CategoryModel category) => category.name.toLowerCase());
  }
}
