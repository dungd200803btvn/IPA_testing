import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';

import '../../../../../utils/helper/helper_function.dart';
class TBillingAddressSection extends StatelessWidget {
  const TBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = DHelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TSectionHeading(title: 'Shipping Address',buttonTitle: 'Change',onPressed: (){},),
        Text('Coding with LCD',style: Theme.of(context).textTheme.bodyLarge,),
        const SizedBox(height: DSize.spaceBtwItem/2,),
        Row(
          children: [
            const Icon(Icons.phone,color: DColor.grey,size: 16,),
            const SizedBox(width: DSize.spaceBtwItem,),
            Text('+84-0335620803',style: Theme.of(context).textTheme.bodyMedium,)
          ],
        ),
        const SizedBox(height: DSize.spaceBtwItem/2,),
        Row(
          children: [
            const Icon(Icons.location_history,color: DColor.grey,size: 16,),
            const SizedBox(width: DSize.spaceBtwItem,),
            Expanded(child: Text('So 1 Dai Co Viet, Hai Ba Trung, Ha Noi, Viet Nam',style: Theme.of(context).textTheme.bodyMedium,softWrap: true,)),

          ],
        ),
      ],
    );
  }
}
