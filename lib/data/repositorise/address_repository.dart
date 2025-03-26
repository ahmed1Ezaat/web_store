import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/data/repositorise/authentication_repository.dart';
import 'package:yt_ecommerce_admin_panel/features/models/address_model.dart';

class AddressRepository extends GetxController {
    static AddressRepository get instance => Get.find();

    final _db = FirebaseFirestore.instance;

    Future<List<AddressModel>> fetchUserAddresses(String userId) async {
        try {
            final result = await _db.collection('Users').doc(userId).collection('Addresses').get();
            return result.docs.map((documentSnapshot) => AddressModel.fromDocumentSnapshot(documentSnapshot)).toList();
        } catch (e) {
            throw 'Something went wrong while fetching Address Information. Try again later';
        }
    }

    Future<void> updateSelectedField(String addressId, bool selected) async {
        try {
            final userId = AuthenticationRepository.instance.authUser!.uid;
            await _db.collection('Users').doc(userId).collection('Addresses').doc(addressId).update({'SelectedAddress': selected});
        } catch (e) {
            throw 'Unable to update your address selection. Try again later';
        }
    }

    Future<String> addAddress(AddressModel address) async {
        try {
            final userId = AuthenticationRepository.instance.authUser!.uid;
            final currentAddress = await _db.collection('Users').doc(userId).collection('Addresses').add(address.toJson());
            return currentAddress.id;
        } catch (e) {
            throw 'Failed to add address: ${e.toString()}';
        }
    }
}