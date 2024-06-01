import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:t_store/common/widgets/products/ratings/rating_indicator.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helper/helper_function.dart';
class UserReviewCard extends StatelessWidget {
  const UserReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = DHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const CircleAvatar(backgroundImage: AssetImage(TImages.userProfileImage1),),
                const SizedBox(width: DSize.spaceBtwItem,),
                Text('John Doe',style: Theme.of(context).textTheme.titleLarge,)
              ],
            ),
            IconButton(onPressed: (){}, icon: const Icon(Icons.more_vert))
          ],
        ),
        const SizedBox(height: DSize.spaceBtwItem,),
        //Review
        Row(
          children: [
            const TRatingBarIndicator(rating: 4.0),
            const SizedBox(width: DSize.spaceBtwItem,),
            Text('01 August 2024',style: Theme.of(context).textTheme.bodyMedium,)
          ],
        ),
        const SizedBox(height: DSize.spaceBtwItem,),
        const ReadMoreText("The user interface of the app  is quite intuitive."
            "I was able to navigate and make purchases seamlessly.Great job.",
        trimLines: 2,
        trimExpandedText: 'show less',
        trimCollapsedText: 'show more',
        trimMode: TrimMode.Line,
        moreStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: DColor.primary),
        lessStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: DColor.primary),

        ),
        const SizedBox(height: DSize.spaceBtwItem),

        //Company Review
        TRoundedContainer(
          backgroundColor: dark? DColor.darkerGrey:DColor.grey,
          child: Padding(
            padding: const EdgeInsets.all(DSize.md),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("DStore",style: Theme.of(context).textTheme.bodyLarge),
                    Text('02 Nov 2023',style: Theme.of(context).textTheme.bodyMedium)
                  ],
                ),
                const SizedBox(height: DSize.spaceBtwItem,),
                const ReadMoreText("The user interface of the app  is quite intuitive."
                    "I was able to navigate and make purchases seamlessly.Great job.",
                  trimLines: 2,
                  trimExpandedText: 'show less',
                  trimCollapsedText: 'show more',
                  trimMode: TrimMode.Line,
                  moreStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: DColor.primary),
                  lessStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: DColor.primary),

                ),

              ],
            ),
          ),
        ),
        const SizedBox(height: DSize.spaceBtwItem,),
      ],
    );
  }
}
