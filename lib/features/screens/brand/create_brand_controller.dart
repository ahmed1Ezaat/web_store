import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/data/models/brand_category_model.dart';
import 'package:yt_ecommerce_admin_panel/data/models/brand_model.dart';
import 'package:yt_ecommerce_admin_panel/features/controllers/loders.dart';
import 'package:yt_ecommerce_admin_panel/features/controllers/network_manger.dart';
import 'package:yt_ecommerce_admin_panel/features/media/media_controller.dart';
import 'package:yt_ecommerce_admin_panel/features/models/image_model.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/brand/brand_controller.dart';
import 'package:yt_ecommerce_admin_panel/utils/popups/full_screen_loader.dart';

import '../../../data/models/category_model.dart';
import '../../../data/repositorise/brand_repository.dart';

class CreateBrandController extends GetxController {
  static CreateBrandController get instance => Get.find();

  final loading = false.obs;
   RxString imageURL = ''.obs;
  final  isFeatured = false.obs;
  final  name = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final List<CategoryModel> selectedCategories = <CategoryModel>[].obs;

  /// Toggle Category Selection using ID comparison
  void toggleSelection(CategoryModel category) {
    
    if (selectedCategories.contains(category)) {
      selectedCategories.contains(category);
      selectedCategories.remove(category);
    
    } else {
      selectedCategories.add(category);
    }
  }

  /// Reset all form fields and state
  void resetFields() {
    name.clear();
    loading (false);
    isFeatured (false);
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

Future<void> createBrand() async {
    try {
    // Start Loading
    TFullScreenLoader.popUpLoader();
    

    // Check Internet Connectivity
    final isConnected = await NetworkManger.instance.isConnected();
    if (!isConnected) {
    TFullScreenLoader.stopLoading();
    return;
    }

    // Form Validation
    if (!formKey.currentState!.validate()) {
    TFullScreenLoader.stopLoading();
    return;
    }

    // Map Data
        final newRecord = BrandModel(
          id: '',
          productCount: 0,
          image: imageURL.value,
          name: name.text.trim(),
          createAt: DateTime.now(),
          isFeatured: isFeatured.value,
        );

       newRecord.id = await BrandRepository.instance.createBrand(newRecord);

       // Register brand categories if any
if (selectedCategories.isNotEmpty) {
    if (newRecord.id.isEmpty) throw 'Error storing relational data. Try again';

    // Loop selected Brand Categories
    for (var category in selectedCategories) {
    // Map Data
    final brandCategory = BrandCategoryModel(brandId: newRecord.id, categoryId: category.id);
    await BrandRepository.instance.createBrandCategory(brandCategory);
}
    // ... (Continue implementation here)
    newRecord.brandCategories ??= [];
    newRecord.brandCategories!.addAll(selectedCategories);


}
  BrandController.instance.addItemToLists(newRecord);

  resetFields();

  TFullScreenLoader.stopLoading();

  TLodaers.successSnackBar(title: 'Congratulations', message: 'New Record has been added' );

} catch (e) {
    // Handle exceptions
    TFullScreenLoader.stopLoading();
    TLodaers.errorSnackBar(title: 'Error', message: e.toString());
} 
}
}