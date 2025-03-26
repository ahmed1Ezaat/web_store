import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:yt_ecommerce_admin_panel/data/models/product_model.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/product/create_product/brand_widget.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/product/create_product/variations_widget.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/product/create_product/visibility_widget.dart';
import '../../../../common/widgets/containers/rounded_container.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utillity.dart';
import '../create_product/additional_images.dart';
import '../create_product/attributes_widget.dart';
import '../create_product/bottom_navigation_widget.dart';
import '../create_product/categories_widget.dart';
import '../create_product/product_type_widget.dart';
import '../create_product/stock_pricing_widget.dart';
import '../create_product/thumbanail_widget.dart';
import '../create_product/title_description.dart';

class EditProductTabletScreen extends StatelessWidget {
  const EditProductTabletScreen({super.key, required this.product});
  final ProductModel product;

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:  ProductBottomNavigationButtons(product: product,),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              const TBreadcrumbWithHeading(
                returnToPreviousScreen: true,
                heading: 'Edit Product',
                breadcrumbItems: [TRoutes.products, 'Edit Product'],
              ),
              const SizedBox(height: TSizes.spaceBtwSection),
              // Create Product
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Expanded(
                  flex: TDeviceUtils.isTabletScreen(context) ? 2 : 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Basic Information

                      const ProductTitleAndDescription(),

                      const SizedBox(height: TSizes.spaceBtwSection),

                      // Stock & Pricing

                      TRoundedContainer(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Stock & Pricing',
                                style:
                                    Theme.of(context).textTheme.headlineSmall),

                            const SizedBox(height: TSizes.spaceBtwItem),

                            // Product Type
                            const ProductTypeWidget(),

                            const SizedBox(height: TSizes.spaceBtwInputField),

                            const ProductStockAndPricing(),

                            const SizedBox(height: TSizes.spaceBtwSection),

                            const ProductAttributes(),

                            const SizedBox(height: TSizes.spaceBtwSection),
                          ],
                        ),
                      ),
                      const ProductAttributes(),
                      const SizedBox(height: TSizes.spaceBtwSection),
                      const ProductVariations(),
                    ],
                  ),
                ),
                const SizedBox(width: TSizes.defaultSpace),
                Expanded(
                    child: Column(children: [
                  // Product Thumbnail
                  const ProductThumbnailImage(),
                  const SizedBox(height: TSizes.spaceBtwSection),

                  // Product Images
                  TRoundedContainer(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Text('All Product Images',
                            style: Theme.of(context).textTheme.headlineSmall),
                        const SizedBox(height: TSizes.spaceBtwItem),
                        ProductAdditionalImages(
                          additionalProductImagesURLs: RxList<String>.empty(),
                          onTapToAddImages: () {},
                          onTapToRemoveImage: (index) {},
                        ),
                      ])),
                  const SizedBox(height: TSizes.spaceBtwSection),
                  // Product Brand
                  const ProductBrand(),
                  const SizedBox(height: TSizes.spaceBtwSection),

                  // product Categories
                   ProductCategories(product: product,),
                  const SizedBox(height: TSizes.spaceBtwSection),

                  // Product visibility
                  const ProductVisibilityWidget(),
                  const SizedBox(height: TSizes.spaceBtwSection),
                ]))
              ])
            ],
          ),
        ),
      ),
    );
  }
}
