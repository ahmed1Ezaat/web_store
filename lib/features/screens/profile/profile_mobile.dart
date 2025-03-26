import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/profile/from.dart';

import '../../../utils/constants/sizes.dart';
import 'image_meta.dart';

class ProfileMobileScreen extends StatelessWidget {
  const ProfileMobileScreen({super.key});

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
                heading: 'Profile',
                breadcrumbItems: ['Profile'],
              ),
              SizedBox(height: TSizes.spaceBtwSection),

              // Main Content
              Column(
                children: [
                  ImageAndMeta(),
                  SizedBox(height: TSizes.spaceBtwSection),
                  ProfileForm(), // Profile Form Widget
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}