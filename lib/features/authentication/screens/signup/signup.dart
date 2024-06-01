
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/login_signup/login_divider.dart';
import 'package:t_store/common/widgets/login_signup/login_social_buttons.dart';
import 'package:t_store/features/authentication/screens/signup/widgets/signup_form.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/constants/text_string.dart';
import 'package:t_store/utils/helper/helper_function.dart';
class Signup extends StatelessWidget {
  const Signup({super.key});
  @override
  Widget build(BuildContext context) {
    final dark = DHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(DSize.defaultspace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Title
              Text(DText.signupTitle,style: Theme.of(context).textTheme.headlineMedium,),
              const SizedBox(height: DSize.spaceBtwSection,),
              //Form
              const TSignupForm(),
              const SizedBox(
                height: DSize.spaceBtwSection,
              ),
              //Divider
              TFormDivider(dividerText: DText.orSignInWith.capitalize!),
              //Social button
              const TSocialButtons(),
              const SizedBox(
                height: DSize.spaceBtwSection,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

