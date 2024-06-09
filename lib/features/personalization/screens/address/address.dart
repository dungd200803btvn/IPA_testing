import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/features/personalization/controllers/address_controller.dart';
import 'package:t_store/features/personalization/screens/address/widgets/single_address.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helper/cloud_helper_functions.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/colors.dart';
import 'add_new_address.dart';
class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    return  Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: DColor.primary,
        onPressed: ()=> Get.to(()=> const AddNewAddressScreen()),
        child: const Icon(Iconsax.add,color: DColor.white,),
      ),
      appBar: TAppBar(
        showBackArrow: true,
        title: Text('Addresses',style: Theme.of(context).textTheme.headlineSmall,),
      ),
      body:  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(DSize.defaultspace),
          child: Obx(
              ()=> FutureBuilder(
                key: Key(controller.refreshData.value.toString()),
                future: controller.getAllUserAddresses(),
                builder: (context,snapshot){
              final response = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot);
              if(response!=null) return response;
              final addresses = snapshot.data!;
              return ListView.builder(
                shrinkWrap: true,
                  itemCount: addresses.length,
                  itemBuilder: (_,index)
                  => TSingleAddress(
                    address: addresses[index],
                    onTap: () =>controller.selectAddress(addresses[index]),));
            
            }),
          ),
        ),
      ),
    );
  }
}
