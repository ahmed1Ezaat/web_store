import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:yt_ecommerce_admin_panel/controllers/dashboard_controller.dart';
import 'package:yt_ecommerce_admin_panel/controllers/helper_functions.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/emums.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';

class OrderRows extends DataTableSource {
  @override
  DataRow? getRow(int index) {
    final order = DashboardController.orders[index];

    return DataRow2(cells: [
      DataCell(Text(order.id,
          style: Theme.of(Get.context!)
              .textTheme
              .bodyLarge!
              .apply(color: TColors.primary))),
      DataCell(Text(order.formattedOrederDate)),
      const DataCell(Text('5 items')),
      DataCell(
        TRoundedContainer(
            radius: TSizes.cardRadiusSm,
            padding: const EdgeInsets.symmetric(
                vertical: TSizes.xs, horizontal: TSizes.md),
            backgroundColor: THelperFunctions.getOrderStatusColor(order.status as OrderStatus)
                .withOpacity(0.1),
            child: Text(
              order.status.capitalize.toString(),
              style: TextStyle(
                  color: THelperFunctions.getOrderStatusColor(order.status as OrderStatus)),
            )),
      ),
      DataCell(Text('\$${order.totalAmount}')),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => DashboardController.orders.length;

  @override
  int get selectedRowCount => 0;
}
