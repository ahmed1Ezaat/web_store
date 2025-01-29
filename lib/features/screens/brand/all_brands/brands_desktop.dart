import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../common/widgets/containers/rounded_container.dart';
import '../../../../common/widgets/data_table/table_header.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/constants/sizes.dart';

class BrandsDesktopScreen extends StatelessWidget {
  const BrandsDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              const TBreadcrumbWithHeading(
                  heading: 'Brands', breadcrumbItems: ['Brands']),
              const SizedBox(height: TSizes.spaceBtwSection),
              // Table Body
              TRoundedContainer(
                child: Column(
                  children: [
                    // Table Header
                    TTableHeader(
                        buttonText: 'Create New Brand',
                        onPressed: () => Get.toNamed(TRoutes.createBrand)),
                    const SizedBox(height: TSizes.spaceBtwItem),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}