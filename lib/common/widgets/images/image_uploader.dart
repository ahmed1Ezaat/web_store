import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/reset_password/widgets/circular_container.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/emums.dart';
import '../../../utils/constants/sizes.dart';
import '../icons/circualar_icon.dart';
import 't_circular_image.dart';
import 't_rounded_image.dart';

class TImageUploader extends StatelessWidget {
  const  TImageUploader({
    super.key,
    this.image,
    this.onIconButtonPressed,
    this.memoryImage,
    this.width = 100,
    this.height = 100,
    required this.imageType,
    this.circular = false,
    this.icon = Iconsax.edit_2,
    this.top,
    this.bottom = 0,
    this.right,
    this.left = 0,
   this.loading = false,
  });
   final bool loading;
  // Whether to display the image in a circular shape
  final bool circular;

  // URL or path of the image to display
  final String? image;

  // Type of image (network, asset, memory, etc.)
  final ImageType imageType;

  // Width of the image uploader widget
  final double width;

  // Height of the image uploader widget
  final double height;

  // Byte data of the image (for memory images)
  final Uint8List? memoryImage;

  // Icon to display on the image uploader widget
  final IconData icon;

  // Offset from the top edge of the widget
  final double? top;
  // Offset from the bottom edge of the widget

  final double? bottom;

// Offset from the right edge of the widget

  final double? right;

// Offset from the left edge of the widget

  final double? left;

// Callback function for when the icon button is pressed

  final void Function()? onIconButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Display the image in either circular or rounded shape

        circular
            ? TCircularImage(
                image: image,
                width: width,
                height: height,
                imageType: imageType,
                memoryImage: memoryImage,
                backgroundColor: TColors.primaryBackground, margin: 0,
              )
            : TRoundedImage(
                image: image,
                width: width,
                height: height,
                imageType: imageType,
                memoryImage: memoryImage,
                backgroundColor: TColors.primaryBackground,
              ),

        Positioned(
            top: top,
            left: left,
            right: right,
            bottom: bottom,
            
            child: loading
            ?  const TCircularContainer(
              width: TSizes.xl,
              height: TSizes.xl,
              child: CircularProgressIndicator(strokeWidth: 2, backgroundColor: TColors.primary, color: Colors.white),
            )
          :  TCircularIcon(
              icon: icon,
              size: TSizes.md,
              color: TColors.white,
              onPressed: onIconButtonPressed,
              backgroundColor: TColors.primary.withOpacity(0.9),
            ))
      ],
    );
  }
}
