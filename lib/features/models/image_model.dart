import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/data/models/formatter.dart';

class ImageModel {
  String id;
  final String url;
  final String folder;
  final int? sizeBytes;
  String mediaCategory;
  final String filename;
  final String? fullPath;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? contentType;
  // not mapped
  final File? file;
  RxBool isSelected = false.obs;
  final Uint8List? localImageToDisplay;

  ImageModel(
      {this.id = '',
      required this.url,
      required this.folder,
      this.sizeBytes,
      this.mediaCategory = '',
      required this.filename,
      this.fullPath,
      this.createdAt,
      this.updatedAt,
      this.contentType,
      this.file,
      this.localImageToDisplay});

  static ImageModel empty() => ImageModel(url: '', folder: '', filename: '' );

  String get createdAtFormatted => TFormatter.formatDate(createdAt);

  String get updatedAtFormatted => TFormatter.formatDate(updatedAt);

  /// Conver to joson to in DB
  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'folder': folder,
      'sizeBytes': sizeBytes,
      'filename': filename,
      'fullPath': fullPath,
      'createdAt': createdAt?.toUtc(),
      'contentType': contentType,
      'mediaCategory': mediaCategory,
       
    };
  }

  /// convert firesttore Json and map on model
  factory ImageModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;

      //map joson record to the model
      return ImageModel(
        id: document.id,
        url: data['url'] ?? '',
        folder: data['folder'] ?? '',
        sizeBytes: data['sizeBytes'] ?? 0,
        filename: data['filename'] ?? '',
        fullPath: data['fullPath'] ?? '',
        createdAt: data.containsKey('createdAt')
            ? (data['createdAt']?.toDate())
            : null,
        updatedAt: data.containsKey('updatedAt')
            ? (data['updatedAt']?.toDate())
            : null,
        contentType: data['contentType'] ?? '',
        mediaCategory: data['mediaCategory'],
      );
    } else {
      return ImageModel.empty();
    }
  }

  factory ImageModel.fromFirebaseMetadata(FullMetadata metadata, String folder,
      String filename, String downloadUrl) {
    return ImageModel(
        url: downloadUrl,
        folder: folder,
        filename: filename,
        fullPath: metadata.fullPath,
        createdAt: metadata.timeCreated,
        contentType: metadata.contentType,
        sizeBytes: metadata.size,
        updatedAt: metadata.updated);
  }
}
