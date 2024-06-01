import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/features/authentication/controller/login/login_controller.dart';
import 'package:t_store/features/authentication/screens/password_configuration/forget_password.dart';
import 'package:t_store/features/authentication/screens/signup/signup.dart';
import 'package:t_store/navigation_menu.dart';
import 'package:t_store/utils/validators/validation.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_string.dart';
class TLoginForm extends StatelessWidget {
  const TLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Form(
      key: controller.loginFormKey,
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: DSize.spaceBtwSection),
      child: Column(
        children: [


          //Email
          TextFormField(
            controller: controller.email,
            validator: (value)=> DValidator.validateEmail(value),
            decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: DText.email
            ),
          ),
          const SizedBox(height: DSize.spaceBtwInputFielRadius,),

          //Password
          Obx(
                () => TextFormField(
              controller: controller.password,
              validator: (value) => DValidator.validateEmptyText("Password",value),
              obscureText: controller.hidePassword.value,
              decoration: InputDecoration(
                labelText: DText.password,
                prefixIcon: Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                  onPressed: () => controller.hidePassword.value =
                  !controller.hidePassword.value,
                  icon: Icon( controller.hidePassword.value?Iconsax.eye_slash : Iconsax.eye),
                ),
              ),
            ),
          ),

          const SizedBox(height: DSize.spaceBtwInputFielRadius/2,),
          //Remember me va Forgot Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //Remember me
              Row(
                children: [
                  Obx(
              ()=> Checkbox(value: controller.rememberMe.value,
                      onChanged: (value)=> controller.rememberMe.value=!controller.rememberMe.value,),
                  ),
                  const Text(DText.rememberMe)
                ],
              ),
              //Forgot Button
              TextButton(onPressed: ()=>Get.to(()=> const ForgetPassword()), child: const Text(DText.forgetPassword))

            ],
          ),
          const SizedBox(height: DSize.spaceBtwSection,),
          //Signin Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: ()=> controller.emailAndPasswordLogin(),
              child: const Text(DText.signIn),
            ),
          ),
          const SizedBox(height: DSize.spaceBtwSection,),
          //Create Action Button

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Get.to(()=> const Signup()),
              child: const Text(DText.createAccount),
            ),
          )
        ],
      ),
    ));
  }
}