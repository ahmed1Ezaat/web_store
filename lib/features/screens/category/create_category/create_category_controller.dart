import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/data/repositorise/category_repository.dart';
import 'package:yt_ecommerce_admin_panel/features/controllers/loders.dart';
import 'package:yt_ecommerce_admin_panel/features/controllers/network_manger.dart';
import 'package:yt_ecommerce_admin_panel/features/media/media_controller.dart';
import 'package:yt_ecommerce_admin_panel/features/models/image_model.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/category/all_categories/category_controller.dart';
import 'package:yt_ecommerce_admin_panel/utils/popups/full_screen_loader.dart';

import '../../../../data/models/category_model.dart';

class CreateCategoryController extends GetxController {
  static CreateCategoryController get instance => Get.find();

  final selectedParent = CategoryModel.empty().obs;
  final loading = false.obs;
  RxString imageURL = ''.obs;
  final isFeatured = false.obs;
  final name = TextEditingController();
  final formKey = GlobalKey<FormState>();

  /// Reset new category
  Future<void> createCategory() async {
    try {
      TFullScreenLoader.popUpLoader();

      final isConnected = await NetworkManger.instance.isConnected();

      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      if (!formKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }
      final newRecord = CategoryModel(
        id: '',
        image: imageURL.value,
        name: name.text.trim(),
        createdAt: DateTime.now(),
        isFeatured: isFeatured.value,
        parentId: selectedParent.value.id,
      );

       newRecord.id = await CategoryRepository.instance.createCategory(newRecord);

       CategoryController.instance.addItemToLists(newRecord);

       resetFields();


      TFullScreenLoader.stopLoading();

      TLodaers.successSnackBar(
          title: 'Congratulations', message: 'New Record has been added');
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLodaers.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  void pickImage() async {
    final controller = Get.put(MediaController());
    List<ImageModel>? selectedImages = await controller.selectImagesFormMedia();

    if (selectedImages != null && selectedImages.isNotEmpty) {
      ImageModel selectedImage = selectedImages.first;
      imageURL.value = selectedImage.url;
    }
  }
  
  void resetFields() {
    selectedParent(CategoryModel.empty());
    loading(false);
    isFeatured(false);
    name.clear();
    imageURL.value = '';
  }
}
