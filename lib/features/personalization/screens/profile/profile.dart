import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/images/t_circular_image.dart';
import 'package:t_store/common/widgets/shimmer/shimmer.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/features/personalization/screens/profile/widgets/change_name.dart';
import 'package:t_store/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';

import '../../controllers/user_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: const TAppBar(showBackArrow: true, title: Text('Profile')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(DSize.defaultspace),
          child: Column(
            children: [
              //Profile Picture
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Obx(() {
                      final networkImage = controller.user.value.profilePicture;
                      final image = networkImage.isNotEmpty? networkImage: TImages.user;
                      return  controller.imageUploading.value? const TShimmerEffect(width: 80, height:80,radius: 80,):
                        TCircularImage(
                          image: image, width: 100, height: 100,isNetworkImage: networkImage.isNotEmpty,);
                    }),
                    TextButton(
                        onPressed: () => controller.uploadUserProfilePicture(),
                        child: const Text('Change Profile Picture')),
                  ],
                ),
              ),

              //Detail
              const SizedBox(height: DSize.spaceBtwItem / 2),
              const Divider(),
              const SizedBox(height: DSize.spaceBtwItem),
              //Heading Profile Info
              const TSectionHeading(
                  title: 'Profile Information', showActionButton: false),
              const SizedBox(height: DSize.spaceBtwItem),
              Obx(() => TProfileMenu(
                  onPressed: () => Get.to(() => const ChangeName()),
                  title: 'Name',
                  value: controller.user.value.fullname)),
              Obx(() => TProfileMenu(
                  onPressed: () {},
                  title: 'Username',
                  value: controller.user.value.userName)),
              const SizedBox(height: DSize.spaceBtwItem),
              const Divider(),
              const SizedBox(height: DSize.spaceBtwItem),
              //Heading Personal Info
              const TSectionHeading(
                  title: 'Personal Information', showActionButton: false),
              const SizedBox(height: DSize.spaceBtwItem),
              Obx(() => TProfileMenu(
                  onPressed: () {},
                  title: 'User ID',
                  value: controller.user.value.id)),
              Obx(() => TProfileMenu(
                  onPressed: () {},
                  title: 'E-mail',
                  value: controller.user.value.email)),
              Obx(() => TProfileMenu(
                  onPressed: () {},
                  title: 'Phone number',
                  value: controller.user.value.phoneNumber)),
              TProfileMenu(onPressed: () {}, title: 'Gender', value: 'Male'),
              TProfileMenu(
                  onPressed: () {},
                  title: 'Date of Birth',
                  value: '20 August, 2003'),
              const Divider(),
              const SizedBox(height: DSize.spaceBtwItem),
              Center(
                  child: TextButton(
                onPressed: () => controller.deleteAccountWarningPopup(),
                child: const Text(
                  'Close Account',
                  style: TextStyle(color: Colors.red),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
