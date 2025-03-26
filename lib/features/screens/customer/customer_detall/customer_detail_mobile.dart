import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:yt_ecommerce_admin_panel/routes/routes.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';

import '../../../../data/models/user_model.dart';
import 'customer_info.dart';
import 'customer_ordets.dart';
import 'shipping_address.dart';

class CustomerDetailMobileScreen extends StatelessWidget {
  const CustomerDetailMobileScreen({
    super.key,
    required this.customer,
  });

  final UserModel customer;

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
              const TBreadcrumbWithHeading(
                returnToPreviousScreen: true,
                heading: 'Iainoor Sikander',
                breadcrumbItems: [TRoutes.customers, 'Details'],
              ),
              const SizedBox(height: TSizes.spaceBtwSection),

              // Body
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left Side Customer Information
                  Expanded(
                    child: Column(
                      children: [
                        // Customer Info
                        CustomerInfo(customer: customer),
                        const SizedBox(height: TSizes.spaceBtwSection),

                        // Shipping Address
                        const ShippingAddress(),
                      ],
                    ), 
                  ),
                  const SizedBox(width: TSizes.spaceBtwSection),

                  // Right Side Customer Orders
                  const Expanded(flex: 2, child: CustomerOrders()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}