import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:yt_ecommerce_admin_panel/routes/routes.dart';

import '../../../../data/models/banner_model.dart';
import '../../../../utils/constants/sizes.dart';
import 'edit_banner_form.dart';

class EditBannerMobileScreen extends StatelessWidget {
  const EditBannerMobileScreen({super.key, required this.banner});
  final BannerModel banner;
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
                  heading: 'Update Banner',
                  breadcrumbItems: [TRoutes.categories]),
              const SizedBox(height: TSizes.spaceBtwSection),
// Form
              EditBannerForm(banner: banner),
            ],
          ),
        ),
      ),
    );
  }
}
