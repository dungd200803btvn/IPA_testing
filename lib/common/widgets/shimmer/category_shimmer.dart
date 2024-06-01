import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/shimmer/shimmer.dart';
import 'package:t_store/utils/constants/sizes.dart';
class TCategoryShimmer extends StatelessWidget {
  const TCategoryShimmer({super.key,
     this.itemCount =6});
final int itemCount;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
          itemBuilder: (_,__){
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Image
                TShimmerEffect(width: 55, height: 55,radius: 55,),
                SizedBox(height: DSize.spaceBtwItem/2,),
                //Text
                TShimmerEffect(width: 55, height: 8),
              ],
            );
          },
          separatorBuilder: (_,__)=> SizedBox(width: DSize.spaceBtwItem,),
          itemCount: itemCount,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,),
    );
  }
}
