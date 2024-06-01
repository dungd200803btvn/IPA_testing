import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:t_store/data/repositories/authentication/authentication_repository.dart';
import 'package:t_store/features/authentication/screens/password_configuration/reset_password.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/popups/full_screen_loader.dart';
import 'package:t_store/utils/popups/loader.dart';

import '../../../../utils/helper/network_manager.dart';

class ForgetPasswordController  extends GetxController{
  static ForgetPasswordController get instance => Get.find();
  //variables
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();
   sendPasswordResentEmail() async{
    try{
    //start loading
      TFullScreenLoader.openLoadingDialog("Processing your request...", TImages.docerAnimation);
      //Check internet connect
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      //form validation
      if(!forgetPasswordFormKey.currentState!.validate()){
        TFullScreenLoader.stopLoading();
        return;
      }
      //call api
      await AuthenticationRepository.instance.sendPasswordResetEmail(email.text.trim());
      //remove loader
      TFullScreenLoader.stopLoading();
      //show success screen
      TLoader.successSnackbar(title: 'Email sent',message: 'Email link sent to reset your password'.tr);//dich sang ngon ngu hien tai dang dung trong app
      //redirect screen
      Get.to(()=> ResetPassword(email:  email.text.trim(),));
    }catch(e){
      TFullScreenLoader.stopLoading();
      TLoader.errorSnackbar(title: 'Oh Snap',message: e.toString());
    }
  }
    resendPasswordResentEmail(String email) async{
    try{
//start loading
      TFullScreenLoader.openLoadingDialog("Processing your request...", TImages.docerAnimation);
      //Check internet connect
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      //call api
      await AuthenticationRepository.instance.sendPasswordResetEmail(email);
      //remove loader
      TFullScreenLoader.stopLoading();
      //show success screen
      TLoader.successSnackbar(title: 'Email sent',message: 'Email link sent to reset your password'.tr);//dich sang ngon ngu hien tai dang dung trong app
      //redirect screen

    }catch(e){
      TFullScreenLoader.stopLoading();
      TLoader.errorSnackbar(title: 'Oh Snap',message: e.toString());
    }
  }
}