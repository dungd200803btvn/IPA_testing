import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/features/personalization/controllers/address_controller.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/validators/validation.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    return Scaffold(
      appBar: const TAppBar(
        showBackArrow: true,
        title: Text('Add new address'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(DSize.defaultspace),
          child: Form(
            key: controller.addressFormkey,
            child: Column(
              children: [
                TextFormField(
                  controller: controller.name,
                  validator: (value) =>DValidator.validateEmptyText('Name', value),
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.user), labelText: 'Name'),
                ),
                const SizedBox(
                  height: DSize.spaceBtwInputFielRadius,
                ),
                TextFormField(
                  controller: controller.phoneNumber,
                  validator: DValidator.validatePhoneNumber,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.mobile),
                      labelText: 'Phone number'),
                ),
                const SizedBox(
                  height: DSize.spaceBtwInputFielRadius,
                ),
                Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                          controller: controller.street,
                          validator: (value) =>DValidator.validateEmptyText('Street', value),
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.building_31),
                          labelText: 'Street'),
                    )),
                    const SizedBox(
                      width: DSize.spaceBtwInputFielRadius,
                    ),
                    Expanded(
                        child: TextFormField(
                          controller: controller.commune,
                          validator: (value) =>DValidator.validateEmptyText('Commune', value),
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.code),
                          labelText: 'Commune'),
                    ))
                  ],
                ),
                const SizedBox(
                  height: DSize.spaceBtwInputFielRadius,
                ),
                Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                          controller: controller.district,
                          validator: (value) =>DValidator.validateEmptyText('District', value),
                          expands: false,
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Iconsax.activity),
                              labelText: 'District'),
                        )),
                    const SizedBox(
                      width: DSize.spaceBtwInputFielRadius,
                    ),
                    Expanded(
                        child: TextFormField(
                          controller: controller.city,
                          validator: (value) =>DValidator.validateEmptyText('City', value),
                          expands: false,
                          decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.building),
                          labelText: 'City'),
                    )),


                  ],
                ),
                const SizedBox(
                  height: DSize.spaceBtwInputFielRadius,
                ),
                TextFormField(
                  controller: controller.country,
                  validator: (value) =>DValidator.validateEmptyText('Country', value),
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.global), labelText: 'Country'),
                ),
                const SizedBox(
                  height: DSize.defaultspace,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        controller.addNewAddresses();
                      }, child: const Text('Save')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
