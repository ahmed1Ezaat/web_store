import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/responsive/screens/desktop_layout.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/responsive/screens/mobile_layout.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/responsive/screens/responsive_design.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/responsive/screens/tablat_layout.dart';

class TSiteTemplate extends StatelessWidget {
  const TSiteTemplate(
      {super.key,
      this.mobile,
      this.tablet,
      this.desktop,
      this.useLayout = true});

  final Widget? mobile;
  final Widget? tablet;
  final Widget? desktop;
  final bool useLayout;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TResponsiveWidget(
       desktop: useLayout ? DesktopLayout(body: desktop) : desktop ?? Container(),
       tablet: useLayout ? TablatLayout(body: tablet ?? desktop) : tablet ?? desktop ?? Container(),
       mobile: useLayout ? MobileLayout(body: mobile ?? desktop) : mobile ?? desktop ?? Container(),
      ),
      
         );
    
  }
}
