import 'package:flutter/material.dart';

import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_string.dart';
import '../../../../../utils/helper/helper_function.dart';
class TLoginHeader extends StatelessWidget {
  const TLoginHeader({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final dark = DHelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Logo
        Image(
          image: AssetImage(dark? TImages.darkAppLogo: TImages.darkAppLogo),
          height: 150,
        ),
        //title
        Text( DText.loginTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: DSize.sm,),
        Text( DText.loginSubTitle,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
