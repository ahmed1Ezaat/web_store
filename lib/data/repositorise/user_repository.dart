
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/data/models/user_model.dart';
import 'package:yt_ecommerce_admin_panel/data/repositorise/authentication_repository.dart';
import 'package:yt_ecommerce_admin_panel/data/repositorise/firebase_auth_exceptions.dart';
import 'package:yt_ecommerce_admin_panel/features/models/order_model.dart';

import 'firebase_exception.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<void> createUser(UserModel user) async {
    try {
      await _db.collection('Users').doc(user.id).set(user.toJson());
    } on FirebaseAuthException catch (e) {
      throw TfirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const FormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<UserModel> fetchAdminDetails() async {
    try {
      final docSnapsnot = await _db.collection('Users').doc(AuthenticationRepository.instance.authUser!.uid).get();
        return UserModel.fromSnapshot(docSnapsnot);
    } on FirebaseAuthException catch (e) {
      throw TfirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const FormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong : $e';
  }
}

Future<List<UserModel>> getAllUsers() async {
    try {
        final querySnapshot = await _db.collection("Users").orderBy('FirstName').get();
        return querySnapshot.docs.map((doc) => UserModel.fromSnapshot(doc)).toList();
    } on FirebaseAuthException catch (e) {
        throw TfirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
        throw const FormatException();
    } on PlatformException catch (e) {
        throw TPlatformException(e.code).message;
    } catch (e) {
        if (kDebugMode) print('Something Went Wrong: $e');
        throw 'Something Went Wrong: $e';
    }
}

  Future<UserModel> fetchUserDetails(String id) async {
    try {
        final documentSnapshot = await _db.collection("Users").doc(id).get();
        if (documentSnapshot.exists) {
            return UserModel.fromSnapshot(documentSnapshot);
        } else {
            return UserModel.empty();
        }
    } on FirebaseAuthException catch (e) {
        throw TfirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
        throw const FormatException();
    } on PlatformException catch (e) {
        throw TPlatformException(e.code).message;
    } catch (e) {
        if (kDebugMode) print('Something Went Wrong: $e');
        throw 'Something Went Wrong: $e';
    }
}

Future<List<OrderModel>> fetchUserOrders(String userId) async {
    try {
        final documentSnapshot = await _db.collection("Orders").where('userId', isEqualTo: userId).get();
        return documentSnapshot.docs.map((doc) => OrderModel.fromSnapshot(doc)).toList();
    } on FirebaseAuthException catch (e) {
        throw TfirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
        throw const FormatException();
    } on PlatformException catch (e) {
        throw TPlatformException(e.code).message;
    } catch (e) {
        if (kDebugMode) print('Something Went Wrong: $e');
        throw 'Something Went Wrong: $e';
    }
}

Future<void> deleteUser(String id) async {
    try {
        await _db.collection("Users").doc(id).delete();
    } on FirebaseException catch (e) {
        throw e.message!;
    } on PlatformException catch (e) {
        throw e.message!;
    } catch (e) {
        throw 'Something went wrong. Please try again';
    }
}

Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
        await _db.collection("Users").doc(AuthenticationRepository.instance.authUser!.uid).update(json);
    } on FirebaseAuthException catch (e) {
        throw TfirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
        throw const FormatException();
    } on PlatformException catch (e) {
        throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';

    }
}

Future<void> updateUserDetails(UserModel updateUser) async {
    try {
        await _db.collection("Users").doc(updateUser.id).update(updateUser.toJson());
    } on FirebaseAuthException catch (e) {
        throw TfirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
        throw const FormatException();
    } on PlatformException catch (e) {
        throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';

    }
}

  }