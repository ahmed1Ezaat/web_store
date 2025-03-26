import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/layouts/templates/site_layout.dart';
import 'edit_banner_desketop.dart';
import 'edit_banner_mobile.dart';
import 'edit_banner_tablet.dart';

class EditBannerScreen extends StatelessWidget {
  const EditBannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final banner = Get.arguments;

    return TSiteTemplate(
      desktop: EditBannerDesktopScreen(banner: banner),
      tablet: EditBannerTabletScreen(banner: banner),
      mobile: EditBannerMobileScreen(banner: banner),
    );

// TSiteTemplate
  }
}
