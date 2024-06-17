import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/features/shop/controllers/home_controller.dart';
import 'package:t_store/features/shop/screens/all_products/all_product_run_local.dart';
import 'package:t_store/features/shop/screens/all_products/all_products.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/helper/helper_function.dart';
import 'package:t_store/utils/validators/validation.dart';

class TSearchContainer extends StatelessWidget {
  const TSearchContainer({
    super.key,
    required this.text,
    this.icon = Iconsax.search_normal,
    this.showBackground = true,
    this.showBorder = true,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0),
  });

  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final dark = DHelperFunctions.isDarkMode(context);
    final controller = Get.put(HomeController());

    return Padding(
      padding: padding,
      child: TextFormField(
        controller: controller.query,
        validator: (value) => DValidator.validateEmptyText("search", value),
        decoration: InputDecoration(
          filled: showBackground,
          fillColor: showBackground ? (dark ? DColor.dark : DColor.light) : Colors.transparent,
          border: showBorder ? OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: dark ? DColor.dark : DColor.grey),
          ) : InputBorder.none,
          hintText: 'Search...',
          hintStyle: TextStyle(color: DColor.grey),
          suffixIcon: IconButton(
            icon: Icon(Iconsax.search_normal),
            color: DColor.grey,
            onPressed: () {
              // Thực hiện hành động khi bấm vào icon search
              Get.to(() => const AllProductsByLocal(
                title: 'Search Result',
               // products: controller.getProductsBySearchQuery(controller.query.text.trim().toString()),
              ));
            },
          ),
          contentPadding: const EdgeInsets.all(12.0),
        ),
      ),
    );
  }
}
