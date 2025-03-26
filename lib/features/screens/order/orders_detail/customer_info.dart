import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/images/t_rounded_image.dart';
import 'package:yt_ecommerce_admin_panel/features/models/order_model.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/order/order_detail_controller.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/emums.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/images_strings.dart';

import '../../../../utils/constants/sizes.dart';

class OrderCustomer extends StatelessWidget {
  const OrderCustomer({
    super.key,
    required this.order,
  });

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderDetailController());
    controller.order.value = order;
    controller.getCustomerOfCurrentOrder();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Customer Info
        TRoundedContainer(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Customer",
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: TSizes.spaceBtwSection),
              Obx(
                (){ return Row(
                  children: [
                   TRoundedImage(
                      padding: 0,
                      backgroundColor: TColors.primaryBackground,
                      image: controller.customer.value.profilePicture.isNotEmpty ? controller.customer.value.profilePicture : TImages.user,
                      imageType: controller.customer.value.profilePicture.isNotEmpty ? ImageType.network : ImageType.asset,
                    ),
                    const SizedBox(width: TSizes.spaceBtwItem),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.customer.value.fullName,
                            style: Theme.of(context).textTheme.titleLarge,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                           Text(
                            controller.customer.value.email,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
                }
              ),
            ],
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwSection),
        // Contact Info
        Obx(
          () => SizedBox(
            width: double.infinity,
            child: TRoundedContainer(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Contact Person',
                      style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: TSizes.spaceBtwSection),
                  Text(controller.customer.value.fullName,
                      style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(height: TSizes.spaceBtwItem / 2),
                  Text( controller.customer.value.email,
                      style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(height: TSizes.spaceBtwItem / 2),
                  Text( controller.customer.value.formattedPhoneNo.isNotEmpty ? controller.customer.value.formattedPhoneNo : '(+20) *** *** ****',
                      style: Theme.of(context).textTheme.titleSmall),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwSection),
        // Contact Info
        SizedBox(
          width: double.infinity,
          child: TRoundedContainer(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Shipping Address',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: TSizes.spaceBtwSection),
                Text(
                   order.shippingAddress != null ? order.shippingAddress!.name : '', 
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: TSizes.spaceBtwItem / 2),
                Text(
                   order.shippingAddress != null ? order.shippingAddress!.toString() : '',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwSection),
        SizedBox(
          width: double.infinity,
          child: TRoundedContainer(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Billing Address',
                    style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: TSizes.spaceBtwSection),
                Text( order.billingAddressSameAsShipping ? order.shippingAddress!.name : order.billingAddress!.name,
                    style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: TSizes.spaceBtwItem / 2),
                Text( order.billingAddressSameAsShipping ? order.shippingAddress!.toString() : order.billingAddress!.toString(),
                    style: Theme.of(context).textTheme.titleSmall),
              ],
            ),
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwSection),
      ],
    );
  }
}
