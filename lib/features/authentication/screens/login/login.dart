import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/styles/spacing_styles.dart';
import 'package:t_store/common/widgets/login_signup/login_divider.dart';
import 'package:t_store/features/authentication/screens/login/widgets/login_form.dart';
import 'package:t_store/features/authentication/screens/login/widgets/login_header.dart';
import 'package:t_store/common/widgets/login_signup/login_social_buttons.dart';
import 'package:t_store/utils/constants/text_string.dart';
import '../../../../utils/constants/sizes.dart';
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Padding(
      padding: TSpacingStyle.paddingWithAppbarHeight,
      child: Column(
        children: [
          //1. Header
          const TLoginHeader(),

          //2. Form
          const TLoginForm(),
          //3. Divider
          TFormDivider(dividerText: DText.orSignInWith.capitalize!,),
          const SizedBox(
            height: DSize.spaceBtwSection,
          ),
          //4. Footer
          const TSocialButtons()
        ],
      ),
    )));
  }
}
