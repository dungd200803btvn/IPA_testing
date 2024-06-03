import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/brands/t_brand_cart.dart';
import 'package:t_store/features/shop/models/brand_model.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helper/helper_function.dart';
import '../custom_shapes/containers/rounded_container.dart';

class TBranchShowCase extends StatelessWidget {
  const TBranchShowCase({
    super.key,
    required this.images,
  });

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      showBorder: true,
      borderColor: DColor.darkGrey,
      backgroundColor: Colors.transparent,
      margin: const EdgeInsets.only(bottom: DSize.spaceBtwItem),
      padding: const EdgeInsets.all(DSize.md),
      child: Column(
        children: [
          //Brand with product count
           TBrandCard(showBorder: false, brand: BrandModel.empty(),),
          const SizedBox(height: DSize.spaceBtwItem),
          //Brand top 3 product image
          Row(
            children: images
                .map((e) => branchTopProductImageWidget(e, context))
                .toList(),
          )
        ],
      ),
    );
  }

  Widget branchTopProductImageWidget(String image, BuildContext context) {
    return Expanded(
      child: TRoundedContainer(
        height: 100,
        backgroundColor: DHelperFunctions.isDarkMode(context)
            ? DColor.darkerGrey
            : DColor.light,
        margin: const EdgeInsets.only(right: DSize.sm),
        padding: const EdgeInsets.all(DSize.md),
        child: Image(fit: BoxFit.contain, image: AssetImage(image)),
      ),
    );
  }
}
