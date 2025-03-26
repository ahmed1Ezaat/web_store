import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/emums.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/shimmer.dart';
import 'package:yt_ecommerce_admin_panel/utils/device/device_utillity.dart';

import '../../../../common/widgets/containers/rounded_container.dart';
import '../../../../controllers/helper_functions.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../models/order_model.dart';
import '../order_controller.dart';

class OrderInfo extends StatelessWidget {
  const OrderInfo({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
    controller.orderStatus.value = order.status;
    return TRoundedContainer(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Information',
            style: Theme.of(context)
                .textTheme
                .headlineMedium, 
          ),
          const SizedBox(height: TSizes.spaceBtwSection), 

          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Date'),
                    Text(
                      order.formattedOrederDate,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Items'),
                    Text(
                      '${order.items.length} Items', 
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: TDeviceUtils.isMobileScreen(context)
                    ? 2
                    : 1, 
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Status'),
                    Obx(
                      (){ 
                        if (controller.statusLoader.value) return  const TShimmerEffect(width: double.infinity, height: 55);
                        return TRoundedContainer(
                        radius: TSizes.cardRadiusSm,
                        padding: const EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: TSizes.sm,
                        ),
                        backgroundColor:
                            THelperFunctions.getOrderStatusColor(order.status)
                                .withOpacity(0.1),
                                child: DropdownButton<OrderStatus>(
                                  padding: const EdgeInsets.symmetric(vertical: 0),
                                  value: controller.orderStatus.value,
                                  onChanged: (OrderStatus? newValue) {
                                    if (newValue != null){
                                    controller.updateOrderStatus(order, newValue);
                                    }
                                  },
                                  items: OrderStatus.values.map((OrderStatus status) {
                                    return DropdownMenuItem<OrderStatus>(
                                      value: status,
                                      child: Text(
                                        status.name.capitalize.toString(),
                                        style: TextStyle(color: THelperFunctions.getOrderStatusColor(controller.orderStatus.value)),
                                      )
                                    );
                                  }).toList(),
                                ),
                          );
                      }
                    ),
                  ]
                )
                    ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Total'),
                    Text(
                      '\$${order.totalAmount}', 
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ), 
              ), 
            ],
          ),
        ],
      ),
    );
  }
}
