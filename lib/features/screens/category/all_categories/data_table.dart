import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/widgets.dart';

import '../../../../common/widgets/data_table/paginated_data_table.dart';
import 'table_socrce.dart';

class CategoryTable extends StatelessWidget {
  const CategoryTable({super.key});

  @override
  Widget build(BuildContext context) {
  return TPaginatedDataTable(

    minWidth: 700,

    columns: const [

        DataColumn2(label: Text('Category')),

        DataColumn2(label: Text('Parent Category')),

        DataColumn2(label: Text('Featured')),

        DataColumn2(label: Text('Date')),

        DataColumn2(label: Text('Action'), fixedWidth: 100),

    ],

    source: CategoryRows(),

);
  }
}