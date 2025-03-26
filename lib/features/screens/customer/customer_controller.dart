import 'package:get/get.dart';

import '../../../data/abstract/base_data_table_controller.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repositorise/user_repository.dart';

class CustomerController extends TBaseController<UserModel> {
    static CustomerController get instance => Get.find();

    final _customerRepository = Get.put(UserRepository());

    @override
    Future<List<UserModel>> fetchItems() async {
      sortAscending.value = false;
        return await _customerRepository.getAllUsers();
    }

    void sortByName(int sortColumnIndex, bool ascending) {
        sortByParenty(sortColumnIndex, ascending, (UserModel o) => o.fullName.toString().toLowerCase());
    }

    @override
    bool containsSearchQuery(UserModel item, String query) {
        return item.fullName.toLowerCase().contains(query.toLowerCase());
    }

    @override
    Future<void> deleteItem(UserModel item) async {
        await _customerRepository.deleteUser(item.id ?? '');
    }
}