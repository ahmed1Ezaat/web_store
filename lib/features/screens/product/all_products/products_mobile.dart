import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/loaders/loader_anmation.dart';

import '../../../../common/widgets/containers/rounded_container.dart';
import '../../../../common/widgets/data_table/table_header.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../controllers/product_controller.dart';
import 'product_table.dart';

class ProductsMobileScreen extends StatelessWidget {
  const ProductsMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // BreadCrumbs
              const TBreadcrumbWithHeading(
                heading: 'Products',
                breadcrumbItems: ['Products'],
              ),
              const SizedBox(height: TSizes.spaceBtwSection),

              // Table Body
              Obx(
                (){ 
                  if (controller.isLoading.value) return const TLodaerAnimation();
                  return TRoundedContainer(
                  child: Column(
                    children: [
                      // Table Header
                      TTableHeader(
                        buttonText: 'Create Product',
                        onPressed: () => Get.toNamed(TRoutes.createProduct),
                        searchOnChanged: (query) => controller.searchQuery(query),
                      ),
                      const SizedBox(height: TSizes.spaceBtwItem),
                
                      // Table
                      const ProductsTable(),
                    ],
                  ),
                );
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
