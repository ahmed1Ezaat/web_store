import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:universal_html/html.dart' as html;

import 'package:yt_ecommerce_admin_panel/features/models/image_model.dart';

import '../../utils/constants/emums.dart';

class MediaRepository extends GetxController {
  static MediaRepository get instance => Get.find();

  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<ImageModel> uplodeImageFileInStorage(
      {required html.File file,
      required String path,
      required String imageName}) async {
    try {
      // REference to the sotorge location
      final Reference ref = _storage.ref('$path/$imageName');
      // Upload the file
      await ref.putBlob(file);

      // Get the download URL
      final String downloadURL = await ref.getDownloadURL();

      // Fetch the metadata
      final FullMetadata metadata = await ref.getMetadata();

      return ImageModel.fromFirebaseMetadata(
          metadata, path, imageName, downloadURL);
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }

  /// upload images data in firebase
  Future<String> uplodeImageFileInDatabase(ImageModel image) async {
    try{
      final data = await FirebaseFirestore.instance.collection('Images').add(image.toJson());
      return data.id;
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }


  Future<List<ImageModel>> fetchImagesfromDatabase(MediaCategory mediaCategory, int loadCount) async {
    
  try{
    final querySnapshot = await FirebaseFirestore.instance
    .collection('Images')
    .where('mediaCategory', isEqualTo: mediaCategory.name.toString())
    .orderBy('createdAt', descending: true)
    .limit(loadCount)
    .get();
    return querySnapshot.docs.map((e) => ImageModel.fromSnapshot(e)).toList();

  }on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<ImageModel>> loadMoreImagesfromDatabase(MediaCategory mediaCategory, int loadCount, DateTime lastFetchedDate) async {
    try{
      final querySnapshot = await FirebaseFirestore.instance
    .collection('Images')
    .where('mediaCategory', isEqualTo: mediaCategory.name.toString())
    .orderBy('createdAt', descending: true)
    .startAfter([lastFetchedDate])
    .limit(loadCount)
    .get();
    return querySnapshot.docs.map((e) => ImageModel.fromSnapshot(e)).toList();


    }on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }
    
  Future<void> deleteFileFromStorage(ImageModel image) async {
  try {
    // Your code here
    await FirebaseStorage.instance.ref(image.fullPath).delete();
    await FirebaseFirestore.instance.collection('Images').doc(image.id).delete();
  } on FirebaseException catch (e) {
    throw e.message ?? 'Something went wrong while deleting image.';
  } on SocketException catch (e) {
    throw e.message;
  } on PlatformException catch (e) {
    throw e.message!;
  } catch (e) {
    throw e.toString();
  }
}
}
