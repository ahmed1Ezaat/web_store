import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/icons/circualar_icon.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/loaders/loader_anmation.dart';
import 'package:yt_ecommerce_admin_panel/controllers/dashboard_controller.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:yt_ecommerce_admin_panel/utils/device/device_utillity.dart';

import '../../../../common/widgets/containers/rounded_container.dart';
import '../../../../utils/constants/colors.dart';

class TWeeklySalesGraph extends StatelessWidget {
  const TWeeklySalesGraph({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = DashboardController.instance;
    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              TCircularIcon(
                icon: Iconsax.graph,
                backgroundColor: Colors.brown.withOpacity(0.1),
                color: Colors.brown,
                size: TSizes.md,
              ),
          const SizedBox(height: TSizes.spaceBtwSection),
               Text('Weekly Sales',
                    style: Theme.of(context).textTheme.headlineSmall),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwSection),

          /// graph
          Obx(
            ()=> controller.weeklySales.isNotEmpty
             ? SizedBox(
                height: 400,
                child: BarChart(BarChartData(
                    titlesData: buildFlTitleData(controller.weeklySales),
                    borderData: FlBorderData(
                        show: true,
                        border: const Border(
                            top: BorderSide.none, right: BorderSide.none)),
                    gridData: const FlGridData(
                      show: true,
                      drawHorizontalLine: true,
                      drawVerticalLine: false,
                      horizontalInterval: 200,
                    ),
                    barGroups: controller.weeklySales
                        .asMap()
                        .entries
                        .map((entry) => BarChartGroupData(x: entry.key, barRods: [
                              BarChartRodData(
                                width: 30,
                                toY: entry.value,
                                color: TColors.primary,
                                borderRadius: BorderRadius.circular(TSizes.sm),
                              )
                            ]))
                        .toList(),
                    groupsSpace: TSizes.spaceBtwItem,
                    barTouchData: BarTouchData(
                        touchTooltipData: BarTouchTooltipData(
                            getTooltipColor: (_) => TColors.secondary),
                        touchCallback: TDeviceUtils.isDesktopScreen(context)
                            ? (barTouchEvent, barTouchResponse) {}
                            : null))))
                            : const SizedBox(height: 400, child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [TLodaerAnimation()],),)
          ),
        ],
      ),
    );
  }

  FlTitlesData buildFlTitleData(List<double> weeklySales) {
    double maxOrder = weeklySales.reduce((a, b) => a > b ? a : b).toDouble();
    double setHeight = (maxOrder / 10).ceilToDouble();
    return FlTitlesData(
      show: true,
      bottomTitles: AxisTitles(
          sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

                final index = value.toInt() % days.length;

                final day = days[index];

                return SideTitleWidget(
                    axisSide: AxisSide.bottom, space: 0, child: Text(day));
              })),
      leftTitles: AxisTitles(
          sideTitles: SideTitles(
              showTitles: true, interval: setHeight <= 0 ? 500: setHeight ,reservedSize: 50)),
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
    );
  }
}
