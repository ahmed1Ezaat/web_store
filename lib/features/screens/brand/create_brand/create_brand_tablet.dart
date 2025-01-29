import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:yt_ecommerce_admin_panel/routes/routes.dart';

import '../../../../utils/constants/sizes.dart';
import 'create_brend_form.dart';

class CreateBrandTabletScreen extends StatelessWidget {
    const CreateBrandTabletScreen({super.key});

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
                            TBreadcrumbWithHeading(returnToPreviousScreen: true, heading: 'Create Brand', breadcrumbItems: [TRoutes.categories, 'Create Brand']),
                            SizedBox(height: TSizes.spaceBtwSection),

                            // Form
                            CreateBrandForm(),
                        ],
                    ),
                ),
            ),
        );
    }
}
