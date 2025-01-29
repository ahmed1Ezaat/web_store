import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';

class TResponsiveWidget extends StatelessWidget {
  const TResponsiveWidget(
      {super.key,
      required this.mobile,
      required this.tablet,
      required this.desktop});

  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      if (constraints.maxWidth >= TSizes.desktopScreensizes) {
        return desktop;
      } else if (constraints.maxWidth < TSizes.desktopScreensizes &&
          constraints.maxWidth >= TSizes.tabletScreensizes) {
        return tablet;
      } else {
        return mobile;
      }
    });
  }
}
