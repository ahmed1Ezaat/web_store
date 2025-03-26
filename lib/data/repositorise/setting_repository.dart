import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/data/repositorise/firebase_exception.dart';

import '../models/setting_model.dart';

class SettingsRepository extends GetxController {
    static SettingsRepository get instance => Get.find();
    final FirebaseFirestore _db = FirebaseFirestore.instance;

    Future<void> registerSettings(SettingModel setting) async {
        try {
            await _db.collection("Settings").doc('GLOBAL_SETTINGS').set(setting.toJson());
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

    Future<SettingModel> getSettings() async {
        try {
            final querySnapshot = await _db.collection("Settings").doc('GLOBAL_SETTINGS').get();
            return SettingModel.fromSnapshot(querySnapshot);
        } on FirebaseException catch (e) {
            throw TFirebaseException(e.code).message;
        } on FormatException catch (_) {
            throw const FormatException();
        } on PlatformException catch (e) {
            throw TPlatformException(e.code).message;
        } catch (e) {
            if (kDebugMode) print('Something Went Wrong: $e');
            throw 'Something Went Wrong: $e';
        }
    }

    Future<void> updateSettingDetails( SettingModel updatedSetting) async {
        try {
             await _db.collection("Settings").doc('GLOBAL_SETTINGS').update(updatedSetting.toJson());
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

      Future<void> updateSettingField(Map<String, dynamic> json) async {
        try {
             await _db.collection("Settings").doc('GLOBAL_SETTINGS').update(json);
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