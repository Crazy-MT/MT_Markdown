import 'package:code_zero/common/components/safe_tap_widget.dart';

import '../../../../../common/custom_indicator.dart';
import '../../../../../utils/log_utils.dart';
import '../../../../routes/app_routes.dart';
import 'my_fans_controller.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:code_zero/common/colors.dart';
import 'package:code_zero/common/components/common_app_bar.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:code_zero/generated/assets/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MyFansPage extends GetView<MyFansController> {
  const MyFansPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: Obx(
        () => FTStatusPage(
          type: controller.pageStatus.value,
          errorMsg: controller.errorMsg.value,
          builder: (BuildContext context) {
            return Column(
              children: [
                _buildHeaderAppBar(),
                _buildHeader(),
                _tabTitleWidget(),
                _tabContentWidget(),

                // _buildCommissionList(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeaderAppBar() {
    return CommonAppBar(
      centerTitle: true,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        color: Color(0xFF14181F),
        onPressed: () {
          Get.back();
        },
      ),
      actions: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          alignment: Alignment.center,
          color: Colors.transparent,
          child: SafeTapWidget(
            onTap: () {
              Get.toNamed(RoutesID.FANS_ORDER_PAGE);
            },
            child: Text(
              '粉丝订单',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14.sp,
              ),
            ),
          ),
        ),
      ],
      titleText: "我的粉丝",
    );
  }

  _buildHeader() {
    return Container(
      alignment: Alignment.center,
      width: 345.w,
      height: 100.w,
      margin: EdgeInsets.all(15.w).copyWith(bottom: 10.w),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            Assets.imagesMyCommissionBg,
          ),
          fit: BoxFit.fill,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "今日邀请",
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Color(0xFF434446),
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 8.w,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "456",
                      style: TextStyle(
                        fontSize: 28.sp,
                        color: AppColors.text_dark,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      text: "人",
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.text_dark,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "历史邀请",
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Color(0xFF434446),
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 8.w,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "456",
                      style: TextStyle(
                        fontSize: 28.sp,
                        color: AppColors.text_dark,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      text: "人",
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.text_dark,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
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
          unselectedLabelStyle:
              TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }

  List<Widget> _tabItemWidget(List<String> data) {
    return data.map((String item) {
      return Text(item);
    }).toList();
  }

  _buildCommissionList() {
    if (controller.commissionList.isEmpty) {
      return Container(
          width: 345,
          height: 69.w,
          margin: EdgeInsets.symmetric(
            horizontal: 15.w,
            vertical: 3.w,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.w),
          ),
          alignment: Alignment.center,
          padding: EdgeInsets.all(15.w),
          child: Text("暂无记录"));
    }
    return ListView.separated(
      // padding: EdgeInsets.symmetric(vertical: 15.w),
      itemBuilder: (BuildContext context, int index) {
        return _buildCommissionItem(index);
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(height: 10.w);
      },
      itemCount: controller.commissionList.length,
    );
  }

  _buildCommissionItem(index) {
    return Container(
      width: 345,
      height: 69.w,
      margin: EdgeInsets.symmetric(
        horizontal: 15.w,
        vertical: 3.w,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.w),
      ),
      padding: EdgeInsets.all(15.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /*ClipOval(
            child: CachedNetworkImage(
              imageUrl:
                  "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fc-ssl.duitang.com%2Fuploads%2Fblog%2F202107%2F05%2F20210705140730_666eb.thumb.1000_0.jpeg&refer=http%3A%2F%2Fc-ssl.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1663560845&t=9ee89b2b30e3b41ada6612b73b939b8f",
              width: 36.w,
              height: 36.w,
            ),
          ),*/
          SizedBox(
            width: 10.w,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "用户名：翠翠",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  height: 1,
                ),
              ),
              SizedBox(
                height: 6.w,
              ),
              Text(
                "2022-08-18 13:00:23",
                style: TextStyle(
                  color: Color(0xFFABAAB9),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  height: 1,
                ),
              ),
            ],
          ),
          Expanded(child: SizedBox()),
          Text(
            "+18.46",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }

  _tabContentWidget() {
    return Expanded(
      child: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: controller.tabController,
        children: [
          _buildCommissionList(),
          _buildCommissionList(),
        ],
      ),
    );
  }

}
