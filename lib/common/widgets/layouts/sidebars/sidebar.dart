import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/images/t_circular_image.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/images_strings.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';

import '../../../../routes/routes.dart';
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
          border: Border(right: BorderSide(color: TColors.grey, width: 1))

        ),
        child:  SingleChildScrollView(
          child: Column(
            children: [
              const TCircularImage(
                width: 100,
                height: 100,
                image: TImages.darkAppLogo, 
                backgroundColor: Colors.transparent,
              ),
              const SizedBox(height: TSizes.spaceBtwSection),
              Padding(padding:  const EdgeInsets.all(TSizes.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children:[
                  Text('MENU', style: Theme.of(context).textTheme.bodySmall!.apply(letterSpacingDelta: 1.2),),

                   const TMenuItem(route: TRoutes.dashboard, icon: Iconsax.status, itemName: 'Dashboard'),
                  const TMenuItem(route: TRoutes.media, icon: Iconsax.image, itemName: 'Media'),
                  const TMenuItem(route: TRoutes.categories, icon: Iconsax.category_2, itemName: 'categories'),
                  const TMenuItem(route: TRoutes.brands, icon: Iconsax.dcube, itemName: 'Brands'),
                  const TMenuItem(route: 'logout', icon: Iconsax.logout, itemName: 'Logout'),
                
                ],
              ),
              ), 
              

            ],
          )
        )
      ),
    );
  }
}
