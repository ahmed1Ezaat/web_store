import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/reset_password/responsive_screen/reset_password_desktop_tablet.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/reset_password/responsive_screen/reset_password_mobile.dart';

class RestPasswordScreen extends StatelessWidget {
  const RestPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(useLayout: false, desktop: ResetPasswordDesktopTablet(), mobile: ResetPasswordMobile(),);
  }
}