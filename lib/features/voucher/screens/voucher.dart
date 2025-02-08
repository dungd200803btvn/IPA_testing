import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:t_store/features/voucher/controllers/voucher_controller.dart';
import 'package:t_store/features/voucher/screens/voucher_history.dart';
import 'package:t_store/features/voucher/widgets/voucher_tab.dart';
import 'package:t_store/utils/constants/colors.dart';
import '../../../common/widgets/appbar/appbar.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helper/cloud_helper_functions.dart';
import '../../../utils/popups/loader.dart';
import '../models/VoucherModel.dart';

class VoucherScreen extends StatefulWidget{
  final String userId; // ID người dùng, sẽ truyền vào từ màn hình khác
  const VoucherScreen({super.key, required this.userId});
  @override
  State<VoucherScreen> createState() => _VoucherScreenState();
}

class _VoucherScreenState extends State<VoucherScreen>
    with SingleTickerProviderStateMixin {
  final controller = VoucherController.instance;
  late TabController _tabController;
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
        backgroundColor: Colors.white, // Nền trắng cho AppBar
        foregroundColor: Colors.black, // Màu nút back
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Vouchers',
              style: Theme
                  .of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: Colors.black), // Chữ đen
            ),
            GestureDetector(
              onTap: () {
                // Điều hướng đến màn hình "HistoryScreen"
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HistoryScreen(userId: widget.userId),
                  ),
                );
              },
              child: Text(
                'History',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.blue,
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.grey,
          tabs: const [
            Tab(text: 'Tất cả'),
            Tab(text: 'Toàn sàn'),
            Tab(text: 'Vận chuyển & cửa hàng'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          DVoucherTab(voucherFuture: controller.getAllVouchers(),
            showAllVouchers: showAllVouchersTab1,
            onToggleShowAll: () {
              setState(() {
                showAllVouchersTab1 = !showAllVouchersTab1;
              });
            },),
          DVoucherTab(voucherFuture: controller.getEntirePlatformVouchers(),
            showAllVouchers: showAllVouchersTab2,
            onToggleShowAll: () {
              setState(() {
                showAllVouchersTab2 = !showAllVouchersTab2;
              });
            },),
          DVoucherTab(voucherFuture: controller.getFreeShippingVouchers(),
            showAllVouchers: showAllVouchersTab3,
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
