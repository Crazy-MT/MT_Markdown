import 'package:cached_network_image/cached_network_image.dart';
import 'package:code_zero/app/modules/snap_up/snap_detail/model/commodity.dart';
import 'package:code_zero/app/modules/snap_up/snap_up_controller.dart';
import 'package:code_zero/common/system_setting.dart';
import 'package:code_zero/generated/assets/assets.dart';
import 'package:code_zero/utils/log_utils.dart';
import 'package:code_zero/utils/utils.dart';

import '../../../../common/components/safe_tap_widget.dart';
import '../../../routes/app_routes.dart';
import 'model/commodity.dart';
import 'snap_detail_controller.dart';
import 'package:code_zero/common/colors.dart';
import 'package:code_zero/common/components/common_app_bar.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SnapDetailPage extends GetView<SnapDetailController> {
  const SnapDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: CommonAppBar(
        titleText: Get.arguments["title"],
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Color(0xFF14181F),
          onPressed: () {
            systemSetting.initSystemSetting();

            Get.find<SnapUpController>().getSnapUpList(isRefresh: false);

            Get.back();
          },
        ),
      ),
      body: Obx(
        () => FTStatusPage(
          type: controller.pageStatus.value,
          errorMsg: controller.errorMsg.value,
          enablePullDown: true,
          enablePullUp: true,
          controller: controller.refreshController,
          onLoading: () {
            controller.getRecommendList(isRefresh: false);
          },
          onRefresh: () {
            controller.getRecommendList(isRefresh: true);
          },
          builder: (BuildContext context) {
            return CustomScrollView(
              slivers: [_buildRecommendGrid()],
            );
          },
        ),
      ),
    );
  }

  _buildRecommendGrid() {
    return Obx(() {
      return SliverPadding(
        padding: EdgeInsets.all(12.w).copyWith(top: 0),
        sliver: SliverGrid(
            delegate: SliverChildBuilderDelegate((context, index) {
              return _buildRecommendItem(index);
            }, childCount: controller.commodityList.length),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 165 / 280,
              crossAxisSpacing: 15.w,
              mainAxisSpacing: 17.w,
            )),
      );
    });
  }

  _buildRecommendItem(index) {
    CommodityItem item = controller.commodityList[index];
    return SafeTapWidget(
      onTap: () async {
        if(item.status == 4) {
          Utils.showToastMsg('已被售罄');
          return;
        }
        controller.currentIndex = index;
        await Get.toNamed(RoutesID.GOODS_DETAIL_PAGE, arguments: {
          "from": RoutesID.SNAP_DETAIL_PAGE,
          "good": item,
          "startTime": Get.arguments['startTime'],
          "endTime": Get.arguments['endTime'],
        })?.then((value)  {
          controller.getIndexList();
        });
      },
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.w),
                  child: CachedNetworkImage(
                    imageUrl: item.thumbnails?.firstWhere((element) => element.isNotEmpty, orElse: () => "") ?? '',
                    width: 165.w,
                    height: 210.w,
                    fit: BoxFit.cover,
                      placeholder: (_, __) {
                        return Image.asset(Assets.imagesHolderImg);
                      },
                      errorWidget: (_,__, ___) {
                        return Image.asset(Assets.imagesHolderImg);
                      },
                  ),
                ),
                item.status == 4 ? Positioned(right: 0,child: Image.asset(Assets.imagesHasNoGood, width: 50.w, height: 50.w,)) : SizedBox()
              ],
            ),
            SizedBox(
              height: 10.w,
            ),
            Text(
              item.name ?? "",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.text_dark,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 5.w,
            ),
            Text(
              "￥${item.currentPrice}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12.sp,
                color: Color(0xFFD0A06D),
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
