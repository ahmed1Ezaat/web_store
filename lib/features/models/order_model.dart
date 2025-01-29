import 'package:yt_ecommerce_admin_panel/controllers/helper_functions.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/emums.dart';

class OrderModel {
  final String id;
  final String userId;
  final String docId;
  final String paymentMethod;
  final double totalAmount;
  final DateTime orderDate;  
  final DateTime? deliveryDate;
  final String status;

  OrderModel({
    required this.id,
    this.userId = '',
    this.docId = '',
    required this.status,
    required this.orderDate,
    required this.totalAmount,
    this.paymentMethod = 'Paypal',
    this.deliveryDate,
  });

  String get formattedOrederDate =>
      THelperFunctions.getformattedOrederDate(orderDate);

  String get formattedDeliveryDate => deliveryDate != null
      ? THelperFunctions.getformattedOrederDate(deliveryDate!)
      : '';

  String get orderStatusText => status == OrderStatus.delivered
      ? 'Delivered'
      : status == OrderStatus.shipped
          ? 'Shipment on the way'
          : 'Processing';

  // String function to create an empty user model
  static OrderModel empty() => OrderModel(
      id: '',
      orderDate: DateTime.now(),
      status: OrderStatus.pending.toString(),
      totalAmount: 0);

  Map<String, dynamic> toJson() {
    return {
    'id': id,
    'userId': userId,
    'docId': docId,
    'paymentMethod': paymentMethod,
    'totalAmount': totalAmount,
    'orderDate': orderDate,
    'deliveryDate': deliveryDate,
    'status': status.toString(),
    };
  }
}
