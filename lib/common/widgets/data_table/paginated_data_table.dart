import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/images_strings.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:yt_ecommerce_admin_panel/utils/popups/anmation_loder.dart';

class TPaginatedDataTable extends StatelessWidget {
  const TPaginatedDataTable({
    super.key,
    this.sortAscending = true,
    this.sortColumnIndex,
    this.rowsPerPage = 10,
    required this.source,
    required this.columns,
    this.tableHeight = 760,
    this.onPageChanged,
    this.dataRowHeight = TSizes.xl * 2,
    this.minWidth = 1000,
  });

  final bool sortAscending;
  final int? sortColumnIndex;
  final int rowsPerPage;
  final DataTableSource source;
  final List<DataColumn> columns;
  final Function(int)? onPageChanged;
  final double dataRowHeight;
  final double tableHeight;
  final double? minWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: tableHeight,
        child: Theme(
          data: Theme.of(context).copyWith(
              cardTheme: const CardTheme(color: Colors.white, elevation: 0)),
          child: PaginatedDataTable2(
            source: source,
            columns: columns,
            columnSpacing: 12,
            minWidth: minWidth,
            dividerThickness: 0,
            rowsPerPage: rowsPerPage,
            horizontalMargin: 12,
            showFirstLastButtons: true,
            showCheckboxColumn: true,
            sortAscending: sortAscending,
            onPageChanged: onPageChanged,
            dataRowHeight: dataRowHeight,
            renderEmptyRowsInTheEnd: false,
            onRowsPerPageChanged: (no0fRows) {},
            sortColumnIndex: sortColumnIndex,
            headingTextStyle: Theme.of(context).textTheme.titleMedium,
            headingRowColor: WidgetStateProperty.resolveWith(
                (states) => TColors.primaryBackground),
            empty: const TAnimationLoaderWidget(
                animation: TImages.packageAnimation,
                text: 'Nothing to Found',
                height: 200,
                width: 200),
            headingRowDecoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(TSizes.borderRadiusMd),
                topRight: Radius.circular(TSizes.borderRadiusMd),
                
              ),
            ),
            sortArrowBuilder: (bool ascending, bool sorted) {
                      if (sorted) {
                        return Icon(
                            ascending ? Iconsax.arrow_up_3 : Iconsax.arrow_down,
                            size: TSizes.iconSm);
                      } else {
                        return const Icon(
                          Iconsax.arrow_3,
                          size: TSizes.iconSm,
                        );
                      }
                    },
          ),
        ));
  }
}
