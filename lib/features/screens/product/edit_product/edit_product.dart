import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/product/edit_product/edit_product_mobile.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/product/edit_product_controller.dart';

import '../../../../common/widgets/layouts/templates/site_layout.dart';
import 'edit_product_desktop.dart';

class EditProductScreen extends StatelessWidget {
  const EditProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditProductController());
    final product = Get.arguments;
    controller.initProductData(product);
    
    return TSiteTemplate(
      desktop: EditProductDesktopScreen(product: product),
      mobile: EditProductMobileScreen(product: product),
    );
  }
}
