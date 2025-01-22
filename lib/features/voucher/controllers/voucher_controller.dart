import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:t_store/data/repositories/vouchers/ClaimedVoucherRepository.dart';
import 'package:t_store/data/repositories/vouchers/VoucherRepository.dart';
import 'package:t_store/features/voucher/models/VoucherModel.dart';
import '../../../data/repositories/authentication/authentication_repository.dart';
import '../../../utils/popups/loader.dart';
import '../models/UserClaimedVoucher.dart';

class VoucherController extends GetxController{
  static VoucherController get  instance => Get.find();
  final voucherRepository = VoucherRepository.instance;
  final claimedVoucherRepository = ClaimedVoucherRepository.instance;
  var claimedVouchers = <String>[].obs;
  Future<List<VoucherModel>> getAllVouchers() async {
    try {
      final vouchers = await voucherRepository.fetchAllVouchers();
      return vouchers;
    } catch (e) {
      TLoader.errorSnackbar(title: 'Address not found', message: e.toString());
      return [];
    }
  }
  Future<void> initializeClaimedVouchers(String userId) async {
    try{
      final vouchers = await claimedVoucherRepository.fetchUserClaimedVouchers(userId);
      final ids = vouchers.map((voucher)=> voucher.voucherId).toList();
      claimedVouchers.assignAll(ids);
    }catch (e){
      TLoader.errorSnackbar(
        title: 'Error',
        message: 'Failed to initialize claimed vouchers: $e',
      );
    }
  }
  @override
  void onInit() {
    super.onInit();
    // Gọi hàm khởi tạo giá trị claimedVouchers
    final userId = AuthenticationRepository.instance.authUser!.uid; // Cập nhật giá trị userId phù hợp
    initializeClaimedVouchers(userId);
  }

  // Hàm để nhận voucher
  Future<void> claimVoucher(String voucherId,String userId) async {
    final claimedVoucher = ClaimedVoucherModel(
      voucherId: voucherId,
      claimedAt: Timestamp.now(),
      isUsed: false,
    );
    try {
      if(await claimedVoucherRepository.isClaimed(userId, voucherId)){
        if(!claimedVouchers.contains(voucherId)){
          claimedVouchers.add(voucherId);
        }
      }else{
        claimedVouchers.add(voucherId);
        TLoader.successSnackbar(title: "Voucher claimed successfully!");
        await claimedVoucherRepository.claimVoucher(userId, claimedVoucher);
        final voucher = await voucherRepository.getVoucherById(voucherId);
        if(voucher!=null){
          final updatedVoucher = voucher.copyWith(
            remainingQuantity: voucher.remainingQuantity - 1,
            claimedUsers: (voucher.claimedUsers ?? [])..add(userId),
          );
          await voucherRepository.updateVoucher(voucherId, updatedVoucher.toJson());
        }


      }
    } catch (e) {
      if (kDebugMode) {
        print('Error claiming voucher: $e');
      }
    }
  }
}
