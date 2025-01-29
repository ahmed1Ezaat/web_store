 import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/data_table/paginated_data_table.dart';
import '../../../../utils/device/device_utillity.dart';
import 'table_source.dart';

class BrandTable extends StatelessWidget {
                    const BrandTable({super.key});
                
                    @override
                    Widget build(BuildContext context) {
                        return TPaginatedDataTable(
                            minWidth: 700,
                            tableHeight: 760,
                            dataRowHeight: 64,
                            columns: [
                                DataColumn2(
                                    label: const Text('Brand'),
                                    fixedWidth: TDeviceUtils.isMobileScreen(Get.context!) ? null : 200,
                                ), 
                                const DataColumn2(label: Text('Categories')),
                                DataColumn2(label: const Text('Featured'), fixedWidth: TDeviceUtils.isMobileScreen(Get.context!) ? null : 100),
                                DataColumn2(label: const Text('Date'), fixedWidth: TDeviceUtils.isMobileScreen(Get.context!) ? null : 200),
                                DataColumn2(label: const Text('Action'), fixedWidth: TDeviceUtils.isMobileScreen(Get.context!) ? null : 100),
                            ],
                            source: BrandRows(),
                        );
                    }
                }
            
        