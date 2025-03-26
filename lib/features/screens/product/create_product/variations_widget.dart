import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/data/models/product_variaition_model.dart';
import 'package:yt_ecommerce_admin_panel/features/controllers/product_image_controller.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/product/create_product_controller.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/product/product_variaition_controller.dart';

import '../../../../common/widgets/containers/rounded_container.dart';
import '../../../../common/widgets/images/image_uploader.dart';
import '../../../../common/widgets/images/t_rounded_image.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/emums.dart';
import '../../../../utils/constants/images_strings.dart';
import '../../../../utils/constants/sizes.dart';

class ProductVariations extends StatelessWidget {
  const ProductVariations({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final variationConroller = ProductVariationsController.instance;

    return Obx(
      () => CreateProductController.instance.productType.value ==
              ProductType.variable
          ? TRoundedContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Variations Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Product Variations',
                          style: Theme.of(context).textTheme.headlineSmall),
                      TextButton(
                          onPressed: () =>
                              variationConroller.removeVariation(context),
                          child: const Text('Remove Variations')),
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwItem),
                  // Variations List
                  if (variationConroller.productVariations.isNotEmpty)
                    ListView.separated(
                      itemCount: variationConroller.productVariations.length,
                      shrinkWrap: true,
                      separatorBuilder: (_, __) =>
                          const SizedBox(height: TSizes.spaceBtwItem),
                      itemBuilder: (_, index) {
                        final variation =
                            variationConroller.productVariations[index];
                        return _buildVariationTile(
                            context, index, variation, variationConroller);
                      },
                    )
                  else
                    _buildNoVariationsMessage(),
                ],
              ),
            )
          : const SizedBox.shrink(),
    );
  }

  // Helper method to build a variation tile

  Widget _buildVariationTile(
    BuildContext context,
    int index,
    ProductVariationModel variation,
    ProductVariationsController variationConroller,
  ) {
    return ExpansionTile(
      backgroundColor: TColors.lightGrey,
      collapsedBackgroundColor: TColors.lightGrey,
      childrenPadding: const EdgeInsets.all(TSizes.md),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(TSizes.borderRadiusLg)),
      title: Text(variation.attributeValues.entries
          .map((entry) => '${entry.key}: ${entry.value}')
          .join(',')),
      children: [
        // Upload Variation Image
        Obx(
          () => TImageUploader(
            right: 0,
            left: null,
            imageType: variation.image.value.isNotEmpty
                ? ImageType.network
                : ImageType.asset,
            image: variation.image.value.isNotEmpty
                ? variation.image.value
                : TImages.defaultImage,
            onIconButtonPressed: () => ProductImagesController.instance
                .selectVariantionImage(variation),
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwInputField),

        // Variation Stock, and Pricing
        Row(children: [
          Expanded(
            child: TextFormField(
              onChanged: (value) => variation.stock = int.parse(value),
              keyboardType: TextInputType.number,
              controller: variationConroller.stockControllerList[index]
                  [variation],
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                  labelText: 'Stock',
                  hintText: 'Add Stock, only numbers are allowed'),
            ),
          ),
          const SizedBox(width: TSizes.spaceBtwInputField),
          Expanded(
            child: TextFormField(
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$')),
              ],
              onChanged: (value) => variation.salePrice = double.parse(value),
              controller: variationConroller.priceControllerList[index]
                  [variation],
              decoration: const InputDecoration(
                  labelText: 'Price', hintText: 'Price with up-to 2 decimals'),
            ),
          ),
          const SizedBox(width: TSizes.spaceBtwInputField),
          Expanded(
            child: TextFormField(
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$')),
              ],
              onChanged: (value) => variation.salePrice = double.parse(value),
              controller: variationConroller.priceControllerList[index]
                  [variation],
              decoration: const InputDecoration(
                  labelText: 'Discounted Price',
                  hintText: 'Price with up-to 2 decimals'),
            ),
          ),
        ]),
        const SizedBox(height: TSizes.spaceBtwInputField),
        TextFormField(
          onChanged: (value) => variation.description = value,
          controller: variationConroller.descriptionControllerList[index]
              [variation],
          decoration: const InputDecoration(
              labelText: 'Description', prefixIcon: Icon(Icons.description)),
        ),
        const SizedBox(height: TSizes.spaceBtwItem),
      ],
    );
  }
    Widget _buildNoVariationsMessage() {
      return const Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TRoundedImage(
                  width: 200,
                  height: 200,
                  imageType: ImageType.asset,
                  image: TImages.defaultVariationImageIcon),
            ],
          ),
          // Row
          SizedBox(height: TSizes.spaceBtwItem),
          Text('There are no Variations added for this product'),
        ],
      );
    }
  }

