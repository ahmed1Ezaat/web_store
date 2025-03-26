import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/data/models/product_attribute_model.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/product/product_variaition_controller.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/dia_logo.dart';

class ProductAttributesController extends GetxController {
  static ProductAttributesController get instance => Get.find();

  // Observables for loading state, form key, and product attributes
  
  final isLoading = false.obs;
  final attributesFormKey = GlobalKey<FormState>();
  TextEditingController attributeName = TextEditingController();
  TextEditingController attributes = TextEditingController();
  final RxList<ProductAttributeModel> productAttributes =
      <ProductAttributeModel>[].obs;

  // Function to add a new attribute

  void addNewAttribute() {
    // Form Validation
    if (!attributesFormKey.currentState!.validate()) {
      return;
    }
    // Add Attributes to the List of Attributes
    productAttributes.add(ProductAttributeModel(
        name: attributeName.text.trim(),
        values: attributes.text.trim().split("|").toList()));

    // Clear text fields after adding
    attributeName.text = '';
    attributes.text = '';
  }

  // Function to remove an attribute
  void removeAttribute(int index, BuildContext context) {
    // Show a confirmation dialog
    TDiaLogo.defaultDialog(
      context: context,
      onConfirm: () {
        Navigator.of(context).pop();
        productAttributes.removeAt(index);

        ProductVariationsController.instance.productVariations.value = [];
      },
    );
  }

  void resetProductAttributes() {
    productAttributes.clear();
  }
}
