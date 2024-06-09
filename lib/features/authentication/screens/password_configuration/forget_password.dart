import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/features/authentication/controller/forget_password/forget_password_controller.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/constants/text_string.dart';
import 'package:t_store/utils/validators/validation.dart';
class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(DSize.defaultspace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Heading
            Text(DText.forgetPasswordTitle,style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: DSize.spaceBtwItem),
            Text(DText.forgetPasswordSubTitle,style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: DSize.spaceBtwSection*2),
            //Textfield
            //Email
            Form(
              key: controller.forgetPasswordFormKey,
              child: TextFormField(controller: controller.email,
                  validator: (value) => DValidator.validateEmail(value),
                  decoration: const InputDecoration(labelText: DText.email,prefixIcon: Icon(Iconsax.direct_right))),
            ),
            const SizedBox(height: DSize.spaceBtwSection),
            
            //Submit Button
            SizedBox(width: double.infinity,
                child: ElevatedButton( onPressed: () async {
                  await controller.sendPasswordResentEmail();
                }, child: const Text(DText.submit)))
          ],
        ),


        
      ),
    );
  }
}
