import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:t_store/data/repositories/authentication/authentication_repository.dart';

import '../../../features/personalization/models/address_model.dart';

class AddressRepository extends GetxController {
  static AddressRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  Future<List<AddressModel>> fetchUserAddress() async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if (userId.isEmpty) {
        throw "Unable to find user informartion. Try again in few minutes";
      }
      final result = await _db
          .collection('User')
          .doc(userId)
          .collection('Addresses')
          .get();
      return result.docs
          .map((e) => AddressModel.fromDocumentSnapshot(e))
          .toList();
    } catch (e) {
      throw "Something went wrong while fetching Address Information. Try again later.";
    }
  }

  Future<AddressModel> fetchSelectedAddress() async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if (userId.isEmpty) {
        throw "Unable to find user information. Try again in a few minutes.";
      }

      final result = await _db
          .collection('User')
          .doc(userId)
          .collection('Addresses')
          .where('SelectedAddress', isEqualTo: true)
          .limit(1)
          .get();

      if (result.docs.isEmpty) {
        return AddressModel.empty();
      }

      return AddressModel.fromDocumentSnapshot(result.docs.first);
    } catch (e) {
      throw "Something went wrong while fetching the selected address. Try again later.";
    }
  }

  //clear the selected field for all addresses
  Future<void> updateSelectedField(String addressId, bool selected) async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      await _db
          .collection('User')
          .doc(userId)
          .collection("Addresses")
          .doc(addressId)
          .update({"SelectedAddress": selected});
    } catch (e) {
      throw "Unable to update your address selection. Try again later";
    }
  }

  Future<String> addAddress(AddressModel address) async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      final currentAddressRef =
          _db.collection('User').doc(userId).collection('Addresses').doc();

      // Set the id of the address model to the document id
      address.id = currentAddressRef.id;

      // Set the dateTime of the address model to the current time
      address.dateTime = DateTime.now();
      // Add the address to Firestore with the updated id
      await currentAddressRef.set(address.toJson());

      return currentAddressRef.id;
    } catch (e) {
      throw "Something went wrong while saving Address Information. Try again later.";
    }
  }
}
