import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/data/abstract/base_data_table_controller.dart';
import 'package:yt_ecommerce_admin_panel/data/repositorise/order_repository.dart';
import 'package:yt_ecommerce_admin_panel/features/controllers/loders.dart';
import 'package:yt_ecommerce_admin_panel/features/models/order_model.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/emums.dart';

class OrderController extends TBaseController<OrderModel> {
  static OrderController get instance => Get.find();
  
  final RxBool statusLoader = false.obs;
  var orderStatus = OrderStatus.delivered.obs;
  final  _orderRepository = Get.put(OrderRepository());

  @override
  Future<List<OrderModel>> fetchItems() async {
    sortAscending.value = false;
    return await _orderRepository.getAllOrders();
  }

  @override
  bool containsSearchQuery(OrderModel item, String query) {
    return item.id.toLowerCase().contains(query.toLowerCase());
  }

  @override
  Future<void> deleteItem(OrderModel item) async {
    await _orderRepository.deleteOrder(item.docId);
  }

  void sortById(int sortColumnIndex, bool ascending) {
    sortByParenty(
      sortColumnIndex,
      ascending,
      (OrderModel o) => o.totalAmount.toString().toLowerCase(),
    );
  }

  void sortByDate(int sortColumnIndex, bool ascending) {
    sortByParenty(
      sortColumnIndex,
      ascending,
      (OrderModel o) => o.orderDate.toString().toLowerCase(),
    );
  }

  Future<void> updateOrderStatus(OrderModel order, OrderStatus newStatus) async {
    try {
      statusLoader.value = true;
      order.status = newStatus;
      await _orderRepository.updateOrderSpecificValue(
        order.docId, 
        {'status': newStatus.toString()}
      );
      updateItemFromList(order);
      orderStatus.value = newStatus;
      TLodaers.successSnackBar(title: 'Success', message: 'Order Status Updated');
    } catch (e) {
      TLodaers.warningSnackBar(title: 'Error', message: e.toString());
    } finally {
      statusLoader.value = false;
    }
  }
}