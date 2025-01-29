import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/controllers/dashboard_controller.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:yt_ecommerce_admin_panel/utils/device/device_utillity.dart';

import '../../../../common/widgets/containers/rounded_container.dart';
import '../../../../utils/constants/colors.dart';

class TWeeklySalesGraph extends StatelessWidget {
  const TWeeklySalesGraph({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardController());
    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Weekly Sales',
              style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: TSizes.spaceBtwSection),

          /// graph
          SizedBox(
              height: 400,
              child: BarChart(BarChartData(
                  titlesData: buildFlTitleData(),
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
                          : null)))),
        ],
      ),
    );
  }
  

  FlTitlesData buildFlTitleData() {
    return FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
            sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final days = [
                    'Mon',
                    'Tue',
                    'Wed',
                    'Thu',
                    'Fri',
                    'Sat',
                    'Sun'
                  ];

                  final index = value.toInt() % days.length;

                  final day = days[index];

                  return SideTitleWidget(
                      axisSide: AxisSide.bottom, space: 0, child: Text(day));
                })),
                leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: true, interval: 200, reservedSize: 50)),
                rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                );
  }
}
