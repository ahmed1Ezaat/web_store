import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/login/responsive_screens/login_desktop_tablet.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/login/responsive_screens/login_screen_mobil.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(useLayout: false, desktop: LoginScreenDesktopTablet(),mobile: LoginScreenMobil());
  }
}