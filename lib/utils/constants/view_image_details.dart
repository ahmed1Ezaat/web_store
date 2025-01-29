import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/images/t_rounded_image.dart';
import 'package:yt_ecommerce_admin_panel/features/controllers/loders.dart';
import 'package:yt_ecommerce_admin_panel/features/media/media_controller.dart';
import 'package:yt_ecommerce_admin_panel/features/models/image_model.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:yt_ecommerce_admin_panel/utils/device/device_utillity.dart';

import 'colors.dart';
import 'emums.dart';

class ImagePopup extends StatelessWidget {
  final ImageModel image;
  const ImagePopup({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(TSizes.borderRadiusLg)),
      child: TRoundedContainer(
          width: TDeviceUtils.isDesktopScreen(context)
              ? MediaQuery.of(context).size.width * 0.4
              : double.infinity,
          padding: const EdgeInsets.all(TSizes.spaceBtwItem),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                child: Stack(
                  children: [
                    TRoundedContainer(
                      backgroundColor: TColors.primaryBackground,
                      child: TRoundedImage(
                        image: image.url,
                        applyImageRadius: true,
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: TDeviceUtils.isDesktopScreen(context)
                            ? MediaQuery.of(context).size.width * 0.4
                            : double.infinity,
                        imageType: ImageType.network,
                      ),
                    ),
                    Positioned(
                        top: 0,
                        right: 0,
                        child: IconButton(
                          onPressed: () => Get.back(),
                          icon: const Icon(Iconsax.close_circle),
                        ))
                  ],
                ),
              ),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItem),
              Row(
                children: [
                  Expanded(
                      child: Text(
                    'Image Name',
                    style: Theme.of(context).textTheme.bodyLarge,
                  )),
                  Expanded(
                      flex: 3,
                      child: Text(image.filename,
                          style: Theme.of(context).textTheme.titleLarge)),
                ],
              ),
              Row(children: [
                Expanded(
                    child: Text(
                  'Image URL',
                  style: Theme.of(context).textTheme.bodyLarge,
                )),
                Expanded(
                    flex: 2,
                    child: Text(
                      image.url,
                      style: Theme.of(context).textTheme.titleLarge,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      FlutterClipboard.copy(image.url).then((value) =>
                          TLodaers.customToast(message: 'URL copied!'));
                    },
                    child: const Text('Copy URL'),
                  ),
                )
              ]),
              const SizedBox(height: TSizes.spaceBtwSection),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 300,
                      child: TextButton(
                        onPressed: () => MediaController.instance.removeCloudImageConfirmation(image), 
                        child: const Text('Delet Image', style: TextStyle(color: Colors.red)),),
                      )
                ],
              )
            ],
          )),
    ));
  }
}
