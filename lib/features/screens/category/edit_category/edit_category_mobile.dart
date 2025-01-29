import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/constants/sizes.dart';

class EditCategoryMobileScreen extends StatelessWidget {
  const EditCategoryMobileScreen({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const TBreadcrumbWithHeading(
                returnToPreviousScreen: true,
                heading: 'Update Category',
                breadcrumbItems: [TRoutes.categories, 'Update Category']),
            const SizedBox(height: TSizes.spaceBtwSection),

// Form
            EditCategoryForm(category: category),
          ]),
        ),
      ),
    );
  }
}
