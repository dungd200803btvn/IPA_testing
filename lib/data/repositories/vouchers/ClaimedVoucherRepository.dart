import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../features/voucher/models/UserClaimedVoucher.dart';

class ClaimedVoucherRepository {
  static ClaimedVoucherRepository get instance => ClaimedVoucherRepository();
  final _db = FirebaseFirestore.instance;

  // Fetch all claimed vouchers for a user
  Future<List<ClaimedVoucherModel>> fetchUserClaimedVouchers(String userId) async {
    try {
      final result = await _db.collection('User').doc(userId).collection('claimed_vouchers').get();
      return result.docs.map((doc) => ClaimedVoucherModel.fromSnapshot(doc)).toList();
    } catch (e) {
      throw 'Error fetching claimed vouchers: $e';
    }
  }

  // Claim a voucher
  Future<void> claimVoucher(String userId, ClaimedVoucherModel claimedVoucher) async {
    try {
      await _db
          .collection('User')
          .doc(userId)
          .collection('claimed_vouchers')
          .add(claimedVoucher.toJson());
    } catch (e) {
      throw 'Error claiming voucher: $e';
    }
  }
  
  Future<bool> isClaimed(String userId, String voucherId) async {
    final querySnapshot = await _db
        .collection('User')
        .doc(userId)
        .collection('claimed_vouchers')
        .where('voucher_id', isEqualTo: voucherId)
        .get();
    return querySnapshot.docs.isNotEmpty;
  }

  // Update claimed voucher (e.g., mark as used)
  Future<void> updateClaimedVoucher(String userId, String claimedVoucherId, Map<String, dynamic> updates) async {
    try {
      await _db
          .collection('User')
          .doc(userId)
          .collection('claimed_vouchers')
          .doc(claimedVoucherId)
          .update(updates);
    } catch (e) {
      throw 'Error updating claimed voucher: $e';
    }
  }
}
