import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/features/controllers/loders.dart';

import '../../../data/models/user_model.dart';
import '../../../data/repositorise/address_repository.dart';
import '../../../data/repositorise/user_repository.dart';
import '../../models/order_model.dart';

class CustomerDetailController extends GetxController {
    static CustomerDetailController get instance => Get.find();

    RxBool ordersLoading = true.obs;
    RxBool addressesLoading = true.obs;
    RxInt sortColumnIndex = 1.obs;
    RxBool sortascending = true.obs;
    RxList<bool> selectedRows = <bool>[].obs;
    Rx<UserModel> customer = UserModel.empty().obs;
    final addressRepository = Get.put(AddressRepository());
    final searchTextController = TextEditingController();
    RxList<OrderModel> allCustomerOrders = <OrderModel>[].obs;
    RxList<OrderModel> filteredCustomerOrders = <OrderModel>[].obs;

    Future<void> getCustomerOrders() async {
        try {
            ordersLoading.value = true;
            if (customer.value.id != null && customer.value.id!.isNotEmpty) {
                customer.value.orders = await UserRepository.instance.fetchUserOrders(customer.value.id!);
            }
            allCustomerOrders.assignAll(customer.value.orders ?? []);
            filteredCustomerOrders.assignAll(customer.value.orders ?? []);
            selectedRows.assignAll(List.generate(customer.value.orders != null ? customer.value.orders!.length : 0, (index) => false));
        } catch (e) {
        TLodaers.errorSnackBar(title: 'Oh Snap!', message: e.toString());
        } finally {
            ordersLoading.value = false;
        }
    }

    Future<void> getCustomerAddresses() async {
    try {
        addressesLoading.value = true;
        if (customer.value.id != null && customer.value.id!.isNotEmpty) {
            customer.value.addresses = await addressRepository.fetchUserAddresses(customer.value.id!);
        }
    } catch (e) {
        TLodaers.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
        addressesLoading.value = false;
    }
}

void searchQuery(String query) {
    filteredCustomerOrders.assignAll(
        allCustomerOrders.where((customer) =>
            customer.id.toLowerCase().contains(query.toLowerCase()) || 
            customer.orderDate.toString().contains(query.toLowerCase())
        )
    );
    update();
}

void sortById(int sortColumnIndex, bool ascending) {
    sortascending.value = ascending;
    filteredCustomerOrders.sort((a, b) {
        if (ascending) {
            return a.id.toLowerCase().compareTo(b.id.toLowerCase());
        } else {
            return b.id.toLowerCase().compareTo(a.id.toLowerCase());
        }
    });
        this.sortColumnIndex.value = sortColumnIndex;
    update();
}
}