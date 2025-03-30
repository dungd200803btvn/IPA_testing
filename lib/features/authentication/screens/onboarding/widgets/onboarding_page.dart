import 'package:flutter/material.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helper/helper_function.dart';
class OnboardingWidget extends StatelessWidget {
  const OnboardingWidget({
    super.key, required this.image, required this.title, required this.subTitle,
  });
  final String image,title,subTitle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(DSize.defaultspace),
      child: Column(
        children: [

          Image(width: DHelperFunctions.screenWidth()*0.8,
              height: DHelperFunctions.screenHeight()*0.6,
              image: AssetImage(image)),

          Text(title,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,),
          const SizedBox(height: DSize.spaceBtwItem,),
          Text(subTitle,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,),
        ],
      ),
    );
  }
}