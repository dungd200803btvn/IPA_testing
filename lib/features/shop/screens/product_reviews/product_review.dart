import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/features/shop/screens/product_reviews/widgets/rating_progress_indicator.dart';
import 'package:t_store/features/shop/screens/product_reviews/widgets/user_review_card.dart';
import 'package:t_store/utils/constants/sizes.dart';

import '../../../../common/widgets/products/ratings/rating_indicator.dart';
class ProductReviewScreen extends StatelessWidget {
  const ProductReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const TAppBar(title: Text('Reviews & Ratings'),showBackArrow: true,),
      body: SingleChildScrollView(
child: Padding(
  padding: const EdgeInsets.all(DSize.defaultspace),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('Ratings and reviews are verified  and are from  people who use the same type of device that you use'),
      const SizedBox(height: DSize.spaceBtwItem,),

      //Overal product rating
        const TOverallProductRating(),
      const TRatingBarIndicator(rating: 4.5,),
      Text('12611',style: Theme.of(context).textTheme.bodySmall,),
      const SizedBox(height: DSize.spaceBtwSection,),
      //User review list
      const UserReviewCard(),
      const UserReviewCard(),
      const UserReviewCard(),
      const UserReviewCard(),
      const UserReviewCard(),
    ],
  ),
),
      ),
    );
  }
}





