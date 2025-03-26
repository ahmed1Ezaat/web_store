import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/loaders/loader_anmation.dart';
import 'package:yt_ecommerce_admin_panel/controllers/dashboard_controller.dart';
import 'package:yt_ecommerce_admin_panel/controllers/helper_functions.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/emums.dart';
import 'package:yt_ecommerce_admin_panel/utils/device/device_utillity.dart';

import '../../../../utils/constants/sizes.dart';
import 'circular_container.dart';

class OrderStatusPieChart extends StatelessWidget {
  const OrderStatusPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = DashboardController.instance;
    return TRoundedContainer(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Order Status', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: TSizes.spaceBtwSection),

        // Graph
        Obx(() => controller.orderStatusData.isNotEmpty
            ? SizedBox(
                height: 400,
                child: PieChart(PieChartData(
                    sectionsSpace: 2,
                    centerSpaceRadius:
                        TDeviceUtils.isTabletScreen(context) ? 80 : 55,
                    startDegreeOffset: 180,
                    sections: controller.orderStatusData.entries.map((entry) {
                      final OrderStatus status = entry.key;
                      final int count = entry.value;

                      return PieChartSectionData(
                        showTitle: true,
                        radius: TDeviceUtils.isTabletScreen(context) ? 80 : 100,
                        title: '$count',
                        value: count.toDouble(),
                        color: THelperFunctions.getOrderStatusColor(status),
                        titleStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      );
                    }).toList(),
                    pieTouchData: PieTouchData(
                      touchCallback: (FlTouchEvent event, pieTouchResponse) {
                        //
                      },
                      enabled: true,
                    ))),
              )
            : const SizedBox(
                height: 400,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [TLodaerAnimation()],
                ),
              )),

        // show Status and color meta
        SizedBox(
          width: double.infinity,
          child: Obx(
            () => DataTable(
              columns: const [
                DataColumn(label: Text('Status')),
                DataColumn(label: Text('Orders')),
                DataColumn(label: Text('Total')),
              ],
              rows: controller.orderStatusData.entries.map((entry) {
                final OrderStatus status = entry.key;
                final int count = entry.value;
                final double totalAmount = controller.totalAmounts[status]!;
                final String displayStatus =
                    controller.getDisplayStatusName(status);
                return DataRow(cells: [
                  DataCell(
                    Row(
                      children: [
                        TCircularContainer(
                          width: 20,
                          height: 20,
                          backgroundColor:
                              THelperFunctions.getOrderStatusColor(status),
                        ),
                        Expanded(
                            child: Text(
                                '${controller.getDisplayStatusName(status)}')),
                      ],
                    ),
                  ),
                  DataCell(Text(count.toString())),
                  DataCell(Text('\$${totalAmount.toStringAsFixed(2)}')),
                ]);
              }).toList(),
            ),
          ),
        )
      ]),
    );
  }
}
