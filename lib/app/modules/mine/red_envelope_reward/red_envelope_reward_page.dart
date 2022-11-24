import 'package:cached_network_image/cached_network_image.dart';
import 'package:code_zero/app/modules/home/model/red_envelope_reward.dart';
import 'package:code_zero/app/modules/mine/model/order_list_model.dart';
import 'package:code_zero/common/S.dart';
import 'package:code_zero/common/colors.dart';
import 'package:code_zero/common/components/common_app_bar.dart';
import 'package:date_format/date_format.dart' as time;
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'red_envelope_reward_controller.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RedEnvelopeRewardPage extends GetView<RedEnvelopeRewardController> {
  const RedEnvelopeRewardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg_gray,
      appBar: CommonAppBar(
        titleText: "红包奖励",
        centerTitle: true,
      ),
      body: Obx(
        () => FTStatusPage(
          type: controller.pageStatus.value,
          errorMsg: controller.errorMsg.value,
          controller: controller.refreshController,
          builder: (BuildContext context) {
            return Stack(
              children: [
                Image.asset('assets/icons/task_bg.png'),
                CustomScrollView(
                  slivers: [
                    _buildHeader(),
                    Obx(() {
                      return _buildCommissionList();
                    }),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  _buildCommissionList() {
    if (controller.rewardList.isEmpty) {
      return SliverToBoxAdapter(
        child: Container(
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
            child: Text("暂无记录")),
      );
    }
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (content, index) {
          return _buildCommissionItem(index);
        },
        childCount: controller.rewardList.length,
      ),
    );
  }

  _buildCommissionItem(index) {
    Items? item = controller.rewardList[index];
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
          ClipOval(
            child: CachedNetworkImage(
              imageUrl: item?.avatarUrl ?? "",
              width: 36.w,
              height: 36.w,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "用户名：${item?.nickname}",
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
                item?.createdAt ?? "",
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
            item?.amount ?? "",
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

  _buildTitle() {
    return RichText(
        text: TextSpan(children: [
          TextSpan(
              text: '尊敬的用户，截止',
              style: TextStyle(color: S.colors.white, fontSize: 12.sp)),
          TextSpan(text: time.formatDate(DateTime.now(), [time.yyyy, '-', time.mm, '-', time.dd,' ',  time.HH, ':', time.nn, ':', time.ss])),
          TextSpan(text: '您参与任务情况如下：')
        ]));
  }

  _buildHeader() {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          SizedBox(
            height: 14.w,
          ),
          _buildTitle(),
          SizedBox(
            height: 14.w,
          ),
        ],
      ),
    );
  }

}
