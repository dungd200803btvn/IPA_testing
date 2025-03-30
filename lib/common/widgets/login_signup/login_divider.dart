import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/helper/helper_function.dart';

class TFormDivider extends StatelessWidget {
  const TFormDivider({
    super.key, required this.dividerText,
  });
  final String dividerText;
  @override
  Widget build(BuildContext context) {
    final dark = DHelperFunctions.isDarkMode(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Divider(
            color: dark? DColor.darkGrey:DColor.grey,
            thickness: 0.5,
            indent: 60,//kc thut tu mep trai
            endIndent: 5,//kc thut tu mep phai
          ),
        ),
        Text(
          dividerText,
          style: Theme.of(context).textTheme.labelMedium,),
        Flexible(
          child: Divider(
            color: dark? DColor.darkGrey:DColor.grey,
            thickness: 0.5,
            indent: 5,//kc thut tu mep trai
            endIndent: 60,//kc thut tu mep phai
          ),
        ),
      ],
    );
  }
}