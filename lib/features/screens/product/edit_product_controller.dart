
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
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
import '../category/all_categories/category_controller.dart';

class EditProductController extends GetxController {
  static EditProductController get instance => Get.find();

  // الحالات التفاعلية
  final isLoading = false.obs;
  final selectedCategoriesLoder = false.obs;
  final productType = ProductType.single.obs;
  final productVisibility = ProductVisibility.hidden.obs;

  // مفاتيح التحقق من النماذج
  final attributesController = Get.put(ProductAttributesController());
  final variationsController = Get.put(ProductVariationsController());
  final imageController = Get.put(ProductImagesController());
  final productRepository = Get.put(ProductRepository());
  final stockPriceFormKey = GlobalKey<FormState>();
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
  late final RxList<CategoryModel> selectedCategories = <CategoryModel>[].obs;
  final List<CategoryModel> alreadyAddedCategories = <CategoryModel>[];

  RxBool thumbnailUploader = true.obs;
  RxBool addititonalImagesUploader = true.obs;
  RxBool productDataUploader = false.obs;
  RxBool categoriesRelationshipUploader = false.obs;

  void initProductData(ProductModel product)  {
    try {
      isLoading.value = true;
      title.text = product.title;
      description.text = product.description ?? '';
      productType.value = product.productType == ProductType.single.toString()
          ? ProductType.single
          : ProductType.variable;

          if (product.productType == ProductType.single.toString()){
            stock.text = product.stock.toString();
            price.text = product.price.toString();
            salePrice.text = product.salePrice.toString();
          }      

      selectedBrand.value = product.brand;
      brandTextField.text = product.brand?.name ?? '';

      if (product.images != null) {
        imageController.selectedThumbnailImageUrl.value = product.thumbnail;
        imageController.additionalProductImagesUrls.assignAll(product.images ?? []);
      }
      // Product Attributes & Variations
      attributesController.productAttributes.assignAll(product.productAttributes ?? []);
      variationsController.productVariations.assignAll(product.productVariations ?? []);
      variationsController.initializeVariationControllers(product.productVariations ?? []);

      isLoading.value = false; // Set loading state back to false after initialization

      update();
      } catch (e) {
      if (kDebugMode) print(e);
      }
  }
    Future<List<CategoryModel>> loadSelectedCategories(String productId) async {
  selectedCategoriesLoder.value = true;
  
  final productCategories = await productRepository.getProductCategories(productId);
  final categoriesController = Get.put(CategoryController());
  if (categoriesController.allItems.isEmpty) await categoriesController.fetchItems();

  final categoriesIds = productCategories.map((e) => e.categoryId).toList();
  final categories = categoriesController.allItems.where((element) => categoriesIds.contains(element.id)).toList();
  selectedCategories.assignAll(categories);
  alreadyAddedCategories.assignAll(categories);
  selectedCategoriesLoder.value = false;
  return categories;
}


Future<void> editProduct(ProductModel product) async {
  try {
    showProgressDialog();

    final isConnected = await NetworkManger.instance.isConnected();
    if (!isConnected) {
      TFullScreenLoader.stopLoading();
      return;
    }

    if (!titleDescriptionFormKey.currentState!.validate()) {
      TFullScreenLoader.stopLoading();
      return;
    }

    if (productType.value == ProductType.single && 
        !stockPriceFormKey.currentState!.validate()) {
      TFullScreenLoader.stopLoading();
      return;
    }

    if (selectedBrand.value == null) throw 'Select Brand for this product';

    if (productType.value == ProductType.variable && 
        ProductVariationsController.instance.productVariations.isEmpty) {
      throw 'No variations for Variable Product Type';
    }

    if (productType.value == ProductType.variable) {
      final variationCheckFailed = ProductVariationsController.instance.productVariations.any(
        (element) => // ... Complete validation condition
    element.price.isNaN ||  
    element.price < 0 ||  
    element.salePrice.isNaN ||  
    element.salePrice < 0 ||  
    element.stock.isNaN ||  
    element.stock < 0,  
);

if (variationCheckFailed) throw 'Variation data is not accurate. Please recheck variations';
    }
// Upload Product Thumbnail Image  
final imagesController = ProductImagesController.instance;  
if (imagesController.selectedThumbnailImageUrl.value == null ||  imagesController.selectedThumbnailImageUrl.value!.isEmpty) {
 throw 'Upload Product Thumbnail Image';  
}

// Handle product type mismatch  
var variations = ProductVariationsController.instance.productVariations;  
if (productType.value == ProductType.single && variations.isNotEmpty) {  
    ProductVariationsController.instance.resetAllValuses();  
    variations.value = [];  
}

// Update product data
product.sku = '';
product.isFeatured = true;
product.title = title.text.trim();
product.brand = selectedBrand.value;
product.description = description.text.trim();
product.productType = productType.value.toString();
product.stock = int.tryParse(stock.text.trim()) ?? 0;
product.price = double.tryParse(price.text.trim()) ?? 0;
product.images = imagesController.additionalProductImagesUrls;
product.salePrice = double.tryParse(salePrice.text.trim()) ?? 0.0;
product.thumbnail = imagesController.selectedThumbnailImageUrl.value ?? '';
product.productAttributes = ProductAttributesController.instance.productAttributes;
product.productVariations = variations;

// Call Repository to Update Product
productDataUploader.value = true;
await ProductRepository.instance.updateProduct(product);

if (selectedCategories.isNotEmpty) {
  categoriesRelationshipUploader.value = true;

  List<String> existingCategoryIds = alreadyAddedCategories.map((category) => category.id).toList();

  for (var category in selectedCategories) {
    if (!existingCategoryIds.contains(category.id)) {
      final productCategory = ProductCategoryModel(
        productId: product.id, 
        categoryId: category.id
      );
      await ProductRepository.instance.createProductCategory(productCategory);
    }
  }

  for (var existingCategoryId in existingCategoryIds) {
    if (!selectedCategories.any((category) => category.id == existingCategoryId)) {
      await ProductRepository.instance.removeProductCategory(product.id, existingCategoryId);
    }
  }}

 
  ProductController.instance.updateItemFromList(product);
   
      TFullScreenLoader.stopLoading();
      showCompletionDialog();
    } catch (e){

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

  

void showProgressDialog() {
  showDialog(
    context: Get.context!,
    barrierDismissible: false,
    builder: (context) => PopScope(
      canPop: false,
      child: AlertDialog(
        title: const Text('Updating Product'),
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
          const Text('Your Product has been Updated.'),
        ],
      ),
    ),
  );
}
  
  }   

