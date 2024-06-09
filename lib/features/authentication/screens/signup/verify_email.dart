import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/data/repositories/authentication/authentication_repository.dart';
import 'package:t_store/features/authentication/controller/signup/verify_email_controller.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/constants/text_string.dart';
import 'package:t_store/utils/helper/helper_function.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key, this.email});
  final String? email;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => AuthenticationRepository.instance.logout(),
              icon: const Icon(CupertinoIcons.clear)),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(DSize.defaultspace),
          child: Column(
            children: [
              //Image
              Image(
                image: const AssetImage(TImages.deliveredEmailIllustration),
                width: DHelperFunctions.screenWidth() * 0.6,
              ),
              const SizedBox(
                height: DSize.spaceBtwSection,
              ),
              //Title ans Subtitle
              Text(
                DText.confirmEmail,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: DSize.spaceBtwItem,
              ),
              Text(
                email?? " ",
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: DSize.spaceBtwItem,
              ),
              Text(
                DText.confirmEmailSubTitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: DSize.spaceBtwSection,
              ),
              //Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: const Text(DText.tContinue),
                  onPressed: () => Get.to(
                    () => controller.checkEmailVerificationStatus()
                  ),
                ),
              ),
              const SizedBox(
                height: DSize.spaceBtwItem,
              ),

              ///NUT GUI LAI EMAIL
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  child: const Text(DText.resendEmail),
                  onPressed: () => controller.sendEmailVerification(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
