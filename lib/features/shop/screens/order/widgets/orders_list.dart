import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:t_store/common/widgets/loaders/animation_loader.dart';
import 'package:t_store/features/shop/controllers/product/order_controller.dart';
import 'package:t_store/navigation_menu.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helper/cloud_helper_functions.dart';

import '../../../../../utils/helper/helper_function.dart';

class TOrderListItems extends StatelessWidget {
  const TOrderListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = DHelperFunctions.isDarkMode(context);
    final controller =    Get.put(OrderController());
    return FutureBuilder(
      future: controller.fetchUserOrders(),
      builder: ( _,  snapshot) {
        final emptyWidget = TAnimationLoaderWidget(
            text: 'Whoops! No Orders Yet!',
            animation: TImages.orderCompletedAnimation,
            showAction: true,
            actionText: 'Let\'s fill it',
        onActionPressed: ()=> Get.off(()=> NavigationMenu()),);
        final response =  TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot,nothingFound: emptyWidget);
        if(response!=null) return response;
        final orders = snapshot.data!;
        return  ListView.separated(
          separatorBuilder: (_, __) => const SizedBox(height: DSize.spaceBtwItem,),
          itemCount: orders.length,
          shrinkWrap: true,
          itemBuilder: (_,  index) {
            final order = orders[index];
            return TRoundedContainer(
              showBorder: true,
              padding: const EdgeInsets.all(DSize.md),
              backgroundColor: dark ? DColor.dark : DColor.light,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// Row 1
                  Row(
                    children: [
                      /// 1 Icon
                      const Icon(Iconsax.ship),
                      const SizedBox(
                        width: DSize.spaceBtwItem / 2,
                      ),

                      /// 2  Status and Date
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              order.orderStatusText,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .apply(color: DColor.primary, fontWeightDelta: 1),
                            ),
                            Text(
                              order.formattedOrderDate,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ],
                        ),
                      ),
                      //  3 Mui ten den man hinh chi tiet
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Iconsax.arrow_right_34,
                            size: DSize.iconSm,
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: DSize.spaceBtwItem,
                  ),

                  /// Row 2
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            /// 1 Icon
                            const Icon(Iconsax.tag),
                            const SizedBox(
                              width: DSize.spaceBtwItem / 2,
                            ),

                            /// 2  Status and Date
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Order',
                                      style: Theme.of(context).textTheme.labelMedium),
                                  Text(
                                   order.id,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            /// 1 Icon
                            const Icon(Iconsax.calendar),
                            const SizedBox(
                              width: DSize.spaceBtwItem / 2,
                            ),

                            /// 2  Status and Date
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Shipping Date',
                                      style: Theme.of(context).textTheme.labelMedium),
                                  Text(
                                    order.formattedDeliveryDate,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }

        );
      },

    );
  }
}
