import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/features/controllers/network_manger.dart';
import 'package:yt_ecommerce_admin_panel/features/controllers/setting_controller.dart';
import 'package:yt_ecommerce_admin_panel/features/controllers/user_controller.dart';


class GeneralBindings extends Bindings {
    @override
    void dependencies() {
        // -- Core
        Get.lazyPut(() => NetworkManger(), fenix: true);
        Get.lazyPut(() => UserController(), fenix: true);
        Get.lazyPut(() => SettingsController(), fenix: true);
    }
}