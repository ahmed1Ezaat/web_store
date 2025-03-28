import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/loaders/loader_anmation.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/order/all_orders/orders_table.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/order/order_controller.dart';

import '../../../../common/widgets/containers/rounded_container.dart';
import '../../../../common/widgets/data_table/table_header.dart';
import '../../../../utils/constants/sizes.dart';

class OrdersDesktopScreen extends StatelessWidget {
  const OrdersDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
    return  Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              const TBreadcrumbWithHeading(
                heading: 'Orders',
                breadcrumbItems: ['Orders'],
              ),
               const SizedBox(height: TSizes.spaceBtwSection),
              
              // Table Body
              TRoundedContainer(
                child: Column(
                  children: [
                    // Table Header
                      TTableHeader(
                      showLeftWidget: false,
                      searchController: controller.searchTextController,
                      searchOnChanged: (query) => controller.searchQuery(query),
                      ),
                      const SizedBox(height: TSizes.spaceBtwItem),
                    
                    // Table
                     Obx((){
                      if (controller.isLoading.value) return const TLodaerAnimation();
                      
                      return const OrderTable();
                    }),
                  ],
                ),
              ), 
            ],
          ),
        ),
      ), 
    ); 
  }
}