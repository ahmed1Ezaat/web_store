import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/images_strings.dart';

class TLodaerAnimation extends StatelessWidget {
  const TLodaerAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Lottie.asset(TImages.defaultAnimation, height: 200, width: 200),);
  }
}