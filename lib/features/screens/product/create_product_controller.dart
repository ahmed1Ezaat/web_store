import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/data/models/brand_model.dart';
import 'package:yt_ecommerce_admin_panel/data/models/category_model.dart';
import 'package:yt_ecommerce_admin_panel/data/models/product_category_model.dart';
import 'package:yt_ecommerce_admin_panel/data/models/product_model.dart';
import 'package:yt_ecommerce_admin_panel/data/repositorise/product_repository.dart';
import 'package:yt_ecommerce_admin_panel/features/controllers/loders.dart';
import 'package:yt_ecommerce_admin_panel/features/controllers/network_manger.dart';
import 'package:yt_ecommerce_admin_panel/features/controllers/product_controller.dart';
import 'package:yt_ecommerce_admin_panel/features/controllers/product_image_controller.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/product/product_attributes_controller.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/product/product_variaition_controller.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/emums.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/images_strings.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';

import '../../../utils/popups/full_screen_loader.dart';

class CreateProductController extends GetxController {
  static CreateProductController get instance => Get.find();

  // الحالات التفاعلية
  final isLoading = false.obs;
  final productType = ProductType.single.obs;
  final productVisibility = ProductVisibility.hidden.obs;

  // مفاتيح التحقق من النماذج
  final stockPriceFormKey = GlobalKey<FormState>();
  final productRepository = Get.put(ProductRepository());
  final titleDescriptionFormKey = GlobalKey<FormState>();

  // المتحكمات في حقول الإدخال
  TextEditingController title = TextEditingController();
  TextEditingController stock = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController salePrice = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController brandTextField = TextEditingController();

  // البيانات المختارة
  final Rx<BrandModel?> selectedBrand = Rx<BrandModel?>(null);
  final RxList<CategoryModel> selectedCategories = <CategoryModel>[].obs;

  RxBool thumbnailUploader = false.obs;
  RxBool addititonalImagesUploader = false.obs;
  RxBool productDataUploader = false.obs;
  RxBool categoriesRelationshipUploader = false.obs;

  Future<void> createProduct() async {
    try {
      // Show progress dialog
      showProgressDialog();
      // Check Internet Connectivity
      final isConnected = await NetworkManger.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Validate title and description form
      if (!titleDescriptionFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Validate stock and pricing form if ProductType = Single
      if (productType.value == ProductType.single &&
          !stockPriceFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      if (selectedBrand.value == null) throw 'Please select a brand';
      if (productType.value == ProductType.variable &&
          ProductVariationsController.instance.productVariations.isEmpty) {
        throw 'Please add product variations';
      }
      if (productType.value == ProductType.variable) {
        final variationCheckFaild = ProductVariationsController
            .instance.productVariations
            .any((element) =>
                element.price.isNaN ||
                element.price < 0 ||
                element.salePrice.isNaN ||
                element.salePrice < 0 ||
                element.stock.isNaN ||
                element.stock < 0 ||
                element.image.value.isEmpty);

        if (variationCheckFaild) throw 'Variation data is invalid';
      }

      thumbnailUploader.value = true;
      final imageController = ProductImagesController.instance;
      if (imageController.selectedThumbnailImageUrl.value == null) throw 'Select Product Thumbnail';

      addititonalImagesUploader.value = true;

      final vairation = ProductVariationsController.instance.productVariations;
      if (productType.value == ProductType.single && vairation.isNotEmpty) {
        ProductVariationsController.instance.resetAllValuses();
        vairation.value = [];
      }

      final newRecord = ProductModel(
        id: '',
        sku: '',
        isFeatured: true,
        title: title.text.trim(),
        brand: selectedBrand.value,
        productVariations: vairation,
        description: description.text.trim(),
        productType: productType.value.toString(),
        stock: int.tryParse(stock.text.trim()) ?? 0,
        price: double.tryParse(price.text.trim()) ?? 0,
        images: imageController.additionalProductImagesUrls,
        salePrice: double.tryParse(salePrice.text.trim()) ?? 0,
        thumbnail: imageController.selectedThumbnailImageUrl.value ?? '',
        productAttributes:
            ProductAttributesController.instance.productAttributes,
        date: DateTime.now(),
      );
      // استدعاء المستودع لإنشاء منتج جديد
      productDataUploader.value = true;
      newRecord.id = await ProductRepository.instance.createProduct(newRecord);

      // تسجيل الفئات المرتبطة إذا وجدت
      if (selectedCategories.isNotEmpty) {
        if (newRecord.id.isEmpty) throw 'Error creating product';

        categoriesRelationshipUploader.value = true;
        for (var category in selectedCategories) {
          final productCategory = ProductCategoryModel(
              productId: newRecord.id, categoryId: category.id);
          await ProductRepository.instance
              .createProductCategory(productCategory);
        }
      }

      // تحديث قائمة المنتجات
      ProductController.instance.addItemToLists(newRecord);

      TFullScreenLoader.stopLoading();

      showCompletionDialog();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLodaers.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }


  void resetValues() {
  isLoading.value = false;
  productType.value = ProductType.single;
  productVisibility.value = ProductVisibility.hidden;
  stockPriceFormKey.currentState?.reset();
  titleDescriptionFormKey.currentState?.reset();
  title.clear();
  description.clear();
  stock.clear();
  price.clear();
  salePrice.clear();
  brandTextField.clear();
  selectedBrand.value = null;
  selectedCategories.clear();
  ProductVariationsController.instance.resetAllValuses();
  ProductAttributesController.instance.resetProductAttributes();

  thumbnailUploader.value = false;
  addititonalImagesUploader.value = false;
  productDataUploader.value = false;
  categoriesRelationshipUploader.value = false;
}

  
  void showCompletionDialog() {
  Get.dialog(
    AlertDialog(
      title: const Text('Congratulations'),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
            Get.back();
          },
          child: const Text('Go to Products'),
        ),
      ],
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(TImages.productsIllustrion, height: 200, width: 200),
          const SizedBox(height: TSizes.spaceBtwItem),
          Text('Congratulations', style: Theme.of(Get.context!).textTheme.headlineSmall),
          const SizedBox(height: TSizes.spaceBtwItem),
          const Text('Your Product has been Created'),
        ],
      ),
    ),
  );
}

Widget buildCheckBox(String label, RxBool value) {
  return Row(
    children: [
      AnimatedSwitcher(
        duration: const Duration(seconds: 2),
        child: value.value
            ? const Icon(CupertinoIcons.checkmark_circle_fill, color: Colors.blue)
            : const Icon(CupertinoIcons.checkmark_circle),
      ),
      const SizedBox(width: TSizes.spaceBtwItem),
      Text(label),
    ],
  );
}

  void showProgressDialog() {
  showDialog(
    context: Get.context!,
    barrierDismissible: false,
    builder: (context) => PopScope(
      canPop: false,
      child: AlertDialog(
        title: const Text('Creating Product'),
        content: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(TImages.creatiogProductIllustration, height: 200, width: 200),
              const SizedBox(height: TSizes.spaceBtwItem),
              buildCheckBox('Thumbnail Image', thumbnailUploader),
              buildCheckBox('Additional Images', addititonalImagesUploader),
              buildCheckBox('Product Data, Attributes & Variations', productDataUploader),
              buildCheckBox('Product Categories', categoriesRelationshipUploader),
              const SizedBox(height: TSizes.spaceBtwItem),
              const Text('Sit Tight, Your product is uploading...'),
            ],
          ),
        ),
      ),
    ),
  );
}
  
}
