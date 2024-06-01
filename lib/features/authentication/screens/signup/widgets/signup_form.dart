import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/features/authentication/controller/signup/signup_controller.dart';
import 'package:t_store/features/authentication/screens/signup/verify_email.dart';
import 'package:t_store/features/authentication/screens/signup/widgets/term_condition_checkbox.dart';
import 'package:t_store/utils/validators/validation.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_string.dart';

class TSignupForm extends StatelessWidget {
  const TSignupForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Form(
        key: controller.signupFormKey,
        child: Column(
          children: [
            //First and last name
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller.firstName,
                    validator: (value) =>
                        DValidator.validateEmptyText('First Name', value),
                    decoration: const InputDecoration(
                        labelText: DText.firstName,
                        prefixIcon: Icon(Iconsax.user)),
                    expands: false,
                  ),
                ),
                const SizedBox(
                  width: DSize.spaceBtwItem,
                ),
                Expanded(
                  child: TextFormField(
                    controller: controller.lastName,
                    validator: (value) =>
                        DValidator.validateEmptyText('lastName', value),
                    decoration: const InputDecoration(
                        labelText: DText.lastName,
                        prefixIcon: Icon(Iconsax.user)),
                    expands: false,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: DSize.spaceBtwInputFielRadius,
            ),
            TextFormField(
              controller: controller.userName,
              validator: (value) =>
                  DValidator.validateEmptyText('userName', value),
              decoration: const InputDecoration(
                  labelText: DText.username,
                  prefixIcon: Icon(Iconsax.user_edit)),
              expands: false,
            ),
            const SizedBox(
              height: DSize.spaceBtwInputFielRadius,
            ),

            //Email
            TextFormField(
              controller: controller.email,
              validator: (value) => DValidator.validateEmail(value),
              decoration: const InputDecoration(
                  labelText: DText.email, prefixIcon: Icon(Iconsax.direct)),
            ),
            const SizedBox(
              height: DSize.spaceBtwInputFielRadius,
            ),
            //Phone number
            TextFormField(
              controller: controller.phoneNumber,
              validator: (value) => DValidator.validatePhoneNumber(value),
              decoration: const InputDecoration(
                  labelText: DText.phoneNo, prefixIcon: Icon(Iconsax.call)),
            ),
            const SizedBox(
              height: DSize.spaceBtwInputFielRadius,
            ),
            //Password
            Obx(
              () => TextFormField(
                controller: controller.password,
                validator: (value) => DValidator.validatePassword(value),
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
            const SizedBox(
              height: DSize.spaceBtwInputFielRadius,
            ),

            //Term && Condition Checkbox
            const TTermsAndConditionCheckBox(),
            const SizedBox(
              height: DSize.spaceBtwSection,
            ),
            //Signup button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.signup(),
                child: const Text(DText.createAccount),
              ),
            ),
          ],
        ));
  }
}
