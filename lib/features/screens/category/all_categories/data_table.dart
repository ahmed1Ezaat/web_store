import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/category/all_categories/category_controller.dart';

import '../../../../common/widgets/data_table/paginated_data_table.dart';
import 'table_socrce.dart';

class CategoryTable extends StatelessWidget {
  const CategoryTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());
  return Obx(
    () { 
      Text(controller.filteredItems.length.toString());
      Text(controller.selectedRows.length.toString());

      return TPaginatedDataTable(
      sortAscending: controller.sortAscending.value,
      sortColumnIndex: controller.sortColumnIndex.value,
      minWidth: 700,
      columns:  [
          DataColumn2(label: const Text('Category'), onSort: (columnIndex, ascending) => controller.sortByName(columnIndex, ascending)),
    
          const DataColumn2(label: Text('Parent Category')),
    
          const DataColumn2(label: Text('Featured')),
    
          const DataColumn2(label: Text('Date')),
    
          const DataColumn2(label: Text('Action'), fixedWidth: 100),
    
      ],
    
      source: CategoryRows(),
    
    );
    }
  );
  }
}