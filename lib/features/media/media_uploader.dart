import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';
import 'package:universal_html/html.dart' as html;
import 'package:yt_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/images/t_rounded_image.dart';
import 'package:yt_ecommerce_admin_panel/features/media/folder_dropdown.dart';
import 'package:yt_ecommerce_admin_panel/features/media/media_controller.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/images_strings.dart';
import 'package:yt_ecommerce_admin_panel/utils/device/device_utillity.dart';

import '../../utils/constants/emums.dart';
import '../../utils/constants/sizes.dart';
import '../models/image_model.dart';

class MediaUploader extends StatelessWidget {
  const MediaUploader({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = MediaController.instance;
    return Obx(
      () => controller.showImagesUploaderSection.value
          ? Column(
              children: [
                TRoundedContainer(
                  height: 250,
                  showBorder: true,
                  borderColor: TColors.borderPrimary,
                  backgroundColor: TColors.primaryBackground,
                  padding: const EdgeInsets.all(TSizes.defaultSpace),
                  child: Column(children: [
                    Expanded(
                      child: Stack(alignment: Alignment.center, children: [
                        DropzoneView(
                          mime: const ['image/jpeg', 'image/png'],
                          cursor: CursorType.Default,
                          operation: DragOperation.copy,
                          onLoaded: () => print('Zone hovered'),
                          onError: (ev) => print('Zone error: $ev'),
                          onHover: () => print('Zone hovered'),
                          onLeave: () => print('Zone left'),
                          onCreated: (ctrl) =>
                              controller.dropzoneCotroller = ctrl,
                          onDropInvalid: (ev) =>
                              print('Zone invalid MIME: $ev'),
                          onDropMultiple: (ev) =>
                              print('Zone dropped multiple: $ev'),
                          onDrop: (file) async {
                            if (file is html.File) {
                              final bytes = await controller.dropzoneCotroller
                                  .getFileData(file);
                              final image = ImageModel(
                                url: '',
                                file: file,
                                folder: '',
                                filename: file.name,
                                localImageToDisplay: Uint8List.fromList(bytes),
                              );
                              controller.selectedImagesToUpload.add(image);
                            } else if (file is String) {
                              print('Zone dropped string: $file');
                            } else {
                              print('Zone unknown type: ${file.runtimeType}');
                            }
                          },
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              TImages.defaultMultiImageIcon,
                              width: 50,
                              height: 50,
                            ),
                            const SizedBox(height: TSizes.spaceBtwItem),
                            const Text('Drop and Drop Images here'),
                            OutlinedButton(
                                onPressed: () {},
                                child: const Text('Select Images')),
                          ],
                        )
                      ]),
                    )
                  ]),
                ),
                const SizedBox(height: TSizes.spaceBtwItem),
                // Locally Selected image
                if( controller.selectedImagesToUpload.isNotEmpty)
                TRoundedContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // folder Dropdown
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text('Select Folder',
                                  style: Theme.of(context).textTheme.bodySmall),
                              const SizedBox(width: TSizes.spaceBtwItem),
                              MediaFolderDropdown(
                                onChanged: (MediaCategory? newValue) {
                                  if (newValue != null) {
                                    controller.selectedPath.value = newValue;
                                  }
                                },
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              TextButton(
                                  onPressed: () => controller.selectedImagesToUpload.clear(),
                                  child: const Text('Remove All')),
                              const SizedBox(width: TSizes.spaceBtwItem),
                              TDeviceUtils.isMobileScreen(context)
                                  ? const SizedBox.shrink()
                                  : SizedBox(
                                      width: TSizes.buttonWidth,
                                      child: ElevatedButton(
                                          onPressed: () => controller.uploadImagesConfirmation(),
                                          child: const Text('Upload')))
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: TSizes.spaceBtwSection),

                       Wrap(
                        alignment: WrapAlignment.start,
                        spacing: TSizes.spaceBtwItem / 2,
                        runSpacing: TSizes.spaceBtwItem / 2,
                        children: controller.selectedImagesToUpload
                            .where((image) => image.localImageToDisplay != null)
                            .map((element) => TRoundedImage(
                                  width: 90,
                                  height: 90,
                                  padding: TSizes.sm,
                                  imageType: ImageType.memory,
                                  memoryImage: element.localImageToDisplay,
                                  backgroundColor: TColors.primaryBackground,
                                ))
                            .toList(),
                      ),
                      const SizedBox(height: TSizes.spaceBtwSection),
                      TDeviceUtils.isMobileScreen(context)
                          ? SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  onPressed: () => controller.uploadImagesConfirmation(),
                                  child: const Text('Upload')))
                          : const SizedBox.shrink()
                    ],
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwSection),
              ],
            )
          : const SizedBox.shrink(),
    );
  }
}
