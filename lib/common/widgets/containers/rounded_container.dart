import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';

class TRoundedContainer extends StatelessWidget {
  const TRoundedContainer(
      {super.key,
      this.child,
      this.width,
      this.height,
      this.margin,
      this.showShadow = true,
      this.showBorder = false,
      this.padding = const EdgeInsets.all(TSizes.md),
      this.borderColor = TColors.borderPrimary,
      this.radius = TSizes.cardRadiusLg,
      this.backgroundColor = TColors.white,
      this.onTap});
  final Widget? child;
  final double radius;
  final double? width;
  final double? height;
  final bool showShadow;
  final bool showBorder;
  final Color borderColor;
  final Color backgroundColor;
  final EdgeInsets? margin;
  final EdgeInsets padding;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        margin: margin,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(radius),
          border: showBorder ? Border.all(color: borderColor) : null,
          boxShadow: [
            if (showShadow)
              BoxShadow(
                  color: TColors.grey.withOpacity(0.1),
                  spreadRadius: 5,
                  blurRadius: 8,
                  offset: const Offset(0, 3),
              )
          ]
        ),
        child: child,
      ),
    );
  }
}
