import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/data/repositorise/firebase_exception.dart';
import 'package:yt_ecommerce_admin_panel/features/models/order_model.dart';

class OrderRepository extends GetxController {
  static OrderRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<OrderModel>> getAllOrders() async {
    try {
      final result = await _db.collection('Orders').orderBy('orderDate', descending: true).get();
      return result.docs.map((documentSnapshot) => OrderModel.fromSnapshot(documentSnapshot)).toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const FormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }


  Future<void> addOrder(OrderModel order) async {
    try {
      await _db.collection('Orders').add(order.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const FormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  

  Future<void> updateOrderSpecificValue(String orderId, Map<String, dynamic> data) async {
    try {
      await _db.collection('Orders').doc(orderId).update(data);
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const FormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<void> deleteOrder(String orderId) async {
    try {
        await _db.collection("Orders").doc(orderId).delete();
    } on FirebaseException catch (e) {
        throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
        throw const FormatException();
    } on PlatformException catch (e) {
        throw TPlatformException(e.code).message;
    } catch (e) {
        throw 'Something went wrong. Please try again';
    }
}
}