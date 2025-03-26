import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/data/models/user_model.dart';
import 'package:yt_ecommerce_admin_panel/data/repositorise/user_repository.dart';
import 'package:yt_ecommerce_admin_panel/features/controllers/loders.dart';
import 'package:yt_ecommerce_admin_panel/features/controllers/network_manger.dart';
import 'package:yt_ecommerce_admin_panel/utils/popups/full_screen_loader.dart';

import '../media/media_controller.dart';
import '../models/image_model.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  RxBool loading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;

  final formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phomeController = TextEditingController();

  final userRepository = Get.put(UserRepository());

  @override
  void onInit() {
    fetchUserDetails();
    super.onInit();
  }

  Future<UserModel> fetchUserDetails() async {
    try {
      loading.value = true;
      final user = await userRepository.fetchAdminDetails();
      this.user.value = user;
      loading.value = false;
      return user;
    } catch (e) {
      loading.value = false;
      TLodaers.errorSnackBar(
          title: 'Something went wrong.', message: e.toString());
      return UserModel.empty();
    }
  }

  void updateProfilePicture() async {
    try {
      loading.value = true;
      final controller = Get.put(MediaController());
      List<ImageModel>? selectedImages =
          await controller.selectImagesFormMedia();

      if (selectedImages != null && selectedImages.isNotEmpty) {
        ImageModel selectedImage = selectedImages.first;
        await userRepository
            .updateSingleField({'ProfilePicture': selectedImage.url});
        user.value.profilePicture = selectedImage.url;
        user.refresh();
        TLodaers.successSnackBar(
            title: 'Congratulations', message: 'Profile picture updated');
      }

      loading.value = false;
    } catch (e) {
      loading.value = false;
      TLodaers.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  void updateUserInformation() async {
    try {
      loading.value = true;
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

      // Update User Model
      user.value.firstName = firstNameController.text.trim();
      user.value.lastName = lastNameController.text.trim();
      user.value.phoneNumber = phomeController.text.trim();

      await userRepository.updateUserDetails(user.value);
      user.refresh();
      loading.value = false;
      TLodaers.successSnackBar(
          title: 'Congratulations', message: 'Profile updated successfully');
    } catch (e) {
      TLodaers.errorSnackBar(title: 'Error', message: e.toString());
    }
  }
}
