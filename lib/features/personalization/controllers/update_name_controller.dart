import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:t_store/data/repositories/user/user_repository.dart';
import 'package:t_store/features/personalization/controllers/user_controller.dart';
import 'package:t_store/features/personalization/screens/profile/profile.dart';
import 'package:t_store/utils/popups/loader.dart';

import '../../../utils/constants/image_strings.dart';
import '../../../utils/helper/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';

class UpdateNameController extends GetxController{
  static UpdateNameController get instance =>Get.find();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUsernameFormKey = GlobalKey<FormState>();
  @override
  void onInit() {
   initializeNames();
    super.onInit();

  }
  Future<void> initializeNames() async{
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }
  Future<void> updateUserName() async{
    try{
      //start loading
      TFullScreenLoader.openLoadingDialog("We are updating your information...", TImages.docerAnimation);
      //Check internet connect
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      //FORM VALID
      if(!updateUsernameFormKey.currentState!.validate()){
        TFullScreenLoader.stopLoading();
        return;
      }
      //update first and last name in the firebase firestore
      Map<String,dynamic> name ={'FirstName':firstName.text.trim(),'LastName':lastName.text.trim()};
      await userRepository.updateSingleField(name);
      //update Rx User value
      UserController.instance.fetchUserRecord();

      //remove loader
      TFullScreenLoader.stopLoading();
      //show success 
      TLoader.successSnackbar(title: 'Congratulation',message: 'Your name has been updated');
      //Move to previous screen
      Get.off(()=>const ProfileScreen());
    }catch(e){
      TFullScreenLoader.stopLoading();
      TLoader.errorSnackbar(title: 'Oh Snap!',message: e.toString());
    }
  }
}