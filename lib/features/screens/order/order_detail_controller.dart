import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/data/models/user_model.dart';
import 'package:yt_ecommerce_admin_panel/data/repositorise/user_repository.dart';
import 'package:yt_ecommerce_admin_panel/features/controllers/loders.dart';
import 'package:yt_ecommerce_admin_panel/features/models/order_model.dart';

class OrderDetailController extends GetxController {
    static OrderDetailController get instance => Get.find();

    RxBool loading = true.obs;
    Rx<OrderModel> order = OrderModel.empty().obs;
    Rx<UserModel> customer = UserModel.empty().obs;

    Future<void> getCustomerOfCurrentOrder() async {
        try {
            loading.value = true;
            final user = await UserRepository.instance.fetchUserDetails(order.value.userId);
            customer.value = user;
        } catch (e) {
            TLodaers.errorSnackBar(title: 'Oh Snap!', message: e.toString());
        } finally {
            loading.value = false;
        }
    }
}