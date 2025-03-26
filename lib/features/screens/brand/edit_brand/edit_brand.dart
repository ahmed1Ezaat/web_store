import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/layouts/templates/site_layout.dart';
import 'edit_brand_desktop.dart';
import 'edit_brand_mobile.dart';
import 'edit_brand_tablet.dart';

class EditBrandScreen extends StatelessWidget {
  const EditBrandScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final brand = Get.arguments;
    return TSiteTemplate(
      desktop: EditBrandDesktopScreen(brand: brand),
      tablet: EditBrandTabletScreen(brand: brand),
      mobile: EditBrandMobileScreen(brand: brand),
    );
  }
}
