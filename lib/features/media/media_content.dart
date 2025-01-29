import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:yt_ecommerce_admin_panel/features/media/media_controller.dart';
import 'package:yt_ecommerce_admin_panel/features/models/image_model.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/view_image_details.dart';
import 'package:yt_ecommerce_admin_panel/utils/popups/anmation_loder.dart';

import '../../common/widgets/images/t_rounded_image.dart';
import '../../common/widgets/loaders/loader_anmation.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/emums.dart';
import '../../utils/constants/images_strings.dart';
import '../../utils/constants/sizes.dart';
import 'folder_dropdown.dart';

class MediaContent extends StatelessWidget {
  MediaContent(
      {super.key,
      required this.allowSelection,
      required this.allowMultipleSelection,
      this.alreadySelectedUrls,
      this.onImagesSelected});

  final bool allowSelection;
  final bool allowMultipleSelection;
  final List<String>? alreadySelectedUrls;
  final List<ImageModel> selectedImages = [];
  final Function(List<ImageModel> selectedImages)? onImagesSelected;

  @override
  Widget build(BuildContext context) {
    bool loadedPreviousSelection = false;
    final controller = MediaController.instance;
    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
                        controller.getMediaImages();
                      }
                    },
                  ),
                ],
              ),
              if (allowSelection) buildAddSelectedImagesButton(selectedImages),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwSection),
          Obx(() {
            // GEt Selected folder image
            List<ImageModel> images = _getSelectedFolderImages(controller);

            if (!loadedPreviousSelection) {
                if (alreadySelectedUrls != null &&
                alreadySelectedUrls!.isNotEmpty) {
              // Convert alreadySelectedUrls to a Set for faster lookup
              final selectedUrlsSet = Set<String>.from(alreadySelectedUrls!);

              for (var image in images) {
                image.isSelected.value = selectedUrlsSet.contains(image.url);
                if (image.isSelected.value) {
                  selectedImages.add(image);
                }
              }
            } else {
              for (var image in images) {
                image.isSelected.value = false;
              }
            }
              loadedPreviousSelection = true;
            }

            // loader
            if (controller.loading.value && images.isEmpty)
              return const TLodaerAnimation();

            // Empty widget
            if (images.isEmpty) return _buildEmptyAnimationWidget(context);

            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: images
                      .map((image) => GestureDetector(
                          onTap: () => Get.dialog(ImagePopup(
                                image: image,
                              )),
                          child: SizedBox(
                            width: 140,
                            height: 180,
                            child: Column(children: [
                              allowSelection
                                  ? _buildListWithCheckbox(image, allowMultipleSelection, selectedImages)
                                  : _buildSimpleList(image),
                              Expanded(
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: TSizes.sm),
                                    child: Text(image.filename,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis)),
                              ),
                            ]),
                          )))
                      .toList(),
                ),
                if (!controller.loading.value)
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: TSizes.spaceBtwSection),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: TSizes.buttonWidth,
                              child: ElevatedButton.icon(
                                onPressed: () => controller.loadMoreMediaImages,
                                label: const Text('Load More'),
                                icon: const Icon(Iconsax.arrow_down),
                              ),
                            )
                          ]))
              ],
            );
          }),
        ],
      ),
    );
  }

  List<ImageModel> _getSelectedFolderImages(MediaController controller) {
    List<ImageModel> images = [];
    if (controller.selectedPath.value == MediaCategory.banners) {
      images = controller.allBannerImages
          .where((image) => image.url.isNotEmpty)
          .toList();
    } else if (controller.selectedPath.value == MediaCategory.brands) {
      images = controller.allBrandImages
          .where((image) => image.url.isNotEmpty)
          .toList();
    } else if (controller.selectedPath.value == MediaCategory.categories) {
      images = controller.allCategoryImages
          .where((image) => image.url.isNotEmpty)
          .toList();
    } else if (controller.selectedPath.value == MediaCategory.products) {
      images = controller.allProductImages
          .where((image) => image.url.isNotEmpty)
          .toList();
    } else if (controller.selectedPath.value == MediaCategory.users) {
      images = controller.allUserImages
          .where((image) => image.url.isNotEmpty)
          .toList();
    }

    return images;
  }

  Widget _buildEmptyAnimationWidget(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.lg * 3),
        child: TAnimationLoaderWidget(
          width: 300,
          height: 300,
          text: 'Select Your Desired Folder',
          animation: TImages.packageAnimation,
          style: Theme.of(context).textTheme.titleLarge,
        ));
  }

  Widget _buildSimpleList(ImageModel image) {
    return TRoundedImage(
      width: 140,
      height: 140,
      padding: TSizes.sm,
      image: image.url,
      imageType: ImageType.network,
      margin: TSizes.spaceBtwItem / 2,
      backgroundColor: TColors.primaryBackground,
    );
  }
}

Widget _buildListWithCheckbox(ImageModel image, bool allowMultipleSelection, List<ImageModel> selectedImages) {
  return Stack(children: [
    TRoundedImage(
      width: 140,
      height: 140,
      padding: TSizes.sm,
      image: image.url,
      imageType: ImageType.network,
      margin: TSizes.spaceBtwItem / 2,
      backgroundColor: TColors.primaryBackground,
    ),
    Positioned(
      top: TSizes.md,
      right: TSizes.md,
      child: Obx(() => Checkbox(
          value: image.isSelected.value,
          onChanged: (selected) {
            if (selected != null) {
              image.isSelected.value = selected;

              if (selected) {
                if (!allowMultipleSelection) {
                  for (var othrImage in selectedImages) {
                    if (othrImage != image) {
                      othrImage.isSelected.value = false;
                    }
                  }
                  selectedImages.clear();
                }
                selectedImages.add(image);
              } else {
                selectedImages.remove(image);
              }
            }
          })),
    )
  ]);
}

Widget buildAddSelectedImagesButton(List<ImageModel> selectedImages) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      // Close Button
      SizedBox(
        width: 120,
        child: OutlinedButton.icon(
          label: const Text('Close'),
          icon: const Icon(Iconsax.close_circle),
          onPressed: () => Get.back(),
        ),
      ), // SizedBox
      const SizedBox(width: TSizes.spaceBtwItem),
      // Add Button
      SizedBox(
        width: 120,
        child: ElevatedButton.icon(
          label: const Text('Add'),
          icon: const Icon(Iconsax.image),
          onPressed: () => Get.back(result: selectedImages),
        ),
      ), // SizedBox
    ],
  );
}
