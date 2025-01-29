import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/data/models/user_model.dart';
import 'package:yt_ecommerce_admin_panel/data/repositorise/user_repository.dart';
import 'package:yt_ecommerce_admin_panel/features/controllers/loders.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  RxBool loading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;

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
      TLodaers.errorSnackBar(title:'Something went wrong.' , message : e.toString());
      return UserModel.empty();
    }
  }
}
