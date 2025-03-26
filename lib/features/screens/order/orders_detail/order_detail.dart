import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/order/orders_detail/orders_detail_mobil.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/order/orders_detail/orders_detail_tablet.dart';
import '../../../../common/widgets/layouts/templates/site_layout.dart';
import 'orders_detail_desktop.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final  order = Get.arguments;
    final orderId = Get.parameters['orderId'];
    return TSiteTemplate(
      desktop: OrderDetailDesktopScreen(order: order),
      tablet: OrderDetailTabletScreen(order: order),
      mobile: OrderDetailMobileScreen(order: order),
    );
  }
}