import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:t_store/features/voucher/models/VoucherTabStatus.dart';
import 'package:t_store/utils/constants/colors.dart';

import '../../../common/widgets/appbar/appbar.dart';
import '../controllers/voucher_controller.dart';
import '../widgets/voucher_tab.dart';

class HistoryScreen extends StatefulWidget {
  final String userId;
  const HistoryScreen({super.key, required this.userId});
  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final controller = VoucherController.instance;
  bool showAllVouchersTab1 = false;
  bool showAllVouchersTab2 = false;
  bool showAllVouchersTab3 = false;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this); // 3 tabs
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DColor.white,
      appBar: AppBar(
        title: const Text('Voucher History'),
        backgroundColor: Colors.white, // Nền trắng cho AppBar
        foregroundColor: Colors.black, // Màu nút back
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.blue,
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.grey,
          tabs: const [
            Tab(text: 'Đã nhận'),
            Tab(text: 'Đã dùng'),
            Tab(text: 'Hết hạn'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          DVoucherTab(voucherFuture: controller.getUserClaimedVoucher(widget.userId),
            showAllVouchers: showAllVouchersTab1,
            voucherTabStatus: VoucherTabStatus.claimed,
            onToggleShowAll: () {
              setState(() {
                showAllVouchersTab1 = !showAllVouchersTab1;
              });
            },),
          DVoucherTab(voucherFuture: controller.getUsedVoucher(widget.userId),
            showAllVouchers: showAllVouchersTab2,
            voucherTabStatus: VoucherTabStatus.used,
            onToggleShowAll: () {
              setState(() {
                showAllVouchersTab2 = !showAllVouchersTab2;
              });
            },),
          DVoucherTab(voucherFuture: controller.getExpiredVouchers(),
            showAllVouchers: showAllVouchersTab3,
            voucherTabStatus: VoucherTabStatus.expired,
            onToggleShowAll: () {
              setState(() {
                showAllVouchersTab3 = !showAllVouchersTab3;
              });
            },),
        ],
      ),
    );
  }
}
