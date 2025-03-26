import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/product/create_product_controller.dart';

import '../../../../common/widgets/containers/rounded_container.dart';
import '../../../../utils/constants/sizes.dart';
import '../../login/responsive_screens/widgets/validation.dart';

class ProductTitleAndDescription extends StatelessWidget {
  const ProductTitleAndDescription({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateProductController());
    return TRoundedContainer(
      child: Form(
        key: controller.titleDescriptionFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Basic Information Text
            Text(
              'Basic Information',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: TSizes.spaceBtwItem),
            // Product Title Input Field
            TextFormField(
              controller: controller.title,
              validator: (value) =>
                  TValidator.validateEmptyText('Product Title', value),
              decoration:
                  const InputDecoration(labelText: 'Product Title'),
            ), 
            const SizedBox(height: TSizes.spaceBtwInputField),
            // Product Description Input Field
            SizedBox(
              height: 300,
              child: TextFormField(
                expands: true,
                maxLines: null,
                textAlign: TextAlign.start,
                controller: controller.description,
                keyboardType: TextInputType.multiline,
                textAlignVertical: TextAlignVertical.top,
                validator: (value) =>
                    TValidator.validateEmptyText('Product Description', value),
                decoration: const InputDecoration(
                  labelText: 'Product Description',
                  hintText: 'Add your Product Description here...',
                  alignLabelWithHint: true,
                ), 
              ), 
            ), 
          ], 
        ), 
      ), 
    );
  }
}