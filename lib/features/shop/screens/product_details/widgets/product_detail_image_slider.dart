import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import '../../../../../common/widgets/icons/t_circular_icon.dart';
import '../../../../../common/widgets/images/t_rounded_image.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helper/helper_function.dart';
class TProductImageSlider extends StatelessWidget {
  const TProductImageSlider({
    super.key,

  });
  @override
  Widget build(BuildContext context) {
    final dark = DHelperFunctions.isDarkMode(context);
    return TCurvedEdgeWidget(
      child: Container(
        color: dark ? DColor.darkerGrey : DColor.light,
        child: Stack(
          children: [
            //1.1 Main Larger Image
            const SizedBox(
              height: 400,
              child: Padding(
                padding:
                EdgeInsets.all(DSize.productImageRadius * 2),
                child: Center(
                    child: Image(
                        image: AssetImage(TImages.productImage5))),
              ),
            ),

            //1.2 Image Slider
            Positioned(
              right: 0,
              bottom: 30,
              left: DSize.defaultspace,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  itemBuilder: (_, index) => TRoundedImage(
                    imageUrl: TImages.productImage3,
                    width: 80,
                    backgroundColor: dark ? DColor.dark : DColor.white,
                    border: Border.all(color: DColor.primary),
                    padding: const EdgeInsets.all(DSize.sm),
                  ),
                  separatorBuilder: (_, __) =>
                      const SizedBox(width: DSize.spaceBtwItem),
                  itemCount: 8,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                ),
              ),
            ),
            //1.3 Appbar Icon
            const TAppBar(
              showBackArrow: true,
              actions: [
                TCircularIcon(icon: Iconsax.heart5, color: Colors.red)
              ],
            )
          ],
        ),
      ),
    );
  }
}