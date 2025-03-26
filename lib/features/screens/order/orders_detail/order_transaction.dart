import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:yt_ecommerce_admin_panel/features/models/order_model.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:yt_ecommerce_admin_panel/utils/device/device_utillity.dart';

import '../../../../common/widgets/images/t_rounded_image.dart';
import '../../../../utils/constants/emums.dart';
import '../../../../utils/constants/images_strings.dart';

class OrderTransaction extends StatelessWidget {
  const OrderTransaction({super.key, required this.order});
  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Transaction',
              style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: TSizes.spaceBtwSection),
          Row(
            children: [
              Expanded(
                flex: TDeviceUtils.isMobileScreen(context) ? 2 : 1,
                child: Row(
                  children: [
                    const TRoundedImage(
                      imageType: ImageType.asset, 
                      image: TImages.paypal, 
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Payment via ${order.paymentMethod.capitalize}', 
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text(
                            '${order.paymentMethod.capitalize} fee \$25', 
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Date',
                        style: Theme.of(context).textTheme.labelMedium),
                    Text(
                    '10 6, 2003',
                      style: Theme.of(context).textTheme.bodyLarge,)
                    
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total',
                        style: Theme.of(context).textTheme.labelMedium),
                    Text('\$${order.totalAmount}', 
                      style: Theme.of(context).textTheme.bodyLarge
                    ),
                  ],
                ),
              ),
            ],
          )
        ]));
  }
}
