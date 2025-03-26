import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/order/orders_detail/customer_info.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/order/orders_detail/order_items.dart';
import '../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../models/order_model.dart';
import 'order_info.dart';
import 'order_transaction.dart';

class OrderDetailDesktopScreen extends StatelessWidget {
  const OrderDetailDesktopScreen({
    super.key,
    required this.order,
  });

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              TBreadcrumbWithHeading(
                returnToPreviousScreen: true,
                heading: order.id,
                breadcrumbItems: const [TRoutes.orders, 'Details'],
              ),
              const SizedBox(height: TSizes.spaceBtwSection),

              // Body
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left Side Order Information
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        // Order Info
                        OrderInfo(order: order),
                        const SizedBox(height: TSizes.spaceBtwSection),

                        // Items
                        OrderItems(order: order),
                        const SizedBox(height: TSizes.spaceBtwSection),

                        // Transaction
                        OrderTransaction(order: order),
                      ],
                    ),
                  ),
                  const SizedBox(width: TSizes.spaceBtwSection),

                  // Right Side Customer Info
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        // Customer Info
                        OrderCustomer(order: order),
                        const SizedBox(height: TSizes.spaceBtwSection),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}