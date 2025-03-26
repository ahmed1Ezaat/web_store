import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/colors.dart';

import '../../../../common/widgets/containers/rounded_container.dart';
import '../../../../common/widgets/images/t_rounded_image.dart';
import '../../../../utils/constants/emums.dart';
import '../../../../utils/constants/images_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utillity.dart';
import '../../../models/order_model.dart';
import 'pricing_calculator.dart';

class OrderItems extends StatelessWidget {
  const  OrderItems({
    super.key,
    required this.order,
  });

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final subTotal = order.items.fold(
        0.0,
        (previousValue, element) =>
            previousValue + (element.price * element.quantity));

    return TRoundedContainer(
      padding: const EdgeInsets.all(TSizes.defaultSpace), // 2. تصحيح الثابت
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Items', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: TSizes.spaceBtwSection),

          // Items List
          ListView.separated(
            shrinkWrap: true,
            itemCount: order.items.length,
            physics:
                const NeverScrollableScrollPhysics(), 
            separatorBuilder: (_, __) =>
                const SizedBox(height: TSizes.spaceBtwItem),
            itemBuilder: (_, index) {
              final item = order.items[index];
              return Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        TRoundedImage(
                          backgroundColor: TColors.primaryBackground,
                          imageType: item.image != null
                              ? ImageType.network
                              : ImageType.asset,
                          image: item.image ?? TImages.defaultImage,
                        ),
                        const SizedBox(width: TSizes.spaceBtwItem),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.title,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1),
                              if (item.selectedVariation != null)
                                Text(item.selectedVariation!.entries
                                    .map((e) => ('${e.key}: ${e.value}'))
                                    .toString()),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                      width: TSizes.spaceBtwItem), 

                  SizedBox(
                    width: TSizes.xl * 2,
                    child: Text(
                      '\$${item.price.toStringAsFixed(1)}', // 2. تصحيح تنسيق السعر
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),

                  SizedBox(
                    width: TDeviceUtils.isMobileScreen(context)
                        ? TSizes.xl * 1.4
                        : TSizes.xl * 2,
                    child: Text(
                      item.quantity.toString(),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),

                  SizedBox(
                      width: TDeviceUtils.isMobileScreen(context)
                          ? TSizes.xl * 1.4
                          : TSizes.xl * 2,
                      child: Text(
                        '\$${item.totalAmount}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      )),
                ],
              );
            },
          ),

          // Subtotal
          const SizedBox(height: TSizes.spaceBtwSection),
          // Item Total
          TRoundedContainer(
            padding:
                const EdgeInsets.all(TSizes.defaultSpace), 
            backgroundColor: TColors.primaryBackground, 
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Subtotal',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge), 
                    Text('\$$subTotal',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge), 
                  ],
                ),
                const SizedBox(
                    height:
                        TSizes.spaceBtwItem), 
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Discount',
                        style: Theme.of(context).textTheme.titleLarge),
                    Text('\$0.00',
                        style: Theme.of(context).textTheme.titleLarge),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwItem),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Shipping',
                        style: Theme.of(context).textTheme.titleLarge),
                    Text(
                      '\$${TPricingCalculator.calculateShippingCost(subTotal, '')}', 
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwItem),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Tax', style: Theme.of(context).textTheme.titleLarge),
                    Text(
                      '\$${TPricingCalculator.calculateTax(subTotal, '')}', 
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                const SizedBox(
                    height: TSizes
                        .spaceBtwItem), 
                const Divider(),
                const SizedBox(height: TSizes.spaceBtwItem),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total",
                        style: Theme.of(context).textTheme.titleLarge),
                    Text(
                      '\$${TPricingCalculator.calculateTotalPrice(subTotal, '')}', 
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
