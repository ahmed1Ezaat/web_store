import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/emums.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';

import '../../../utils/constants/shimmer.dart';

class TRoundedImage extends StatelessWidget {
  const TRoundedImage({
    super.key, 
    this.image,
    this.file, 
    this.border, 
    this.width = 56, 
    this.height = 56,
    this.memoryImage, 
    this.overlayColor,
    required this.imageType,
    this.backgroundColor, 
    this.padding = TSizes.sm,
    this.margin,
    this.fit = BoxFit.contain,
    this.applyImageRadius = true,
    this.borderRadius = TSizes.md,
  });
  
  final bool applyImageRadius;
  final BoxBorder? border;
  final double borderRadius;
  final BoxFit? fit;
  final String? image;
  final File? file;
  final ImageType imageType;
  final Color? overlayColor;
  final Color? backgroundColor;
  final Uint8List?  memoryImage;
  final double width, height, padding;
  final double? margin;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin != null ? EdgeInsets.all(margin!) : null,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        border: border,
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: _buildImageWidget(),
    );
  }
  
   Widget _buildImageWidget() {
    Widget imageWidget;

    switch (imageType) {
      case ImageType.network:
      imageWidget = _buildNetworkImage();
      break;

      case ImageType.memory:
      imageWidget = _buildMemoryImage();
      break;

      case ImageType.file:
      imageWidget = _buildFileImage();
      break;
      
      case ImageType.asset:
      imageWidget = _buildAssetImage();
      break;
    }

    return ClipRRect(
      borderRadius: applyImageRadius ? BorderRadius.circular(borderRadius) : BorderRadius.zero,
      child: imageWidget,
    );
   }

   Widget _buildNetworkImage() {
    if (image != null) {
      return CachedNetworkImage(
        fit: fit,
        color: overlayColor,
        imageUrl: image!,
        errorWidget: (context, url, error) => const Icon(Icons.error),
        progressIndicatorBuilder: (context, url, downloadProgress) => TShimmerEffect(width: width, height: height),
      );
    } else{
      return Container();
    }
   }

   Widget _buildMemoryImage() {
    if (memoryImage != null) {
      return Image(
        fit: fit,
        image: MemoryImage(memoryImage!),
        color: overlayColor,
      );
    } else{
      return Container();
    }
   }

   Widget _buildFileImage() {
    if (file != null) {
      return Image(
        fit: fit,
        image: FileImage(file!),
        color: overlayColor,
      );
    } else{
      return Container();
    }
   }

   Widget _buildAssetImage(){
    if (image != null) {
      return Image(
        fit: fit,
        image: AssetImage(image!),
        color: overlayColor,

      );
    
    }else{
      return Container();
    }
   }
}
