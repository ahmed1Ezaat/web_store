import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/data/models/banner_model.dart';
import 'package:yt_ecommerce_admin_panel/data/repositorise/firebase_exception.dart';

class BannerRepository extends GetxController {
  static BannerRepository get instance => Get.find();

  // Firebase Firestore instance
  final _db = FirebaseFirestore.instance;

  // Get all banners from Firestore
  Future<List<BannerModel>> getAllBanners() async {
    try {
      final snapshot = await _db.collection("Banners").get();
      final result =
          snapshot.docs.map((e) => BannerModel.fromSnapshot(e)).toList();
      return result;
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw 'Failed to fetch banners';
    }
  }

  // Create a new banner in Firestore
  Future<String> createBanner(BannerModel banner) async {
    try {
      final result = await _db.collection("Banners").add(banner.toJson());
      return result.id;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw  const FormatException();
    } catch (e) {
      throw 'Failed to create banner';
    }
  }

  // Update an existing banner in Firestore
  Future<void> updateBanner(BannerModel banner) async {
    try {
      await _db.collection("Banners").doc(banner.id).update(banner.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw  const FormatException();
    } catch (e) {
      throw 'Failed to create banner';
    }
  }

    Future<void> deleteBanner(String bannerId ) async {
    try {
      await _db.collection("Banners").doc(bannerId).delete();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw  const FormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    }
    catch (e) {
      throw 'Failed to create banner';
    }
  }
}
