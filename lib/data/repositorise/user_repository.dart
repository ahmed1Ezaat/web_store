import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/data/models/user_model.dart';
import 'package:yt_ecommerce_admin_panel/data/repositorise/authentication_repository.dart';
import 'package:yt_ecommerce_admin_panel/data/repositorise/firebase_auth_exceptions.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<void> createUser(UserModel user) async {
    try {
      await _db.collection('users').doc(user.id).set(user.toJson());
    } on FirebaseAuthException catch (e) {
      throw TfirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const FormatException();
    } on PlatformException catch (e) {
      throw TplatformException(e.code).message;
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
      throw TplatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong : $e';
  }
}
  }