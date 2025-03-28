import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/brand/brand_controller.dart';

import '../../../../common/widgets/data_table/table_action_icon_buttons.dart';
import '../../../../common/widgets/images/t_rounded_image.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/emums.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utillity.dart';

class BrandRows extends DataTableSource {
  final controller = BrandController.instance;
  @override
  DataRow? getRow(int index) {
    final brand = controller.filteredItems[index];
    
    return DataRow2(
      selected: controller.selectedRows[index],
      onSelectChanged: (value) => controller.selectedRows[index] = value ?? false,
      cells: [
      DataCell(
        Row(
          children: [
            TRoundedImage(
              width: 50,
              height: 50,
              padding: TSizes.sm,
              image: brand.image,
              imageType: ImageType.network,
              borderRadius: TSizes.borderRadiusMd,
              backgroundColor: TColors.primaryBackground,
            ),
            const SizedBox(width: TSizes.spaceBtwItem),
            Expanded(
              child: Text(
                brand.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(Get.context!)
                    .textTheme
                    .bodyLarge!
                    .apply(color: TColors.primary),
              ),
            ),
          ],
        ),
      ),
      DataCell(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: TSizes.sm),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Wrap(
              spacing: TSizes.xs,
              direction: TDeviceUtils.isMobileScreen(Get.context!)
                  ? Axis.vertical
                  : Axis.horizontal,
              children: 
                brand.brandCategories != null
                ? brand.brandCategories!
                .map(
                  (e) =>
                Padding(
                  padding: EdgeInsets.only(
                      bottom: TDeviceUtils.isMobileScreen(Get.context!)
                          ? 0
                          : TSizes.xs),
                  child: Chip(
                      label: Text(e.name),
                      padding: const EdgeInsets.all(TSizes.xs))
                ), 
                )
                .toList()
                : [ const SizedBox()],
            ),
          ),
        ),
      ),
       DataCell(brand.isFeatured ? const Icon(Iconsax.heart5, color: TColors.primary) : const Icon(Iconsax.heart)),
      DataCell(Text(brand.createAt != null ? brand.formattedDate : '')),
      DataCell(
        TTableActionButtons(
          onEditPressed: () => Get.toNamed(TRoutes.editBrand, arguments: brand),
          onDeletePressed: () => controller.confirmAndDeleteItem(brand),
        ),
      ),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.filteredItems.length;

  @override
  int get selectedRowCount => controller.selectedRows.where((selected) => selected).length;
}
