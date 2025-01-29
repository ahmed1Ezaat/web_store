import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';

import '../../../../routes/routes.dart';
import '../../../../utils/constants/sizes.dart';
import 'create_category_form.dart';

class CreateCategoryDesktopScreen extends StatelessWidget {
    const CreateCategoryDesktopScreen({super.key});

    @override

    Widget build(BuildContext context) {
        return const Scaffold(
            body: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.all(TSizes.defaultSpace),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            // Breadcrumbs
                            TBreadcrumbWithHeading(returnToPreviousScreen: true, heading: 'Create Category', breadcrumbItems: [TRoutes.categories, 'Create Category']),
                            SizedBox(height: TSizes.spaceBtwSection),

                            // Form
                            CreateCategoryForm(),
                        ],
                    ),
                ),
            ),
        );
    }
}
        