import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/layouts/templates/site_layout.dart';

import 'edit_category_desktop.dart';
import 'edit_category_mobile.dart';
import 'edit_category_tablet.dart';

class EditCategoryScreen extends StatelessWidget {
  const EditCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final category = Get.arguments;
    return TSiteTemplate(
      desktop: EditCategoryDesktopScreen(category: category),
      tablet: EditCategoryTabletScreen(category: category),
      mobile: EditCategoryMobileScreen(category: category),
    );
  }
}
