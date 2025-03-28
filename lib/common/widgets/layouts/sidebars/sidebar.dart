import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/images/t_circular_image.dart';
import 'package:yt_ecommerce_admin_panel/features/controllers/setting_controller.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/images_strings.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';

import '../../../../routes/routes.dart';
import '../../../../utils/constants/emums.dart';
import 'menu/menu_item.dart';

class TSidebar extends StatelessWidget {
  const TSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        shape: const RoundedRectangleBorder(),
        child: Container(
          decoration: const BoxDecoration(
              color: TColors.white,
              border: Border(right: BorderSide(color: TColors.grey, width: 1))),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Obx(
                      () => TCircularImage(
                        width: 60,
                        height: 60,
                        padding: 0,
                        margin: TSizes.sm,
                        image: SettingsController.instance.settings.value.appLogo.isNotEmpty ? SettingsController.instance.settings.value.appLogo : TImages.darkAppLogo,
                        imageType: SettingsController.instance.settings.value.appLogo.isNotEmpty ? ImageType.network : ImageType.asset,
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    Expanded(
                      child: Obx(
                        () => Text(
                          SettingsController.instance.settings.value.appName,
                          style: Theme.of(context).textTheme.headlineLarge,
                          overflow: TextOverflow.ellipsis,
                        )
                      )
                    )
                  ],
                ),
            
          const SizedBox(height: TSizes.spaceBtwSection),
          Padding(
            padding: const EdgeInsets.all(TSizes.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'MENU',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .apply(letterSpacingDelta: 1.2),
                ),

                const TMenuItem(
                    route: TRoutes.dashboard,
                    icon: Iconsax.status,
                    itemName: 'Dashboard'),
                const TMenuItem(
                    route: TRoutes.media,
                    icon: Iconsax.image,
                    itemName: 'Media'),
                const TMenuItem(
                    route: TRoutes.categories,
                    icon: Iconsax.category_2,
                    itemName: 'categories'),
                const TMenuItem(
                    route: TRoutes.brands,
                    icon: Iconsax.dcube,
                    itemName: 'Brands'),
                const TMenuItem(
                    route: TRoutes.banners,
                    icon: Iconsax.picture_frame,
                    itemName: 'Banners'),
                const TMenuItem(
                    route: TRoutes.products,
                    icon: Iconsax.shopping_bag,
                    itemName: 'Products'),
                const TMenuItem(
                    route: TRoutes.customers,
                    icon: Iconsax.profile_2user,
                    itemName: 'Customers'),
                const TMenuItem(
                    route: TRoutes.orders,
                    icon: Iconsax.box,
                    itemName: 'Orders'),
                // Other menu items
                Text(
                  "OTHERS",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .apply(letterSpacingDelta: 1.2),
                ),
                const TMenuItem(
                    route: TRoutes.profile,
                    icon: Iconsax.user,
                    itemName: 'Profile'),
                const TMenuItem(
                    route: TRoutes.settings,
                    icon: Iconsax.setting_2,
                    itemName: 'Settings'),
                const TMenuItem(
                    route: 'logout', icon: Iconsax.logout, itemName: 'Logout'),
              ],
            ),
          ),
              ],
            ),
        )
        )
        );
  }
}
