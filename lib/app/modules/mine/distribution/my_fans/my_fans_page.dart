import 'package:cached_network_image/cached_network_image.dart';
import 'package:code_zero/app/modules/mine/distribution/model/fans_list_model.dart';
import 'package:code_zero/common/colors.dart';
import 'package:code_zero/common/components/common_app_bar.dart';
import 'package:code_zero/common/components/safe_tap_widget.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:code_zero/generated/assets/assets.dart';
import 'package:code_zero/utils/log_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../common/custom_indicator.dart';
import '../../../../routes/app_routes.dart';
import 'my_fans_controller.dart';

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
                      text:
                          "${controller.fansStatistics.value?.todayCount ?? 0}",
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
                      text:
                          "${controller.fansStatistics.value?.historyCount ?? 0}",
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
          isScrollable: true,
          padding: EdgeInsets.symmetric(horizontal: 10.w),
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

  Widget _buildCommissionList(int index) {
    lLog(
        'MTMTMT MyFansPage._buildCommissionList ${controller.fansDataList.length} ${controller.fansDataList[index]?.items?.length} ');
    if (controller.fansDataList.length < index) {
      return SizedBox();
    }

    if ((controller.fansDataList[index]?.items ?? []).isEmpty) {
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
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(Get.context!).padding.bottom),
      itemBuilder: (BuildContext context, int inde) {
        lLog(
            'MTMTMT MyFansPage._buildCommissionList ${index} ${controller.fansDataList.length}');
        return _buildCommissionItem(
            controller.fansDataList[index]!.items![inde]);
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(height: 10.w);
      },
      itemCount: controller.fansDataList[index]!.items?.length ?? 0,
    );
  }

  _buildCommissionItem(FansItem data) {
    return Container(
      width: 345,
      height: 90.w,
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
          Container(
            width: 36.w,
            height: 45.w,
            // color: Colors.red,
            child: Stack(
              children: [
                Container(
                  width: 36.w,
                  height: 36.w,

                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: data.avatarUrl ?? "",
                      fit: BoxFit.fill,
                      errorWidget: (_, __, ___) {
                        return Image.asset(Assets.iconsAvatarPlaceholder);
                      },
                      placeholder: (_, __) {
                        return Image.asset(Assets.iconsAvatarPlaceholder);
                      },
                    ),
                  ),
                ),
                (data.isCaptain ?? 0) == 1
                    ? Positioned(
                        bottom: 0,
                        child: Image.asset(
                          Assets.iconsCaptain,
                          width: 20.w,
                        ))
                    : SizedBox.shrink(),
              ],
              alignment: (data.isCaptain ?? 0) == 1
                  ? AlignmentDirectional.topCenter
                  : AlignmentDirectional.center,
            ),
          ),
          // ClipOval(
          //   child: CachedNetworkImage(
          //     imageUrl: data.avatarUrl ?? "",
          //     width: 36.w,
          //     height: 36.w,
          //     fit: BoxFit.cover,
          //     placeholder: (_, __) {
          //       return Image.asset(Assets.iconsAvatarPlaceholder);
          //     },
          //     errorWidget: (_, __, ___) {
          //       return Image.asset(Assets.iconsAvatarPlaceholder);
          //     },
          //   ),
          // ),
          SizedBox(
            width: 10.w,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "用户名：${data.nickname}",
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
                data.createdAt ?? "",
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
          Visibility(
            visible: false,
            child: Text(
              "+18.46",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                height: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _tabContentWidget() {
    return Expanded(
      child: Obx(() {
        return TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: controller.tabController,
          // children: [
          //   _buildCommissionList(),
          //   _buildCommissionList(),
          // ],
          // children: controller.tabList.map((e) => _buildCommissionList()).toList(),
          children: controller.tabList.asMap().keys.map(
            (index) {
              return Obx(() {
                return _buildCommissionList(index);
              });
            },
          ).toList(),
        );
      }),
    );
  }
}
