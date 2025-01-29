import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/controllers/helper_functions.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/spaceing_style.dart';

class TLoginTemplates extends StatelessWidget {
  const TLoginTemplates({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 550,
        child: SingleChildScrollView(
          child: Container(
            padding: TSpacingStyle.paddingWithAppBarHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
              color: THelperFunctions.isDarkMode(context) ? TColors.black : TColors.white,
        ),
        child: child,
        )
        )
        )
        );

  }
}