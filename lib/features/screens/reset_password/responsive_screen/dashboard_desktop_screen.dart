import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/data_table/data_table.dart';
import 'package:yt_ecommerce_admin_panel/features/controllers/product_image_controller.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/reset_password/widgets/dashboard_card.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/reset_password/widgets/order_status_graph.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/reset_password/widgets/weekly_sales.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';

class DashboardDesktopScreen extends StatelessWidget {
  const DashboardDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductImagesController());
    return Scaffold(
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // hiding
                      Text('Dashboard',
                          style: Theme.of(context).textTheme.headlineLarge),
                      ElevatedButton(
                          onPressed: () => controller.selectThumbnailImage(),
                          child: const Text('select single image')),
                      const SizedBox(height: TSizes.spaceBtwSection),
                      ElevatedButton(
                          onPressed: () => controller.selectMultipleProductImages(),
                          child: const Text('select multiple single image')),
                      const SizedBox(height: TSizes.spaceBtwSection),

                      // Cards
                      const Row(children: [
                        Expanded(
                            child: TDashboardCard(
                                title: 'Sales total',
                                subTitle: '\$365.6',
                                stats: 25)),
                        SizedBox(width: TSizes.spaceBtwItem),
                        Expanded(
                            child: TDashboardCard(
                                title: 'Average Order Value',
                                subTitle: '\$25',
                                stats: 15)),
                        SizedBox(width: TSizes.spaceBtwItem),
                        Expanded(
                            child: TDashboardCard(
                                title: 'Toal Orders',
                                subTitle: '36',
                                stats: 44)),
                        SizedBox(width: TSizes.spaceBtwItem),
                        Expanded(
                            child: TDashboardCard(
                                title: 'Visitors',
                                subTitle: '25,033',
                                stats: 2)),
                      ]),
                      const SizedBox(height: TSizes.spaceBtwSection),

                      //Graphs
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Column(children: [
                                TWeeklySalesGraph(),
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
