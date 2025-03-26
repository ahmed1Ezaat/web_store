import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/data/models/brand_model.dart';
import 'package:yt_ecommerce_admin_panel/data/models/category_model.dart';
import 'package:yt_ecommerce_admin_panel/features/controllers/loders.dart';
import 'package:yt_ecommerce_admin_panel/features/controllers/network_manger.dart';
import 'package:yt_ecommerce_admin_panel/features/media/media_controller.dart';
import 'package:yt_ecommerce_admin_panel/features/models/image_model.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/brand/brand_controller.dart';

import '../../../data/models/brand_category_model.dart';
import '../../../data/repositorise/brand_repository.dart';
import '../../../utils/popups/full_screen_loader.dart';

class EditBrandController extends GetxController {
  static EditBrandController get instance => Get.find();

  final loading = false.obs;
  RxString imageURL = ''.obs;
  final isFeatured = false.obs;
  final name = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final repository = Get.put(BrandRepository());
  final List<CategoryModel> selectedCategories = <CategoryModel>[].obs;

  // Initialize data for editing
  void init(BrandModel brand) {
    name.text = brand.name;
    imageURL.value = brand.image;
    isFeatured.value = brand.isFeatured;
    if (brand.brandCategories != null) {
      selectedCategories.addAll(brand.brandCategories ?? []);
    }
  }

  // Toggle category selection by object reference
  void toggleSelection(CategoryModel category) {
    if (selectedCategories.contains(category)) {
      selectedCategories.remove(category);
    } else {
      selectedCategories.add(category);
    }
  }

  // Reset all form fields and selections
  void resetFields() {
    name.clear();
    loading(false);
    isFeatured(false);
    imageURL.value = '';
    selectedCategories.clear();
  }

  void pickImage() async {
    final controller = Get.put(MediaController());
    List<ImageModel>? selectedImages = await controller.selectImagesFormMedia();

    if (selectedImages != null && selectedImages.isNotEmpty) {
      ImageModel selectedImage = selectedImages.first;
      imageURL.value = selectedImage.url;
    }
  }

  Future<void> updateBrand(BrandModel brand) async {
    try {
      // بدء التحميل
      TFullScreenLoader.popUpLoader();

      // التحقق من الاتصال بالإنترنت
      final isConnected = await NetworkManger.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // التحقق من صحة النموذج
      if (!formKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // التحقق من تحديث البيانات
      bool isBrandUpdated = false;
      if (brand.image != imageURL.value ||
          brand.name != name.text.trim() ||
          brand.isFeatured != isFeatured.value) {
        isBrandUpdated = true;
        brand.image = imageURL.value;
        brand.name = name.text.trim();
        brand.isFeatured = isFeatured.value;
        brand.updateAt = DateTime.now();
        await repository.updateBrand(brand);
      }

      // تحديث الفئات المرتبطة
      if (selectedCategories.isNotEmpty) await updateBrandCategories(brand);

      // تحديث البيانات في المنتجات
      if (isBrandUpdated) await updateBrandProducts(brand);

      BrandController.instance.updateItemFromList(brand);
      TFullScreenLoader.stopLoading();
      TLodaers.successSnackBar(title: 'Congratulations', message: 'Your brand has been updated successfully.');
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLodaers.errorSnackBar(title: 'OH SNAP', message: e.toString());
    }
  }
  
  updateBrandCategories(BrandModel brand) async {
    final brandCategories = await repository.getCategoriesOfSpecificBrand(brand.id);
    final selectedCategoryIds = selectedCategories.map((e) => e.id);
    final categoriesToRemove = 
        brandCategories.where((existingCategory) => !selectedCategoryIds.contains(existingCategory.categoryId)).toList();
    
    for (var categoryToRemove in categoriesToRemove) {
        await BrandRepository.instance.deleteBrandCategory(categoryToRemove.id ?? '');
    }

    final newCategoriesToAdd = selectedCategories
        .where((newCategory) => !brandCategories.any((existingCategory) => existingCategory.categoryId == newCategory.id))
        .toList();

    for (var newCategory in newCategoriesToAdd) {
        var brandCategory = BrandCategoryModel(brandId: brand.id, categoryId: newCategory.id);
        brandCategory.id = await BrandRepository.instance.createBrandCategory(brandCategory);
    }
    brand.brandCategories!.assignAll(selectedCategories);
    BrandController.instance.updateItemFromList(brand);
    }
    
      updateBrandProducts(BrandModel brand) {}
}
