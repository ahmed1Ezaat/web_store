import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/product/create_product/create_product_mobile.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/product/create_product/create_product_tablet.dart';

import '../../../../common/widgets/layouts/templates/site_layout.dart';
import 'create_product_desktop.dart';

class CreateProductScreen extends StatelessWidget {
  const CreateProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Get.arguments;
    return   TSiteTemplate(
        desktop: CreateProductDesktopScreen(product: product,),
        mobile: CreateProductMobileScreen(product: product,),
        tablet: const CreateProductTabletScreen(),
        );
  }
}
