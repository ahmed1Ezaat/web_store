import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/data_table/data_table.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/reset_password/widgets/dashboard_card.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/reset_password/widgets/order_status_graph.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/reset_password/widgets/weekly_sales.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';

import '../../../../controllers/dashboard_controller.dart';
import '../../../../utils/constants/colors.dart';

class DashboardDesktopScreen extends StatelessWidget {
  const DashboardDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardController());
    return Scaffold(
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // hiding
                      Text('Dashboard',style: Theme.of(context).textTheme.headlineLarge),
                      const SizedBox(height: TSizes.spaceBtwItem),
                    
                      // Cards
                       Row(
                        children: [
                        Expanded(
                            child: Obx(
                            ()=> TDashboardCard(
                                  title: 'Sales total',
                                  subTitle: '\$${controller.orderController.allItems.fold(0.0, (previonusValue, element) => previonusValue + element.totalAmount).toStringAsFixed(2)}',
                                  stats: 25, headingIconColor: Colors.blue, headingIconBgColor: Colors.blue.withOpacity(0.1), context: context, headerIcon: Iconsax.note,),
                            )),
                        const SizedBox(width: TSizes.spaceBtwItem),
                        Expanded(
                            child: Obx(
                              () => TDashboardCard(
                                  headerIcon: Iconsax.external_drive,
                                  headingIconColor: Colors.green,
                                  headingIconBgColor: Colors.green.withOpacity(0.1),
                                  context: context,
                                  title: 'Average Order Value',
                                  subTitle: '\$${(controller.orderController.allItems.fold(0.0, (previonusValue, element) => previonusValue + element.totalAmount)/controller.orderController.allItems.length).toStringAsFixed(2)}',
                                  stats: 15,
                                  icon: Iconsax.arrow_down,
                                  color: TColors.error,
                                  ),
                            )),
                        const SizedBox(width: TSizes.spaceBtwItem),
                           Expanded(
                            child: Obx(
                              ()=> TDashboardCard(
                                  headerIcon: Iconsax.box,
                                  headingIconColor: Colors.deepPurple,
                                  headingIconBgColor: Colors.deepPurple.withOpacity(0.1),
                                  context: context,
                                  title: 'Toal Orders',
                                  subTitle: '\$${controller.orderController.allItems.length}',
                                  stats: 44),
                            )),
                        const SizedBox(width: TSizes.spaceBtwItem),
                        Expanded(
                            child: Obx(
                              ()=> TDashboardCard(
                                  headerIcon: Iconsax.user,
                                  headingIconColor: Colors.deepOrange,
                                  headingIconBgColor: Colors.deepPurple.withOpacity(0.1),
                                  context: context,
                                  title: 'Visitors',
                                  subTitle: controller.customerController.allItems.length.toString(),
                                  stats: 2),
                            )),
                      ]),
                      const SizedBox(height: TSizes.spaceBtwSection),

                      //Graphs
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Column(children: [
                                const TWeeklySalesGraph(),
                                const SizedBox(height: TSizes.spaceBtwSection),
                                TRoundedContainer(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                      Text('Recent Orders',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall),
                                      const SizedBox(
                                          height: TSizes.spaceBtwSection),
                                      const DashboardOrderTable(),
                                    ])),
                              ]),
                            ),
                            const SizedBox(width: TSizes.spaceBtwSection),
                            const Expanded(child: OrderStatusPieChart()),
                          ])
                    ]))));
  }
}
