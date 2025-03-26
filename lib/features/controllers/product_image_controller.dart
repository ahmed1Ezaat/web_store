import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/data/models/product_variaition_model.dart';

import '../media/media_controller.dart';
import '../models/image_model.dart';

class ProductImagesController extends GetxController {
  static ProductImagesController get instance => Get.find();

  Rx<String?> selectedThumbnailImageUrl = Rx<String?>(null);

  final RxList<String> additionalProductImagesUrls = <String>[].obs;

  void selectThumbnailImage() async {
    final controller = Get.put(MediaController());
    List<ImageModel>? selectedImages = await controller.selectImagesFormMedia();

    if (selectedImages != null && selectedImages.isNotEmpty) {
      ImageModel selectedImage = selectedImages.first;
      selectedThumbnailImageUrl.value = selectedImage.url;
    }
  }

    void selectVariantionImage(ProductVariationModel variation) async {
    final controller = Get.put(MediaController());
    List<ImageModel>? selectedImages = await controller.selectImagesFormMedia();

    if (selectedImages != null && selectedImages.isNotEmpty) {
      ImageModel selectedImage = selectedImages.first;
      selectedThumbnailImageUrl.value = selectedImage.url;
    }
  }

  // Pick Multiple Images from Media
  void selectMultipleProductImages() async {
    final controller = Get.put(MediaController());
    List<ImageModel>? selectedImages = await controller.selectImagesFormMedia(
        multipleSelection: true, selectedUrls: additionalProductImagesUrls);

    // Handle the selected images
    if (selectedImages != null && selectedImages.isNotEmpty) {
      additionalProductImagesUrls.assignAll(selectedImages.map((e) => e.url));
    }
  }

  // Function to remove Product image
  Future<void> removeImage(int index) async {
    additionalProductImagesUrls.removeAt(index);
  }
}
