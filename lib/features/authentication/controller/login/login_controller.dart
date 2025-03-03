import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:t_store/data/repositories/authentication/authentication_repository.dart';
import 'package:t_store/data/repositories/user/user_repository.dart';
import 'package:t_store/features/authentication/models/user_model.dart';
import 'package:t_store/features/personalization/controllers/user_controller.dart';
import 'package:t_store/navigation_menu.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/popups/full_screen_loader.dart';
import 'package:t_store/utils/popups/loader.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../../utils/exceptions/firebase_exceptions.dart';
import '../../../../utils/exceptions/format_exceptions.dart';
import '../../../../utils/exceptions/platform_exceptions.dart';
import '../../../../utils/helper/network_manager.dart';

class LoginController extends GetxController {
  //Variables
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final userController = UserController.instance;
  var lang = AppLocalizations.of(Get.context!);
//Email and password login
  Future<void> init() async {
    //Start loading
    TFullScreenLoader.openLoadingDialog(
        lang.translate('login_process'), TImages.docerAnimation);
    //Check internet connect
    final isConnected = await NetworkManager.instance.isConnected();
    if (!isConnected) {
      TFullScreenLoader.stopLoading();
      return;
    }
  }
  Future<void> emailAndPasswordLogin() async {
    try {
      init();
      if (!loginFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }
      //Save data if remember me is selected
      if (rememberMe.value) {
        localStorage.write("REMEMBER_ME_EMAIL", email.text.trim());
        localStorage.write("REMEMBER_ME_PASSWORD", password.text.trim());
      } else {
        localStorage.write("REMEMBER_ME_EMAIL", "");
        localStorage.write("REMEMBER_ME_PASSWORD", "");
      }
      //remove loader
      TFullScreenLoader.stopLoading();
      UserController.instance.fetchUserRecord();
      //Redirect
      Get.to(() => const NavigationMenu());
    } on FirebaseAuthException catch (e) {
      TFullScreenLoader.stopLoading();
      TLoader.errorSnackbar(
          title: lang.translate('snap'), message: TFirebaseAuthException(e.code).message);
    } on FirebaseException catch (e) {
      TFullScreenLoader.stopLoading();
      TLoader.errorSnackbar(
          title: lang.translate('snap'), message: TFirebaseException(e.code).message);
    } on FormatException catch (_) {
      TFullScreenLoader.stopLoading();
      TLoader.errorSnackbar(title: lang.translate('snap'), message: const TFormatException());
    } on PlatformException catch (e) {
      TFullScreenLoader.stopLoading();
      TLoader.errorSnackbar(
          title: lang.translate('snap'), message: TPlatformException(e.code).message);
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoader.errorSnackbar(title:lang.translate('snap'), message: lang.translate('login_wrong'));
    }
  }

  Future<void> googleSignIn() async {
    try {
     init();
      // Google authentication
      final userCredentials = await AuthenticationRepository.instance.signInWithGoole();
      // Check existing user record
      final existingUser = await UserRepository.instance.fetchUserDetails();
      if (existingUser == UserModel.empty() || existingUser.id != userCredentials?.user!.uid) {
        // New user or different account: Save user record
        await userController.saveUserRecord(userCredentials);
      } else {
        // Existing account: Fetch updated user data (optional)
        UserController.instance.fetchUserRecord();
      }
      // Fetch updated user record after sign-i
      await UserController.instance.fetchUserRecord();
      // Remove loader
      TFullScreenLoader.stopLoading();
      // Navigate to NavigationMenu
      Get.to(() => const NavigationMenu());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoader.errorSnackbar(title: lang.translate('snap'), message: e.toString());
    }
  }
}
