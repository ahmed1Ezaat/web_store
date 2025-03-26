import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/controllers/helper_functions.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:yt_ecommerce_admin_panel/utils/popups/anmation_loder.dart';

import '../../common/widgets/loaders/circular_loder.dart';

class TFullScreenLoader {
  static void openLoaderDialog(String text, String anmation) {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: Container(
            color: THelperFunctions.isDarkMode(Get.context!)
                ? TColors.dark
                : TColors.white,
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                const SizedBox(
                  height: 250,
                ),
                TAnimationLoaderWidget(text: text, animation: anmation),
              ],
            )),
      ),
    );
  }

  static void popUpLoader() {
    Get.defaultDialog(
      title: '',
      onWillPop: () async => false,
      content: const TCircularLoader(),
      backgroundColor: Colors.transparent,
    );
  }

  static stopLoading() {
    Navigator.of(Get.overlayContext!).pop();
  }
}
