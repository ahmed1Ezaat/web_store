import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/data/models/banner_model.dart';
import 'package:yt_ecommerce_admin_panel/features/controllers/loders.dart';
import 'package:yt_ecommerce_admin_panel/features/controllers/network_manger.dart';
import 'package:yt_ecommerce_admin_panel/features/models/image_model.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/banner/banner_controller.dart';
import 'package:yt_ecommerce_admin_panel/utils/popups/full_screen_loader.dart';

import '../../../data/repositorise/banners_repository.dart';
import '../../media/media_controller.dart';

class EditBannerController extends GetxController {
  static EditBannerController get instance => Get.find();

  final  imageURL = ''.obs;
  final  loading = false.obs;
  final  isActive = false.obs;
  final targetScreen = ''.obs;
  final formKey =  GlobalKey<FormState>();
  final rebosirory = Get.put(BannerRepository());

  void init(BannerModel banner) {
    imageURL.value = banner.imageUrl;
    isActive.value = banner.active;
    targetScreen.value = banner.targetScreen;
  }

  /// اختيار صورة من الوسائط
  void pickImage() async {
    
      final controller = Get.put(MediaController());
      List <ImageModel> ?selectedImages = await controller.selectImagesFormMedia();
      if (selectedImages != null && selectedImages.isNotEmpty) {
        ImageModel selectedImage = selectedImages.first;
        imageURL.value = selectedImage.url;
      }
  }

  /// إنشاء بانر جديد
  Future<void> updateBanner( BannerModel banner) async {
    try {
      // بدء شاشة التحميل
      TFullScreenLoader.popUpLoader();

      // التحقق من الاتصال بالإنترنت
      final isConnected = await NetworkManger.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // التحقق من صحة النموذج
      if (!formKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }
      // is data updated
      if (banner.imageUrl != imageURL.value || banner.targetScreen != targetScreen.value || banner.active != isActive.value) {
        banner.imageUrl = imageURL.value;
        banner.targetScreen = targetScreen.value;
        banner.active = isActive.value;

        await rebosirory.updateBanner(banner);
      }

      // إغلاق شاشة التحميل
      BannerController.instance.updateItemFromList(banner);

      TFullScreenLoader.stopLoading();
      TLodaers.successSnackBar(title: 'Congratulations', message: 'New record created successfully');     
      
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLodaers.errorSnackBar(title: 'Error', message: 'Failed to create new record');
    
  }
}}