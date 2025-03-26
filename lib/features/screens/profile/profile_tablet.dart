import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';

import 'from.dart';
import 'image_meta.dart';

class ProfileTabletScreen extends StatelessWidget {
  const ProfileTabletScreen({super.key});

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
                   ProfileForm(), 
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}