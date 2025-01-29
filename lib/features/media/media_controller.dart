import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';
import 'package:universal_html/html.dart' as html;
import 'package:yt_ecommerce_admin_panel/features/controllers/loders.dart';
import 'package:yt_ecommerce_admin_panel/features/media/media_repository.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/dia_logo.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/text_strings.dart';
import 'package:yt_ecommerce_admin_panel/utils/popups/full_screen_loader.dart';

import '../../common/widgets/loaders/circular_loder.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/emums.dart';
import '../../utils/constants/images_strings.dart';
import '../../utils/constants/sizes.dart';
import '../models/image_model.dart';
import 'media_content.dart';
import 'media_uploader.dart';

class MediaController extends GetxController {
  static MediaController get instance => Get.find();

  final RxBool loading = false.obs;

  final int initailLoadCount = 20;
  final int loadMoreCount = 25;

  late DropzoneViewController dropzoneCotroller;
  final RxBool showImagesUploaderSection = false.obs;
  final Rx<MediaCategory> selectedPath = MediaCategory.folders.obs;
  final RxList<ImageModel> selectedImagesToUpload = <ImageModel>[].obs;

  final RxList<ImageModel> allImages = <ImageModel>[].obs;
  final RxList<ImageModel> allBannerImages = <ImageModel>[].obs;
  final RxList<ImageModel> allProductImages = <ImageModel>[].obs;
  final RxList<ImageModel> allBrandImages = <ImageModel>[].obs;
  final RxList<ImageModel> allCategoryImages = <ImageModel>[].obs;
  final RxList<ImageModel> allUserImages = <ImageModel>[].obs;

  final MediaRepository mediaRepository = MediaRepository();

  /// Get Image
  void getMediaImages() async {
    try {
      loading.value = true;

      RxList<ImageModel> targetList = <ImageModel>[].obs;

      if (selectedPath.value == MediaCategory.banners &&
          allBannerImages.isEmpty) {
        targetList = allBannerImages;
      } else if (selectedPath.value == MediaCategory.brands &&
          allBrandImages.isEmpty) {
        targetList = allBrandImages;
      } else if (selectedPath.value == MediaCategory.categories &&
          allCategoryImages.isEmpty) {
        targetList = allCategoryImages;
      } else if (selectedPath.value == MediaCategory.products &&
          allProductImages.isEmpty) {
        targetList = allProductImages;
      } else if (selectedPath.value == MediaCategory.users &&
          allUserImages.isEmpty) {
        targetList = allUserImages;
      }
      final images = await mediaRepository.fetchImagesfromDatabase(
          selectedPath.value, initailLoadCount);
      targetList.assignAll(images);

      loading.value = false;
    } catch (e) {
      loading.value = false;
      TLodaers.errorSnackBar(
          title: 'Oh Snap',
          message: 'Unable to fatch image Something went wrong');
    }
  }

  // load more image
  loadMoreMediaImages() async {
    try {
      loading.value = true;

      RxList<ImageModel> targetList = <ImageModel>[].obs;

      if (selectedPath.value == MediaCategory.banners) {
        targetList = allBannerImages;
      } else if (selectedPath.value == MediaCategory.brands) {
        targetList = allBrandImages;
      } else if (selectedPath.value == MediaCategory.categories) {
        targetList = allCategoryImages;
      } else if (selectedPath.value == MediaCategory.products) {
        targetList = allProductImages;
      } else if (selectedPath.value == MediaCategory.users) {
        targetList = allUserImages;
      }
      final images = await mediaRepository.loadMoreImagesfromDatabase(
          selectedPath.value,
          initailLoadCount,
          targetList.last.createdAt ?? DateTime.now());
      targetList.addAll(images);

      loading.value = false;
    } catch (e) {
      loading.value = false;
      TLodaers.errorSnackBar(
          title: 'Oh Snap',
          message: 'Unable to fatch image Something went wrong');
    }
  }

  Future<void> selectLocalImages() async {
  final files = await dropzoneCotroller
      .pickFiles(multiple: true, mime: ['image/jpeg', 'image/png']);

  if (files.isNotEmpty) {
    for (var file in files) {
      if (file is html.File) {
        final bytes = await dropzoneCotroller.getFileData(file);
        final fileObject = File.fromRawPath(bytes);
        final image = ImageModel(
          url: '',
          file: fileObject,
          folder: '',
          filename: file.name,
          localImageToDisplay: Uint8List.fromList(bytes),
        );
        selectedImagesToUpload.add(image);
      }
    }
  }
}

  void uploadImagesConfirmation() {
    if (selectedPath.value == MediaCategory.folders) {
      TLodaers.warningSnackBar(
          title: 'Select Folder', message: 'Please select a folder');
      return;
    }

    TDiaLogo.defaultDialog(
        context: Get.context!,
        title: 'Upload Images',
        confirmText: 'Upload',
        onConfirm: () async => await uploadImages(),
        content:
            'Are you sure you want to upload these images to the selected in ${selectedPath.value.name.toUpperCase()}  folder?');
  }

  Future<void> uploadImages() async {
    try {
      Get.back();

      uploadImagesLoader();

      MediaCategory selectedCategory = selectedPath.value;

      RxList<ImageModel> targetList;

      switch (selectedCategory) {
        case MediaCategory.banners:
          targetList = allBannerImages;
          break;
        case MediaCategory.brands:
          targetList = allBrandImages;
          break;
        case MediaCategory.categories:
          targetList = allCategoryImages;
          break;
        case MediaCategory.products:
          targetList = allProductImages;
          break;
        case MediaCategory.users:
          targetList = allUserImages;
          break;
        default:
          return;
      }

      /// upload images
      for (int i = selectedImagesToUpload.length - 1; i >= 0; i--) {
        var selectedImage = selectedImagesToUpload[i];
        final image = html.File(
          selectedImage.localImageToDisplay!,
          selectedImage.filename,
        );

        // upload image strorege
        final ImageModel uploadedImage =
            await mediaRepository.uplodeImageFileInStorage(
                file: image,
                path: getselectedPath(),
                imageName: selectedImage.filename);

        uploadedImage.mediaCategory = selectedCategory.name;
        final id =
            await mediaRepository.uplodeImageFileInDatabase(uploadedImage);

        uploadedImage.id = id;

        selectedImagesToUpload.removeAt(i);
        targetList.add(uploadedImage);
      }

      TFullScreenLoader.stopLoading();
    } catch (e) {
      TFullScreenLoader.stopLoading();

      TLodaers.warningSnackBar(
          title: 'error uploading images',
          message: 'something went wrong while uploading images');
    }
  }

  void uploadImagesLoader() {
    showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (context) => PopScope(
            canPop: false,
            child: AlertDialog(
              title: const Text('Uploading Images'),
              content: Column(mainAxisSize: MainAxisSize.min, children: [
                Image.asset(
                  TImages.uploadingImageIllustrion,
                  height: 300,
                  width: 300,
                ),
                const SizedBox(height: TSizes.spaceBtwItem),
                const Text('Sit Tight, Youjr images are uploading ...'),
              ]),
            )));
  }

  String getselectedPath() {
    String path = '';

    switch (selectedPath.value) {
      case MediaCategory.banners:
        path = TTexts.bannersStoreagePath;
        break;
      case MediaCategory.brands:
        path = TTexts.brandsStoreagePath;
        break;
      case MediaCategory.categories:
        path = TTexts.categoryStoreagePath;
        break;
      case MediaCategory.products:
        path = TTexts.productsStoreagePath;
        break;
      case MediaCategory.users:
        path = TTexts.usersStoreagePath;
        break;
      default:
        path = 'Others';
    }
    return path;
  }

  void removeCloudImageConfirmation(ImageModel image) {
    /// delete
    TDiaLogo.defaultDialog(
        context: Get.context!,
        content: 'Are you sure you want to remove this image?',
        onConfirm: () {
          Get.back();

          removeCloudImage(image);
        });
  }

  void removeCloudImage(ImageModel image) async {
    try {
      Get.back();

      Get.defaultDialog(
        title: '',
        barrierDismissible: false,
        backgroundColor: Colors.transparent,
        content: const PopScope(
          canPop: false,
          child: SizedBox(
            width: 150,
            height: 150,
            child: TCircularLoader(),
          ),
        ),
      );
      await mediaRepository.deleteFileFromStorage(image);
      // get the carresponding
      RxList<ImageModel> targetList;

      switch (selectedPath.value) {
        case MediaCategory.banners:
          targetList = allBannerImages;
          break;
        case MediaCategory.brands:
          targetList = allBrandImages;
          break;
        case MediaCategory.categories:
          targetList = allCategoryImages;
          break;
        case MediaCategory.products:
          targetList = allProductImages;
          break;
        case MediaCategory.users:
          targetList = allUserImages;
          break;
        default:
          return;
      }

      // remove from list
      targetList.remove(image);
      update();
      
      TFullScreenLoader.stopLoading();
      TLodaers.successSnackBar(
          title: 'Image Deleted',
          message: 'Image Successfully Deleted from ypur cloud storeg');
    } catch (e) {
      TFullScreenLoader.stopLoading();

      TLodaers.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  Future<List<ImageModel>?> selectImagesFormMedia({List<String>? selectedUrls, bool allowSelection = true, bool multipleSelection = false}) async {
        showImagesUploaderSection.value = true;

    List<ImageModel> ?selectedImages = await Get.bottomSheet<List<ImageModel>>(
    isScrollControlled: true,
    backgroundColor: TColors.primaryBackground,
    FractionallySizedBox(
        heightFactor: 1,
        child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: Column(
                    children: [
                        const MediaUploader(),
                        MediaContent(
                            allowSelection: allowSelection,
                            alreadySelectedUrls: selectedUrls ?? [],
                            allowMultipleSelection: multipleSelection,
                        ),
                    ],
                ),
            ),
        ),
    )
    );

    return selectedImages;
  }
}
