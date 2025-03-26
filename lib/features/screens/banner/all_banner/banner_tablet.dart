import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/loaders/loader_anmation.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/banner/all_banner/data_table.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';

import '../../../../common/widgets/containers/rounded_container.dart';
import '../../../../common/widgets/data_table/table_header.dart';
import '../banner_controller.dart';

class BannersTabletScreen extends StatelessWidget {
  const BannersTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // Breadcrumbs
              const TBreadcrumbWithHeading(
                  heading: 'Banners', breadcrumbItems: ['Banners']),
              const SizedBox(height: TSizes.spaceBtwSection),

              Obx(
                (){
                  if(controller.isLoading.value) return const TLodaerAnimation();
                  return const TRoundedContainer(
                  child: Column(
                    children: [
                      // Table Header
                      TTableHeader(),
                      SizedBox(height: TSizes.spaceBtwItem),
                
                      // Table
                      BannersTable(),
                    ],
                  ),
                );
                }
              ),
            ])),
      ),
    );
  }
}
