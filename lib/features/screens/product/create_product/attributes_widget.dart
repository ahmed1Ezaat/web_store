import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/product/create_product_controller.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/product/product_attributes_controller.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/product/product_variaition_controller.dart';

import '../../../../common/widgets/containers/rounded_container.dart';
import '../../../../common/widgets/images/t_rounded_image.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/emums.dart';
import '../../../../utils/constants/images_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utillity.dart';
import '../../login/responsive_screens/widgets/validation.dart';

class ProductAttributes extends StatelessWidget {
  const ProductAttributes({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final productController = CreateProductController.instance;
    final attributeController = Get.put( ProductAttributesController());
    final variationController = Get.put(ProductVariationsController());


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Obx(() {
          return productController.productType.value == ProductType.single
          ?  const Column(children: [
              Divider(color: TColors.primaryBackground),
         SizedBox(height: TSizes.spaceBtwSection),
          ])
          : const SizedBox.shrink();
        }),
        Text('Add Product Attributes',
            style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: TSizes.spaceBtwItem),
// Form to add new attribute
        Form(
          key: attributeController.attributesFormKey,
            child: TDeviceUtils.isDesktopScreen(context)
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildAttributeName(attributeController),
                      ),
                      const SizedBox(width: TSizes.spaceBtwItem),
                      Expanded(
                        flex: 2,
                        child: _buildAttributes(attributeController),
                      ),
                      const SizedBox(width: TSizes.spaceBtwItem),
                      _buildAddAttributeButton(attributeController),
                    ],
                  )
                : Column(
                    children: [
                      _buildAttributeName(attributeController),
                      const SizedBox(height: TSizes.spaceBtwItem),
                      _buildAttributes(attributeController),
                      const SizedBox(height: TSizes.spaceBtwItem),
                      _buildAddAttributeButton(attributeController),
                    ],
                  )),
        const SizedBox(height: TSizes.spaceBtwSection),
        Text('All Attributes',
            style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: TSizes.spaceBtwItem),
        TRoundedContainer(
          backgroundColor: TColors.primaryBackground,
          child: Obx(
            () => attributeController.productAttributes.isNotEmpty
            ? ListView.separated(
              shrinkWrap: true,
              itemCount: attributeController.productAttributes.length,
              separatorBuilder: (_,__)=> const SizedBox(height: TSizes.spaceBtwItem),
              itemBuilder: (_,index){
                return Container(
                  decoration: BoxDecoration(
                    color: TColors.white,
                    borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
                  ),
                  child: ListTile(
                    title: Text(attributeController.productAttributes[index].name ?? ''),
                    subtitle: Text(attributeController.productAttributes[index].values!.map((e) => e.trim()).toString()),
                    trailing: IconButton(
                      onPressed: () => attributeController.removeAttribute(index, context),
                      icon: const Icon(Iconsax.trash, color: TColors.error),
                    ),
                  ),
                );
              }
            )
            : const Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TRoundedImage(
                      width: 150,
                      height: 80,
                      imageType: ImageType.asset,
                      image: TImages.defaultAttributeColorsImageIcon),
                  ]
                ),
                  SizedBox(height: TSizes.spaceBtwItem),
                  Text('There are no attributes added for this product'),
              ],
            ),
          ),
        ),
        Obx(
          () => productController.productType.value == ProductType.variable && variationController.productVariations.isEmpty
          ? Center(
            child: SizedBox(
              width: 200,
              child: ElevatedButton.icon(
                icon: const Icon(Iconsax.activity),
                label: const Text('Generate Variations'),
                onPressed: () => variationController.generateVariationsConfirmation(context),
              ),
            ),
          )
          : const SizedBox.shrink(),
        ),
      ],
    );
  }


  Column buildEmptyAttributes() {
    return const Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TRoundedImage(
                width: 150,
                height: 80,
                imageType: ImageType.asset,
                image: TImages.defaultAttributeColorsImageIcon),
          ],
        ), // Row
        SizedBox(height: TSizes.spaceBtwItem),
        Text('There are no attributes added for this product'),
      ],
    ); // Column
  }

  ListView buildAttributesList(BuildContext context) {
    return ListView.separated(
      itemCount: 3,
      shrinkWrap: true,
      separatorBuilder: (_, __) => const SizedBox(height: TSizes.spaceBtwItem),
      itemBuilder: (_, index) {
        return Container(
          decoration: BoxDecoration(
            color: TColors.white,
            borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
          ),
          child: ListTile(
            title: const Text('Color'),
            subtitle: const Text('Green, Orange, Pink'),
            trailing: IconButton(
              onPressed: () {},
              icon: const Icon(Iconsax.trash, color: TColors.error),
            ),
          ),
        );
      },
    );
  }

  SizedBox _buildAddAttributeButton(
    ProductAttributesController controller
  ) {
    return SizedBox(
      width: 100,
      child: ElevatedButton.icon(
        onPressed: () => controller.addNewAttribute(),
        icon: const Icon(Iconsax.add),
        style: ElevatedButton.styleFrom(
          foregroundColor: TColors.black,
          backgroundColor: TColors.secondary,
          side: const BorderSide(color: TColors.secondary),
        ),
        label: const Text('Add'),
      ),
    );
  }

  // Build text form field for attribute name
  TextFormField _buildAttributeName(
    ProductAttributesController controller
  ) {
    return TextFormField(
      controller: controller.attributeName,
      validator: (value) =>
          TValidator.validateEmptyText('Attribute Name', value),
      decoration: const InputDecoration(
          labelText: 'Attribute Name', hintText: 'Colors, Sizes, Material'),
    );
  }

  // Build text form field for attribute values
  SizedBox _buildAttributes(
    ProductAttributesController controller
  ) {
    return SizedBox(
      height: 80,
      child: TextFormField(
        expands: true,
        maxLines: null,
        textAlign: TextAlign.start,
        controller: controller.attributes,
        keyboardType: TextInputType.multiline,
        textAlignVertical: TextAlignVertical.top,
        validator: (value) =>
            TValidator.validateEmptyText('Attributes Field', value),
        decoration: const InputDecoration(
          labelText: 'Attributes',
          hintText:
              'Add attributes separated by | Example: Green | Blue | Yellow',
          alignLabelWithHint: true,
        ),
      ),
    );
  }
}
