import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/reset_password/responsive_screen/dashboard_desktop_screen.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/reset_password/responsive_screen/dashboard_mobile_screen.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/reset_password/responsive_screen/dashboard_tablet_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(
      desktop: DashboardDesktopScreen(),
      mobile: DashboardMobileScreen(),
      tablet: DashboardTabletScreen(),
    );
  }
}