import 'package:code_zero/app/modules/mine/collection_settings/widget/alipay_info_widget.dart';
import 'package:code_zero/app/modules/mine/collection_settings/widget/bank_card_info_widget.dart';
import 'package:code_zero/app/modules/mine/collection_settings/widget/wechat_info_widget.dart';
import 'package:code_zero/app/routes/app_routes.dart';
import 'package:code_zero/common/colors.dart';
import 'package:code_zero/common/components/common_app_bar.dart';
import 'package:code_zero/common/custom_indicator.dart';
import 'package:code_zero/utils/log_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'collection_settings_controller.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CollectionSettingsPage extends GetView<CollectionSettingsController> {
  const CollectionSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      resizeToAvoidBottomInset: false,
      appBar: CommonAppBar(
        titleText: Get.arguments == null ? "收款方式" : (Get.arguments['title'] ?? "收款方式"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Color(0xFF14181F),
          onPressed: () {
            if(Get.arguments?['from'] == RoutesID.HOME_PAGE) {
              return;
            }
            controller.goBack();
          },
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Obx(
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
          WechatInfoWidget(),
          BankCardInfoWidget(),
          AlipayInfoWidget(),
        ],
      ),
    );
  }
}
