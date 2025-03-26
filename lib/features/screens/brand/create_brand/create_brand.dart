import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/brand/create_brand/create_brand_mobile.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/brand/create_brand/create_brand_tablet.dart';

import 'creat_brand_desktop.dart';

class CreateBrandScreen extends StatelessWidget {
  const CreateBrandScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(
      desktop: CreateBrandDesktopScreen(),
      tablet: CreateBrandTabletScreen(),
      mobile: CreateBrandMobileScreen(),
    );
  }
}
