import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/data/models/product_variaition_model.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/product/product_attributes_controller.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/dia_logo.dart';

class ProductVariationsController extends GetxController {
  static ProductVariationsController get instance => Get.find();

  final isLoading = false.obs;
  final RxList<ProductVariationModel> productVariations =
      <ProductVariationModel>[].obs;

// Lists to store controllers for each variation attribute
  List<Map<ProductVariationModel, TextEditingController>> stockControllerList =
      [];
  List<Map<ProductVariationModel, TextEditingController>> priceControllerList =
      [];
  List<Map<ProductVariationModel, TextEditingController>>
      salePriceControllerList = [];
  List<Map<ProductVariationModel, TextEditingController>>
      descriptionControllerList = [];

// Instance of ProductAttributeController
  final attributeController = Get.put(ProductAttributesController());

  void initializeVariationControllers(List<ProductVariationModel> variations) {
    // Clear existing lists
    stockControllerList.clear();
    priceControllerList.clear();
    salePriceControllerList.clear();
    descriptionControllerList.clear();
    // Initialize controllers for each variation
    for (var variation in variations) {
      // Stock Controllers
      Map<ProductVariationModel, TextEditingController> stockControllers = {};
      stockControllers[variation] =
          TextEditingController(text: variation.stock.toString());
      stockControllerList.add(stockControllers);

      // Price Controllers
      Map<ProductVariationModel, TextEditingController> priceControllers = {};
      priceControllers[variation] =
          TextEditingController(text: variation.price.toString());
      priceControllerList.add(priceControllers);

      // Sale Price Controllers
      Map<ProductVariationModel, TextEditingController> salePriceControllers =
          {};
      salePriceControllers[variation] =
          TextEditingController(text: variation.salePrice.toString());
      salePriceControllerList.add(salePriceControllers);

      // Description Controllers
      Map<ProductVariationModel, TextEditingController> descriptionControllers =
          {};
      descriptionControllers[variation] =
          TextEditingController(text: variation.description);
      descriptionControllerList.add(descriptionControllers);
    }
  }

  void removeVariation(BuildContext context) {
    TDiaLogo.defaultDialog(
      context: context,
      title: 'Remove Variation',
      onConfirm: () {
        productVariations.value = [];
        resetAllValuses();
        Navigator.of(context).pop();
      },
    );
  }

  void generateVariationsConfirmation(BuildContext context) {
    TDiaLogo.defaultDialog(
        context: context,
        title: 'Generate Variations',
        confirmText: 'Generate',
        content:
            'Once you generate variations, all the existing variations will be removed. Are you sure you want to generate variations?',
        onConfirm: () => generateVariationsFromAttributes());
  }

  void generateVariationsFromAttributes() {
    Get.back();

    final List<ProductVariationModel> variations = [];

    if (attributeController.productAttributes.isNotEmpty) {
      final List<List<String>> attributeCombinations = getCombinations(
          attributeController.productAttributes
              .map((attr) => attr.values ?? <String>[])
              .toList());

      for (final combination in attributeCombinations) {
        final Map<String, String> attributeValues = Map.fromIterables(
            attributeController.productAttributes
                .map((attr) => attr.name ?? ''),
            combination);

        final ProductVariationModel variation = ProductVariationModel(
            id: UniqueKey().toString(), attributeValues: attributeValues);

        variations.add(variation);

        // إنشاء خرائط لوحدات التحكم
        final Map<ProductVariationModel, TextEditingController>
            stockControllers = {};
        final Map<ProductVariationModel, TextEditingController>
            priceControllers = {};
        final Map<ProductVariationModel, TextEditingController>
            salePriceControllers = {};
        final Map<ProductVariationModel, TextEditingController>
            descriptionControllers = {};

        // تهيئة وحدات التحكم لنموذج الاختلاف الحالي
        stockControllers[variation] = TextEditingController();
        priceControllers[variation] = TextEditingController();
        salePriceControllers[variation] = TextEditingController();
        descriptionControllers[variation] = TextEditingController();

        // إضافة الخرائط إلى القوائم الرئيسية
        stockControllerList.add(stockControllers);
        priceControllerList.add(priceControllers);
        salePriceControllerList.add(salePriceControllers);
        descriptionControllerList.add(descriptionControllers);
      }
    }

    productVariations.assignAll(variations);
  }

  List<List<String>> getCombinations(List<List<String>> lists) {
    final List<List<String>> result = [];

    combine(lists, 0, <String>[], result);

    return result;
  }

  // Helper function to recursively combine attribute values
  void combine(List<List<String>> lists, int index, List<String> current,
      List<List<String>> result) {
    // If we have reached the end of the lists, add the current combination to the result
    if (index == lists.length) {
      result.add(List.from(current));
      return;
    }

    // Iterate over the values of the current attribute
    for (final item in lists[index]) {
      // Create an updated list with the current value added
      final List<String> updated = List.from(current)..add(item);
      // Recursively combine with the next attribute
      combine(lists, index + 1, updated, result);
    }
  }

  void resetAllValuses() {
    stockControllerList.clear();
    priceControllerList.clear();
    salePriceControllerList.clear();
    descriptionControllerList.clear();
  }
}
