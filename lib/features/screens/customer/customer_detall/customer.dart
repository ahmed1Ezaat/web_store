import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/customer/customer_detall/customer_detail_desktop.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/customer/customer_detall/customer_detail_mobile.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/customer/customer_detall/customer_detail_tablet.dart';

import '../../../../common/widgets/layouts/templates/site_layout.dart';

class CustomerDetailScreen extends StatelessWidget {
  const CustomerDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final customer = Get.arguments;
    final customerId = Get.parameters['id'];
    return TSiteTemplate(
      desktop: CustomerDetailDesktopScreen(customer: customer),
      tablet: CustomerDetailTabletScreen(customer: customer),
      mobile: CustomerDetailMobileScreen(customer: customer),
    );
  }
}