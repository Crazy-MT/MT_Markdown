import 'package:code_zero/app/modules/mine/collection/widget/alipay_info_widget.dart';
import 'package:code_zero/app/modules/mine/collection/widget/bank_card_info_widget.dart';
import 'package:code_zero/app/modules/mine/collection/widget/wechat_info_widget.dart';
import 'package:code_zero/common/colors.dart';
import 'package:code_zero/common/components/common_app_bar.dart';
import 'package:code_zero/common/custom_indicator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'collection_controller.dart';

class CollectionPage extends GetView<CollectionController> {
  const CollectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      resizeToAvoidBottomInset: false,
      appBar: CommonAppBar(
        titleText: "收款信息",
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Color(0xFF14181F),
          onPressed: () {
            controller.goBack();
          },
        ),
      ),
      body: Obx(
        () => FTStatusPage(
          type: controller.pageStatus.value,
          errorMsg: controller.errorMsg.value,
          builder: (BuildContext context) {
            return Column(
              children: [
                _tabTitleWidget(),
                _tabContentWidget(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _tabTitleWidget() {
    return Container(
      width: double.infinity,
      height: 43.w,
      color: Colors.transparent,
      child: Theme(
        data: ThemeData(
          splashColor: Colors.transparent, // 点击时的水波纹颜色设置为透明
          highlightColor: Colors.transparent, // 点击时的背景高亮颜色设置为透明
        ),
        child: TabBar(
          controller: controller.tabController,
          isScrollable: false,
          padding: EdgeInsets.symmetric(horizontal: 60.w),
          indicator: CustomIndicator(
            width: 15.w,
            height: 3.5.w,
            color: AppColors.green,
          ),
          tabs: _tabItemWidget(controller.tabList),
          indicatorPadding: EdgeInsets.only(bottom: 5.w),
          labelColor: Color(0xff111111),
          unselectedLabelColor: Color(0xff434446),
          labelStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
          unselectedLabelStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }

  List<Widget> _tabItemWidget(List<String> data) {
    return data.map((String item) {
      return Text(item);
    }).toList();
  }

  Widget _tabContentWidget() {
    return Expanded(
      child: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: controller.tabController,
        children: [
          BankCardInfoWidget(),
          WechatInfoWidget(),
          AlipayInfoWidget()
        ],
      ),
    );
  }
}
