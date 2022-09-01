import 'package:code_zero/app/modules/mine/wallet/widget/wallet_info_widget.dart';
import 'package:code_zero/app/routes/app_routes.dart';
import 'package:code_zero/common/components/common_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'wallet_controller.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WalletPage extends GetView<WalletController> {
  const WalletPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: CommonAppBar(
        titleText: "我的钱包",
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Color(0xFF14181F),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Obx(
        () => FTStatusPage(
          type: controller.pageStatus.value,
          errorMsg: controller.errorMsg.value,
          builder: (BuildContext context) {
            return CustomScrollView(
              slivers: [
                _buildContent(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildContent() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (content, index) {
          if (index == 0) {
            return Obx(() => WalletInfoWidget(controller.model.value));
          }
          return _walletItem(index - 1);
        },
        childCount: 3,
      ),
    );
  }

  Widget _walletItem(int index) {
    var item = controller.menuList[index];
    return GestureDetector(
      onTap: () {
        if (index == 0) {
          Get.toNamed(RoutesID.DRAWING_PAGE);
        } else {
          Get.toNamed(RoutesID.TRANSACTIONS_PAGE);
        }
      },
      child: Container(
        padding: EdgeInsets.only(left: 15.w, right: 22.w),
        margin: EdgeInsets.only(
            top: index == 0 ? 15.w : 10.w, left: 15.w, right: 15.w),
        height: 60.w,
        decoration: BoxDecoration(
          color: Color(0xffF3F9FB),
          borderRadius: BorderRadius.circular(10.w),
        ),
        child: Row(
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: Color(0xffffffff),
                borderRadius: BorderRadius.circular(20.w),
              ),
              child: Image.asset(item.image),
            ),
            SizedBox(width: 15.w),
            Text(
              item.title,
              style: TextStyle(
                color: Color(0xff111111),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Expanded(child: SizedBox()),
            Icon(
              Icons.arrow_forward_ios,
              color: Color(0xFFABAAB9),
              size: 10.w,
            )
          ],
        ),
      ),
    );
  }
}
