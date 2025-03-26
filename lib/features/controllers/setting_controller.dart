import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/data/repositorise/setting_repository.dart';
import 'package:yt_ecommerce_admin_panel/features/controllers/loders.dart';
import 'package:yt_ecommerce_admin_panel/features/controllers/network_manger.dart';
import 'package:yt_ecommerce_admin_panel/utils/popups/full_screen_loader.dart';

import '../../data/models/setting_model.dart';
import '../media/media_controller.dart';
import '../models/image_model.dart';

class SettingsController extends GetxController {
  static SettingsController get instance => Get.find();

  // Observable variables
  RxBool loading = false.obs;
  Rx<SettingModel> settings = SettingModel().obs;

  final formKey = GlobalKey<FormState>();
  final appNameController = TextEditingController();
  final taxController = TextEditingController();
  final shippingController = TextEditingController();
  final freeShippingThresholdController = TextEditingController();

  // Dependencies
  final settingRepository = Get.put(SettingsRepository());

  @override
  void onInit() {
    fetchSettingDetails();
    super.onInit();
  }

  /// Fetches setting details from the repository
  Future<SettingModel> fetchSettingDetails() async {
    try {
      loading.value = true;
      final settings = await settingRepository.getSettings();
      this.settings.value = settings;

      appNameController.text = settings.appName;
      taxController.text = settings.taxRate.toString();
      shippingController.text = settings.shippingCost.toString();
      freeShippingThresholdController.text =
          settings.freeShippingThreshold == null
              ? ''
              : settings.freeShippingThreshold.toString();

      loading.value = false;

      return settings;
    } catch (e) {
      TLodaers.errorSnackBar(
          title: 'Something went wrong.', message: e.toString());
      return SettingModel();
    }
  }

  void updateAppLogo() async {
    try {
      loading.value = true;
      final controller = Get.put(MediaController());
      List<ImageModel>? selectedImages =
          await controller.selectImagesFormMedia();

      if (selectedImages != null && selectedImages.isNotEmpty) {
        ImageModel selectedImage = selectedImages.first;
        await settingRepository
            .updateSettingField({'appLogo': selectedImage.url});
        settings.value.appLogo = selectedImage.url;
        settings.refresh();

        TLodaers.successSnackBar(
            title: 'Congratulations', message: 'App Logo has been updated.');
      }

      loading.value = false;
    } catch (e) {
      loading.value = false;
      TLodaers.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  void updateSettingInformation() async {
    try {
      loading.value = true;

      // Check Internet Connectivity
      final isConnected = await NetworkManger.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
         return;
      }

      // Form Validation
      if (!formKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Update Settings Model
      settings.value.appName = appNameController.text.trim();
      settings.value.taxRate = double.tryParse(taxController.text.trim()) ?? 0.0;
      settings.value.shippingCost = double.tryParse(shippingController.text.trim()) ?? 0.0;
      settings.value.freeShippingThreshold = double.tryParse(freeShippingThresholdController.text.trim()) ?? 0.0;

      // Save to Firestore
      await settingRepository.updateSettingDetails(settings.value);
      settings.refresh();

      loading.value = false;
      // Show Success
      TLodaers.successSnackBar(
          title: 'Congratulations', message: 'App Settings has been updated.');
    } catch (e) {
      TLodaers.errorSnackBar(title: 'Error', message: e.toString());
    
    }
  }
}
