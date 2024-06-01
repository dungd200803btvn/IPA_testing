import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helper/helper_function.dart';

import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
class TSingleAddress extends StatelessWidget {
  const TSingleAddress({super.key,
    required this.selectedAddress});
final bool selectedAddress;
  @override
  Widget build(BuildContext context) {
    final dark = DHelperFunctions.isDarkMode(context);
    return TRoundedContainer(
      padding: const EdgeInsets.all(DSize.md),
      width: double.infinity,
      showBorder: true,
      backgroundColor: selectedAddress? DColor.primary.withOpacity(0.5):Colors.transparent,
      borderColor: selectedAddress? Colors.transparent: dark? DColor.darkerGrey:DColor.grey,
      margin: const EdgeInsets.only(bottom: DSize.spaceBtwItem),
      child: Stack(
        children: [
          Positioned(
            right: 5,
            top: 0,
            child: Icon(
              selectedAddress? Iconsax.tick_circle5: null,
              color: selectedAddress? dark? DColor.light:DColor.dark.withOpacity(0.2):null,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Le Chi Dung',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleLarge,),
              const SizedBox(height: DSize.sm/2,),
              const Text('(+84) 0335620803',maxLines: 1,overflow: TextOverflow.ellipsis,),
              const SizedBox(height: DSize.sm/2,),
              const Text('So 1 Dai Co Viet, Hai Ba Trung Ha Noi Viet Nam',softWrap: true,)
            ],
          )
        ],
      ),
    );
  }
}
