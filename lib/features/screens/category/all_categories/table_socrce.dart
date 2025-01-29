import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/emums.dart';

import '../../../../common/widgets/data_table/table_action_icon_buttons.dart';
import '../../../../common/widgets/images/t_rounded_image.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/images_strings.dart';
import '../../../../utils/constants/sizes.dart';

class CategoryRows extends DataTableSource {
  @override
  DataRow? getRow(int index) {
    return DataRow2(cells: [
      DataCell(Row(
        children: [
          const TRoundedImage(
            width: 50,
            height: 50,
            padding: TSizes.sm,
            image: TImages.acerLogo,
            imageType: ImageType.asset,
            borderRadius: TSizes.borderRadiusMd,
            backgroundColor: TColors.primaryBackground,
          ),
          // TRoundedImage
          const SizedBox(width: TSizes.spaceBtwItem),
          Expanded(
            child: Text(
              'Name',
              style: Theme.of(Get.context!)
                  .textTheme
                  .bodyLarge!
                  .apply(color: TColors.primary),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

// Text
          ),
        ],
      )),

      const DataCell( Text('Parent')),
      const DataCell(Icon(Iconsax.heart5, color: TColors.primary)),
      DataCell(Text(DateTime.now().toString())),
      DataCell(
        TTableActionButtons(
          onEditPressed: () =>
              Get.toNamed(TRoutes.editCategory, arguments: 'category'),
          onDeletePressed: () {},
        ), // TTableActionButtons
      ), // DataCell
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => 5;

  @override
  int get selectedRowCount => 0;
}
