import 'package:flutter/material.dart';

class TCloudHelperFunction {
  // Add your cloud helper functions here

  // Example function to upload data to cloud
  Future<void> uploadData(String collection, Map<String, dynamic> data) async {
    // Implement your cloud upload logic here
  }

  // Example function to fetch data from cloud
  Future<List<Map<String, dynamic>>> fetchData(String collection) async {
    // Implement your cloud fetch logic here
    return [];
  }

  // Example function to delete data from cloud
  Future<void> deleteData(String collection, String documentId) async {
    // Implement your cloud delete logic here
  }


  static Widget? checkMultiRecordState<T>({
  required AsyncSnapshot<List<T>> snapshot,
  Widget? loader,
  Widget? error,
  Widget? nothingFound,
}) {
  if (snapshot.connectionState == ConnectionState.waiting) {
    return loader ?? const Center(child: CircularProgressIndicator());
  }
  if (snapshot.hasError) {
    return error ?? const Center(child: Text('Something went wrong...'));
  }
  if (!snapshot.hasData || snapshot.data!.isEmpty) {
    return nothingFound ?? const Center(child: Text('No Data Found!'));
  }
  return null;
}
}