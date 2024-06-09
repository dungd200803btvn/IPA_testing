import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/success_screen/success_screen.dart';
import 'package:t_store/data/repositories/authentication/authentication_repository.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/text_string.dart';
import 'package:t_store/utils/popups/loader.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  //send email whenever verify screen appear and set timer for auto redirect
  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }

  sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
      TLoader.successSnackbar(
          title: 'Email sent',
          message: "Please check your inbox and verify your email");
    } catch (e) {
      TLoader.errorSnackbar(title: 'Oh Snap', message: e.toString());
    }
  }
  setTimerForAutoRedirect(){
    Timer.periodic(const Duration(seconds: 1), (timer) async{
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if(user?.emailVerified ?? false){
        timer.cancel();
        Get.off(
            () => SuccessScreen(
                image: TImages.successfullyRegisterAnimation,
                title: DText.yourAccountCreatedTitle,
                subTitle: DText.yourAccountCreatedSubTitle,
                onPressed: ()=> AuthenticationRepository.instance.screenRedirect(),
            )
        );
      }
    });
  }
  //manually check if email verified
checkEmailVerificationStatus() async{
    final currentUser = FirebaseAuth.instance.currentUser;
    if(currentUser!=null && currentUser.emailVerified){
      Get.off(
              () => SuccessScreen(
            image: TImages.successfullyRegisterAnimation,
            title: DText.yourAccountCreatedTitle,
            subTitle: DText.yourAccountCreatedSubTitle,
            onPressed: ()=> AuthenticationRepository.instance.screenRedirect(),
          )
      );
    }
}

}
