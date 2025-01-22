import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:t_store/features/voucher/controllers/voucher_controller.dart';
import 'package:t_store/utils/constants/colors.dart';
import '../../../common/widgets/appbar/appbar.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helper/cloud_helper_functions.dart';
import '../../../utils/popups/loader.dart';

class VoucherScreen extends StatefulWidget{
  final String userId; // ID người dùng, sẽ truyền vào từ màn hình khác
  const VoucherScreen({super.key, required this.userId});
  @override
  State<VoucherScreen> createState() => _VoucherScreenState();
}

class _VoucherScreenState extends State<VoucherScreen> {
  bool showAllVouchers = false;
  @override
  Widget build(BuildContext context) {
    final controller = VoucherController.instance;
    return Scaffold(
      backgroundColor: Colors.white, // Nền trắng
      appBar: AppBar(

        title: Text(
          'Vouchers',
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.black), // Chữ đen
        ),
        backgroundColor: Colors.white, // Nền trắng cho AppBar
        foregroundColor: Colors.black, // Màu nút back
      ),
      body: Padding(
        padding: const EdgeInsets.all(DSize.defaultspace),
        child: FutureBuilder(
          future: controller.getAllVouchers(),
          builder: (context, snapshot) {
            final response = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot);
            if (response != null) return response;
            final vouchers = snapshot.data!;
            final displayedVouchers = showAllVouchers ? vouchers : vouchers.take(5).toList();

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(bottom: 16), // Thêm padding nếu cần
                    itemCount: displayedVouchers.length,
                    itemBuilder: (_, index) {
                      final voucher = displayedVouchers[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(color: DColor.grey.withOpacity(0.5)), // Viền mờ
                        ),
                        elevation: 4, // Bóng của Card
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: const LinearGradient(
                              colors: [Colors.white, Color(0xFFF0F0F0)], // Gradient nền
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: ListTile(
                            title: Text(
                              voucher.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            subtitle: Text(
                              voucher.description,
                              style: const TextStyle(color: Colors.black54),
                            ),
                            trailing: Obx(() {
                              final isClaimed = controller.claimedVouchers.contains(voucher.id);
                              return ElevatedButton(
                                onPressed: isClaimed
                                    ? () {
                                  TLoader.warningSnackbar(
                                    title: "This voucher has been received and cannot be received again",
                                  );
                                }
                                    : () {
                                  controller.claimVoucher(voucher.id, widget.userId);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: isClaimed ? DColor.grey : Colors.blue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  isClaimed ? 'Claimed' : "Claim",
                                  style: const TextStyle(color: Colors.white),
                                ),
                              );
                            }),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                if (!showAllVouchers && vouchers.length > 5)
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        showAllVouchers = true;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Xem thêm',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

