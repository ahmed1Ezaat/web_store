import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';

import '../../../../routes/routes.dart';
import '../../../../utils/constants/sizes.dart';

class EditBrandMobileScreen extends StatelessWidget {
  const EditBrandMobileScreen({super.key, required this.brand});

  final BrandModel brand;

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
                  returnToPreviousScreen: true,
                  heading: 'Update Brand',
                  breadcrumbItems: [TRoutes.categories, 'Update Brand']),
              const SizedBox(height: TSizes.spaceBtwSection),
              // Form
              EditBrandForm(brand: brand),
            ],
          ),
        ),
      ),
    );
  }
}
