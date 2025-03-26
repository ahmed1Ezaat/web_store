import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:yt_ecommerce_admin_panel/data/models/setting_model.dart';
import 'package:yt_ecommerce_admin_panel/data/models/user_model.dart';
import 'package:yt_ecommerce_admin_panel/data/repositorise/authentication_repository.dart';
import 'package:yt_ecommerce_admin_panel/data/repositorise/setting_repository.dart';
import 'package:yt_ecommerce_admin_panel/data/repositorise/user_repository.dart';
import 'package:yt_ecommerce_admin_panel/features/controllers/loders.dart';
import 'package:yt_ecommerce_admin_panel/features/controllers/network_manger.dart';
import 'package:yt_ecommerce_admin_panel/features/controllers/user_controller.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/emums.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/images_strings.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/text_strings.dart';
import 'package:yt_ecommerce_admin_panel/utils/popups/full_screen_loader.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final hidePassword = true.obs;
  final rememberMe = false.obs;
  final localStorage = GetStorage();

  final email = TextEditingController();
  final password = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ?? '';
    password.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? '';
    super.onInit();
  }

  Future<void> emailAndPasswordSignIn() async {
    try {
      TFullScreenLoader.openLoaderDialog(
          'Loding You in ...', TImages.docerAnimation);

      final isConnected = await NetworkManger.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      if (!loginFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      final user = await UserController.instance.fetchUserDetails();

      TFullScreenLoader.stopLoading();

      if (user.role != AppRole.admin) {
        await AuthenticationRepository.instance.logout();
        TLodaers.errorSnackBar(
            title: 'No Authorized',
            message:
                'You are not an authorized or do have access. contact admin');
      } else {
        AuthenticationRepository.instance.screenRedirect();
      }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLodaers.errorSnackBar(title: 'Oh snap', message: e.toString());
    }
  }
    Future<void> registerAdmin() async {
      try {
        TFullScreenLoader.openLoaderDialog(
            'Registing Admin Account ...', TImages.docerAnimation);

        final isConnected = await NetworkManger.instance.isConnected();

        if (!isConnected) {
          TFullScreenLoader.stopLoading();
          return;
        }

        await AuthenticationRepository.instance.registerWithEmailAndPassword(
            TTexts.adminEmail, TTexts.adminPassword);

        final userRepository = Get.put(UserRepository());
        await userRepository.createUser(
          UserModel(
          id: AuthenticationRepository.instance.authUser!.uid,
          firstName: 'Ahmed',
          lastName: 'Ezzat',
          email: TTexts.adminEmail,
          role: AppRole.admin,
          createdAt: DateTime.now(),
        ));

        final settingsRepository = Get.put(SettingsRepository());

        await settingsRepository.registerSettings(SettingModel(appLogo: '', appName: 'My App', taxRate: 0, shippingCost: 0));

        TFullScreenLoader.stopLoading();

        AuthenticationRepository.instance.screenRedirect();
      } catch (e) {
        TFullScreenLoader.stopLoading();
        TLodaers.errorSnackBar(title: 'Oh snap', message: e.toString());
      }
    }
  }

