import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/controllers/helper_functions.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class TCircularIcon extends StatelessWidget {
  const TCircularIcon({
    super.key,
    required this.icon,
    this.width ,
    this.height ,
    this.size = TSizes.lg,
    this.color ,
    this.backgroundColor ,
    this.onPressed,
  });

  final IconData icon;
  final double? width, height, size;
  final Color? color;
  final Color? backgroundColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor != null
            ? backgroundColor!
            : THelperFunctions.isDarkMode(context)
                ? TColors.black.withOpacity(0.9)
                : TColors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(100),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: color, size: size),
      ),
    );
  }
}