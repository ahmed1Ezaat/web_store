import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/data/models/banner_model.dart';
import 'package:yt_ecommerce_admin_panel/features/controllers/loders.dart';
import 'package:yt_ecommerce_admin_panel/features/controllers/network_manger.dart';
import 'package:yt_ecommerce_admin_panel/features/models/image_model.dart';
import 'package:yt_ecommerce_admin_panel/features/screens/banner/banner_controller.dart';
import 'package:yt_ecommerce_admin_panel/routes/app_screens.dart';
import 'package:yt_ecommerce_admin_panel/utils/popups/full_screen_loader.dart';

import '../../../data/repositorise/banners_repository.dart';
import '../../media/media_controller.dart';

class CreateBannerController extends GetxController {
  static CreateBannerController get instance => Get.find();

  final  imageURL = ''.obs;
  final  loading = false.obs;
  final  isActive = false.obs;
  final RxString targetScreen = AppScreens.allAppScreenItems[0].obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
  Future<void> createBanner() async {
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

      // إنشاء كائن البانر
      final newRecord = BannerModel(
        id: '',
        imageUrl: imageURL.value,
        active: isActive.value,
        targetScreen: targetScreen.value,
      );

      // إرسال البيانات إلى Firestore
      newRecord.id = await BannerRepository.instance.createBanner(newRecord); 

      // إغلاق شاشة التحميل
      BannerController.instance.addItemToLists(newRecord);

      TFullScreenLoader.stopLoading();
      TLodaers.successSnackBar(title: 'Congratulations', message: 'New record created successfully');     
      
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLodaers.errorSnackBar(title: 'Error', message: 'Failed to create new record');
    
  }
}}