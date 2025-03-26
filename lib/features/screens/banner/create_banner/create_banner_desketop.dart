import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';

import '../../../../routes/routes.dart';
import 'create_banner_form.dart';

class CreateBannerDesktopScreen extends StatelessWidget {
  const CreateBannerDesktopScreen({super.key});

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
              TBreadcrumbWithHeading(
                  heading: 'Create Banner',
                  breadcrumbItems: [TRoutes.banners, 'Create Banner']),
              SizedBox(height: TSizes.spaceBtwSection),

// Form
              CreateBannerForm(),
            ],
          ),
        ),
      ),
    );
  }
}
