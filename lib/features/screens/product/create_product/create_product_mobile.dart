import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:yt_ecommerce_admin_panel/data/models/product_model.dart';
import 'package:yt_ecommerce_admin_panel/features/controllers/product_image_controller.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/product/create_product/additional_images.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/product/create_product/attributes_widget.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/product/create_product/bottom_navigation_widget.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/product/create_product/brand_widget.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/product/create_product/categories_widget.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/product/create_product/product_type_widget.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/product/create_product/stock_pricing_widget.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/product/create_product/thumbanail_widget.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/product/create_product/title_description.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/product/create_product/variations_widget.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/product/create_product/visibility_widget.dart';
import '../../../../common/widgets/containers/rounded_container.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/constants/sizes.dart';

class CreateProductMobileScreen extends StatelessWidget {
  const CreateProductMobileScreen({super.key, required this.product});
  final ProductModel product ;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductImagesController());
    
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
                heading: 'Create Product',
                breadcrumbItems: [TRoutes.products, 'Create Product'],
              ),
              const SizedBox(height: TSizes.spaceBtwSection),
              
              // Main Content
              Column(
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
                        Text('Stock & Pricing', style: Theme.of(context).textTheme.headlineSmall),
                        const SizedBox(height: TSizes.spaceBtwItem),
                        const ProductTypeWidget(),
                        const SizedBox(height: TSizes.spaceBtwInputField),
                        const ProductStockAndPricing(),
                        const SizedBox(height: TSizes.spaceBtwSection),
                        const ProductAttributes(),
                        const SizedBox(height: TSizes.spaceBtwSection),
                      ],
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSection),
                  
                  // Product Variations
                  const ProductVariations(),
                  const SizedBox(height: TSizes.spaceBtwSection),

                  // Right Side (Sidebar)
                  const ProductThumbnailImage(),
                  const SizedBox(height: TSizes.spaceBtwSection),

              // Product Images
              TRoundedContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('All Product Images', style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height: TSizes.spaceBtwItem),
                    ProductAdditionalImages(
                      additionalProductImagesURLs: controller.additionalProductImagesUrls,
                      onTapToAddImages: () => controller.selectMultipleProductImages(), // يجب استبدال هذا بمنطق مناسب
                      onTapToRemoveImage: (index) => controller.removeImage(index),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSection),
              
              // Product Brand
              const ProductBrand(),
              const SizedBox(height: TSizes.spaceBtwSection),
              
              // Product Categories
               ProductCategories(product: product),
              const SizedBox(height: TSizes.spaceBtwSection),
              
              // Product Visibility
              const ProductVisibilityWidget(),
              const SizedBox(height: TSizes.spaceBtwSection),
            ],
          ),
            ],
          )
      ),
    )
    );
  }
}