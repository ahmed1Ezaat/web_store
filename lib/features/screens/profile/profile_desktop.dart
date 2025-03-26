import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/profile/from.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/profile/image_meta.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';

class ProfileDesktopScreen extends StatelessWidget {
  const ProfileDesktopScreen({super.key});

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

              // Body
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Pic and Meta
                  Expanded(child: ImageAndMeta()),
                   SizedBox(width: TSizes.spaceBtwSection),
                  
                  // Form
                   Expanded(flex: 2, child: ProfileForm()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}