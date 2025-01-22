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
//Email and password login
  Future<void> emailAndPasswordLogin() async {
    try {
      //Start loading
      TFullScreenLoader.openLoadingDialog(
          "Logging you in...", TImages.docerAnimation);
      //Check internet connect
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
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
      //login
      final userCredentials = await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());
      //remove loader
      TFullScreenLoader.stopLoading();
      UserController.instance.fetchUserRecord();
      //Redirect
      Get.to(() => const NavigationMenu());
    } on FirebaseAuthException catch (e) {
      TFullScreenLoader.stopLoading();
      TLoader.errorSnackbar(
          title: "Oh snap", message: TFirebaseAuthException(e.code).message);
    } on FirebaseException catch (e) {
      TFullScreenLoader.stopLoading();
      TLoader.errorSnackbar(
          title: "Oh snap", message: TFirebaseException(e.code).message);
    } on FormatException catch (_) {
      TFullScreenLoader.stopLoading();
      TLoader.errorSnackbar(title: "Oh snap", message: const TFormatException());
    } on PlatformException catch (e) {
      TFullScreenLoader.stopLoading();
      TLoader.errorSnackbar(
          title: "Oh snap", message: TPlatformException(e.code).message);
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoader.errorSnackbar(title: "Oh snap", message: "Wrong email or password");
    }
  }

  // Future<void> googleSignIn() async {
  //   try {
  //     // Start loading indicator
  //     TFullScreenLoader.openLoadingDialog("Logging you in...", TImages.docerAnimation);
  //
  //     // Check internet connection
  //     final isConnected = await NetworkManager.instance.isConnected();
  //     if (!isConnected) {
  //       TFullScreenLoader.stopLoading();
  //       return;
  //     }
  //
  //     // Google authentication
  //     final userCredentials = await AuthenticationRepository.instance.signInWithGoole();
  //
  //     // Check existing user record
  //     final existingUser = await UserRepository.instance.fetchUserDetails();
  //
  //     if (existingUser ==  UserModel.empty() || existingUser.id != userCredentials?.user!.uid) {
  //       // New user or different account: Save user record
  //       await userController.saveUserRecord(userCredentials);
  //     } else {
  //       // Existing account: Fetch updated user data (optional)
  //       // You can uncomment the following line if you want to
  //       // ensure the local user reflects any changes made on the server
  //       // await UserController.instance.fetchUserRecord();
  //     }
  //     UserController.instance.fetchUserRecord();
  //     // Remove loader
  //     TFullScreenLoader.stopLoading();
  //
  //     // Navigate to NavigationMenu
  //     Get.to(() => const NavigationMenu());
  //   } catch (e) {
  //     // Remove loader
  //     TFullScreenLoader.stopLoading();
  //     TLoader.errorSnackbar(title: 'Oh snap', message: e.toString());
  //   }
  // }

  Future<void> googleSignIn() async {
    try {
      // Start loading indicator
      print("Starting loading dialog...");
      TFullScreenLoader.openLoadingDialog("Logging you in...", TImages.docerAnimation);

      // Check internet connection
      print("Checking internet connection...");
      final isConnected = await NetworkManager.instance.isConnected();
      print("Internet connection status: $isConnected");
      if (!isConnected) {
        print("No internet connection. Stopping loader and returning.");
        TFullScreenLoader.stopLoading();
        return;
      }

      // Google authentication
      print("Attempting Google Sign-In...");
      final userCredentials = await AuthenticationRepository.instance.signInWithGoole();
      print("Google Sign-In credentials: ${userCredentials?.user?.uid}");

      // Check existing user record
      print("Fetching existing user details...");
      final existingUser = await UserRepository.instance.fetchUserDetails();
      print("Fetched user details: ${existingUser.id}");

      if (existingUser == UserModel.empty() || existingUser.id != userCredentials?.user!.uid) {
        // New user or different account: Save user record
        print("New user or different account detected. Saving user record...");
        await userController.saveUserRecord(userCredentials);
      } else {
        // Existing account: Fetch updated user data (optional)
        print("Existing account detected. Fetching updated user data...");
        UserController.instance.fetchUserRecord();
      }

      // Fetch updated user record after sign-in
      print("Fetching user record post-login...");
      await UserController.instance.fetchUserRecord();

      // Remove loader
      print("Stopping loader...");
      TFullScreenLoader.stopLoading();

      // Navigate to NavigationMenu
      print("Navigating to NavigationMenu...");
      Get.to(() => const NavigationMenu());
    } catch (e) {
      // Log error details
      print("Error encountered: $e");

      // Remove loader
      TFullScreenLoader.stopLoading();
      TLoader.errorSnackbar(title: 'Oh snap', message: e.toString());
    }
  }



}
