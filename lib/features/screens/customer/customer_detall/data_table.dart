import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/data_table/paginated_data_table.dart';
import '../../../../utils/device/device_utillity.dart';
import '../customer_detail_controller.dart';
import 'table_source.dart';

class CustomerOrderTable extends StatelessWidget {
  const CustomerOrderTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CustomerDetailController.instance;
    return Obx(
      (){
        Visibility(visible: false,child: Text(controller.filteredCustomerOrders.length.toString()));
        Visibility(visible: false,child: Text(controller.selectedRows.length.toString()));
         return TPaginatedDataTable(
        minWidth: 550,
        tableHeight: 640,
        dataRowHeight: kMinInteractiveDimension,
        sortAscending: controller.sortascending.value,
        sortColumnIndex: controller.sortColumnIndex.value,
        columns: [
           DataColumn2(label: const Text('Order ID'), onSort: (columnIndex, ascending) => controller.sortById(columnIndex, ascending)),
          const DataColumn2(label: Text('Date')),
          const DataColumn2(label: Text('Items')),
          DataColumn2(
            label: const Text('Status'),
            fixedWidth: TDeviceUtils.isMobileScreen(context) ? 100 : null,
          ),
          const DataColumn2(
            label: Text('Amount'),
            numeric: true,
          ),
        ],
        source: CustomerOrdersRows(),
      );
      }
    );
  }
}
