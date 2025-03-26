import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/images_strings.dart';

import '../../../utils/constants/sizes.dart';

class TLodaerAnimation extends StatelessWidget {
  const TLodaerAnimation({super.key, this.height = 300, this.width = 300});
  final double height, width;
  @override
  Widget build(BuildContext context) {
    return Center(child: Column(
      children: [
        Image(image: const AssetImage(TImages.ridingIllustration), height: height, width: width),
        const SizedBox(height: TSizes.spaceBtwItem),
        const Text('Loading...Yor data ...'),
      ],
    ));
  }
}
