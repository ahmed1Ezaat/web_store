import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:yt_ecommerce_admin_panel/controllers/cloud_helper_function.dart';
import 'package:yt_ecommerce_admin_panel/data/models/category_model.dart';
import 'package:yt_ecommerce_admin_panel/data/models/product_model.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/product/edit_product_controller.dart';
import '../../../../common/widgets/containers/rounded_container.dart';
import '../../../../utils/constants/sizes.dart';
import '../../category/all_categories/category_controller.dart';

class ProductCategories extends StatelessWidget {
  const ProductCategories({
    super.key, required this.product,
  });
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final productController = EditProductController.instance;
    
  return TRoundedContainer(
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Categories Label
      Text('Categories', style: Theme.of(context).textTheme.headlineSmall),
      const SizedBox(height: TSizes.spaceBtwItem),

      // MultiselectDialogField for selecting categories
      FutureBuilder(
        future: productController.loadSelectedCategories(product.id),
        builder: (context, snapshot) {
          final widget = TCloudHelperFunction.checkMultiRecordState(snapshot: snapshot);
          if (widget != null) return widget;

          return MultiSelectDialogField(
            buttonText: const Text("Select Categories"),
            title: const Text("Categories"),
            initialValue: List<CategoryModel>.from(productController.selectedCategories),
            items: CategoryController.instance.allItems
                .map((category) => MultiSelectItem(category, category.name))
                .toList(),
            listType: MultiSelectListType.CHIP,
            onConfirm: (values) {
              productController.selectedCategories.assignAll(values);
            },
          );
        },
      )
    ],
  ),
);
  }
}