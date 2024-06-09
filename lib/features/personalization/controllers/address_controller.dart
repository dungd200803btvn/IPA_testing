import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/data/repositories/address/address_repository.dart';
import 'package:t_store/features/personalization/screens/address/address.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/popups/full_screen_loader.dart';
import 'package:t_store/utils/popups/loader.dart';
import '../../../utils/helper/network_manager.dart';
import '../models/address_model.dart';

class AddressController extends GetxController{
  static AddressController get instance =>Get.find();
  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();
  final city = TextEditingController();
  final district = TextEditingController();
  final commune = TextEditingController();
  final country = TextEditingController();
  GlobalKey<FormState> addressFormkey = GlobalKey<FormState>();
  final addressRepository = Get.put(AddressRepository());
  final Rx<AddressModel> selectedAddress = AddressModel.empty().obs;
  RxBool refreshData = true.obs;
  //fetch all user specific addresses
  Future<List<AddressModel>> getAllUserAddresses() async{
    try{
      final addresses = await addressRepository.fetchUserAddress();
      selectedAddress.value = addresses.firstWhere((element) => element.selectedAddress,orElse: () => AddressModel.empty());
      return addresses;
    }catch(e){
      TLoader.errorSnackbar(title: 'Address not found',message: e.toString());
      return [];
    }
  }
  Future selectAddress(AddressModel newSelectedAddress) async{
    try{
      Get.defaultDialog(
        title: "",
        onWillPop: () async { return false; },
        barrierDismissible: false,
        backgroundColor: Colors.transparent,
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text(
              "Updating address now, please wait...",
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
      if(selectedAddress.value.id.isNotEmpty){
        await addressRepository.updateSelectedField(selectedAddress.value.id, false);
      }
      newSelectedAddress.selectedAddress = true;
      selectedAddress.value = newSelectedAddress;
      await addressRepository.updateSelectedField(selectedAddress.value.id, true);
      Get.back();
    }catch(e){
      TLoader.errorSnackbar(title: 'Error in selection',message: e.toString());
    }
  }

  Future addNewAddresses() async{
    try{
      TFullScreenLoader.openLoadingDialog('Storing Address', TImages.docerAnimation);
      //Check internet connect
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      if (!addressFormkey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }
      //save address data
      final address = AddressModel(
          id: " ",
          name: name.text.trim(),
          phoneNumber: phoneNumber.text.trim(),
          street: street.text.trim(),
          city: city.text.trim(),
          district: district.text.trim(),
          commune: district.text.trim(),
          country: country.text.trim(),
          selectedAddress: true);
      final id = await addressRepository.addAddress(address);
      address.id  = id;
      selectAddress(address);
      //remove loader
      TFullScreenLoader.stopLoading();
      TLoader.successSnackbar(title: 'Congratulations',message: 'Your address has been saved successfully');
      //refresh data
       refreshData.value =  !refreshData.value;
      //reset field
      resetFormField();
      //redirect
     Get.to(()=> const UserAddressScreen());
    }catch(e){
      TFullScreenLoader.stopLoading();
      TLoader.errorSnackbar(title: 'Address not found',message: e.toString());
    }
  }
  void resetFormField(){
    name.clear();
    phoneNumber.clear();
    street.clear();
    district.clear();
    city.clear();
    commune.clear();
    country.clear();
    addressFormkey.currentState?.reset();
  }

}