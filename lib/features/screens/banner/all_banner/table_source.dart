import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/data_table/table_action_icon_buttons.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/images/t_rounded_image.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/banner/banner_controller.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/emums.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';

import '../../../../routes/routes.dart';

class BannersRows extends DataTableSource {
  final controller = BannerController.instance;
  @override
  DataRow? getRow(int index) {
    final banner = controller.filteredItems[index];
    return DataRow2(
      selected: controller.selectedRows[index],
      onTap: () => Get.toNamed(TRoutes.editBanner, arguments: banner),
      onSelectChanged: (value) => controller.selectedRows[index] = value ?? false,
      cells: [
         DataCell(
          TRoundedImage(
            width: 180,
            height: 100,
            padding: TSizes.sm,
            image: banner.imageUrl,
            imageType: ImageType.network,
            borderRadius: TSizes.borderRadiusMd,
            backgroundColor: TColors.primaryBackground,
          ), 
        ),  
         DataCell(Text( controller.formatRoute(banner.targetScreen))),
         DataCell( banner.active ? const Icon(Iconsax.eye, color: TColors.primary): const Icon(Iconsax.eye_slash)),
        DataCell(
          TTableActionButtons(
            onEditPressed: () => Get.toNamed(TRoutes.editBanner,
                arguments: banner),
            onDeletePressed: () => controller.confirmAndDeleteItem(banner),
          ), 
        ), 
      ], 
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.filteredItems.length;

  @override
  int get selectedRowCount => controller.selectedRows.where((selected) => selected).length;
}
