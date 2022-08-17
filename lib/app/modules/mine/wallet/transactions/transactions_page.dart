import 'package:code_zero/common/components/common_app_bar.dart';
import 'package:code_zero/generated/assets/flutter_assets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'transactions_controller.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionsPage extends GetView<TransactionsController> {
  const TransactionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: CommonAppBar(
        titleText: "提现记录",
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
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (content, index) {
            if (index == 0 || index == 3) {
              return _dateWidget();
            }
            return _transactionsItem(index);
          },
          childCount: 6,
        ),
      ),
    );
  }

  Widget _dateWidget() {
    return Container(
      height: 48.w,
      alignment: Alignment.centerLeft,
      child: Text(
        '2022年8月',
        style: TextStyle(
          color: Color(0xff111111),
          fontSize: 13,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _transactionsItem(int index) {
    return Container(
      padding: EdgeInsets.only(left: 15.w, right: 22.w),
      margin: EdgeInsets.only(bottom: 5.w),
      height: 80.w,
      decoration: BoxDecoration(
        color: Color(0xffffffff),
        borderRadius: BorderRadius.circular(10.w),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(Assets.imagesWalletTransactionsIcon,
              width: 50, height: 50),
          SizedBox(width: 15.w),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '提现-至招商银行（5667）',
                        style: TextStyle(
                          color: Color(0xff434446),
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Text(
                      '30000.00',
                      style: TextStyle(
                        color: Color(0xff111111),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 11.w),
                Text(
                  '2022.08.17 12:34:54',
                  style: TextStyle(
                    color: Color(0xffABAAB9),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
