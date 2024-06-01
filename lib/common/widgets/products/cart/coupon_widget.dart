import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helper/helper_function.dart';
import '../../custom_shapes/containers/rounded_container.dart';
class TCouponCode extends StatelessWidget {
  const TCouponCode({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final dark = DHelperFunctions.isDarkMode(context);
    return TRoundedContainer(
      showBorder: true,
      backgroundColor: dark ? DColor.dark : DColor.white,
      padding: const EdgeInsets.only(
          top: DSize.sm,
          bottom: DSize.sm,
          right: DSize.md,
          left: DSize.md),
      child: Row(
        children: [
          Flexible(
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: 'Have a promo code? Enter here',
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ),
          SizedBox(
              width: 80,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    foregroundColor: dark? DColor.white.withOpacity(0.5):DColor.dark.withOpacity(0.5),
                    backgroundColor: DColor.grey.withOpacity(0.2),
                    side: BorderSide(color: DColor.grey.withOpacity(0.1))
                ),
                child: const Text('Apply'),))
        ],
      ),
    );
  }
}
