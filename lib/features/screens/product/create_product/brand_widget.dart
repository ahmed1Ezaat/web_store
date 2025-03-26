import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/brand/brand_controller.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/product/create_product_controller.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/shimmer.dart';

import '../../../../common/widgets/containers/rounded_container.dart';
import '../../../../utils/constants/sizes.dart';

class ProductBrand extends StatelessWidget {
  const ProductBrand({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateProductController());
    final brandcontroller = Get.put(BrandController());

    if (brandcontroller.allItems.isEmpty) {
      brandcontroller.fetchItems();
    }
    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Brand label
          Text('Brand', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: TSizes.spaceBtwItem),
          // TypeAheadField for brand selection
          Obx(
            () => brandcontroller.isLoading.value
               ?  const TShimmerEffect(width: double.infinity, height: 50)
               :  TypeAheadField(
                builder: (context, ctr, focusNode) {
                return TextFormField(
                  focusNode: focusNode,
                  controller: controller.brandTextField = ctr,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Select Brand',
                    suffixIcon: Icon(Iconsax.box),
                  ), 
                ); 
              },
              suggestionsCallback: (pattern) {
                // Return filtered brand suggestions based on the search pattern
                return brandcontroller.allItems.where((brand) => brand.name.contains(pattern)).toList();
              },
              itemBuilder: (context, suggestion) {
                return ListTile
                (title: Text(suggestion.name),
                );
              },
              onSelected: (suggestion) {
                // Set the selected brand to the controller
                controller.selectedBrand.value = suggestion;
                controller.brandTextField.text = suggestion.name;
              },
            ),
          ), 
        ],
      ), 
    ); 
  }
}
