import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/loaders/loader_anmation.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/customer/customer_detail_controller.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/customer/customer_detall/data_table.dart';
import 'package:yt_ecommerce_admin_panel/utils/popups/anmation_loder.dart';

import '../../../../common/widgets/containers/rounded_container.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/images_strings.dart';
import '../../../../utils/constants/sizes.dart';

class CustomerOrders extends StatelessWidget {
  const CustomerOrders({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = CustomerDetailController.instance;
    controller.getCustomerOrders();
    return TRoundedContainer(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Obx(
        () { 
          if (controller.ordersLoading.value) return const TLodaerAnimation();
          if (controller.allCustomerOrders.isEmpty) {
            return  const TAnimationLoaderWidget(text: 'No Orders Found', animation: TImages.productsIllustrion);
          }
          final totalAmount = controller .allCustomerOrders.fold(0.0, (previousValue, element) => previousValue + element.totalAmount);
          return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // 1
              children: [
                Text('Orders',
                    style: Theme.of(context).textTheme.headlineMedium), // 2
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(text: 'Total Spent '),
                      TextSpan(
                        text: '\$${totalAmount.toString()}',
                        style: Theme.of(context).textTheme.bodyLarge!.apply(
                              color: TColors.primary,
                            ),
                      ),
                      TextSpan(
                        text: ' on ${controller.allCustomerOrders.length} Orders',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwItem), // 5
            TextFormField(
              controller: controller.searchTextController,
              onChanged: (query) => controller.searchQuery(query),
              decoration: const InputDecoration(
                hintText: 'Search Orders',
                prefixIcon: Icon(Iconsax.search_normal), // 7
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSection),
            const CustomerOrderTable(),
          ],
        );},
      ),
    );
  }
}
