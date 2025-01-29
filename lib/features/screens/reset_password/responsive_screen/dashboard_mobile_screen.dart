import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/reset_password/widgets/dashboard_card.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/reset_password/widgets/order_status_graph.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/reset_password/widgets/weekly_sales.dart';

import '../../../../common/widgets/data_table/data_table.dart';
import '../../../../utils/constants/sizes.dart';

class DashboardMobileScreen extends StatelessWidget {
  const DashboardMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Dashboard', style: Theme.of(context).textTheme.headlineLarge),
              const SizedBox(height: TSizes.spaceBtwSection),

              // Cards
                const TDashboardCard(title: 'Sales total', subTitle: '\$365.6', stats: 25),
                const SizedBox(height: TSizes.spaceBtwItem),
                const TDashboardCard(title: 'Average Order Value', subTitle: '\$25', stats: 15),
                const SizedBox(height: TSizes.spaceBtwItem),
                const TDashboardCard(title: 'Toal Orders', subTitle: '36', stats: 44),
                const SizedBox(height: TSizes.spaceBtwItem),
                const TDashboardCard(title: 'Visitors', subTitle: '25,033', stats: 2),
                const SizedBox(height: TSizes.spaceBtwSection),
                

                  //Bar Graph
              const TWeeklySalesGraph(),
              const SizedBox(height: TSizes.spaceBtwSection),

              /// Graders
               TRoundedContainer(
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Recent Orders', style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: TSizes.spaceBtwSection),
                  const DashboardOrderTable(),
                ]
              )
              ),
              const SizedBox(height: TSizes.spaceBtwSection),

              //pie chart
              const OrderStatusPieChart(),
            ]
          )
        )
      )
    );
  }
}