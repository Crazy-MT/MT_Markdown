import 'package:code_zero/common/colors.dart';
import 'package:code_zero/common/components/common_app_bar.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:code_zero/common/extend.dart';
import 'package:code_zero/generated/assets/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'income_list_controller.dart';

class IncomeListPage extends GetView<IncomeListController> {
  const IncomeListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: CommonAppBar(
        titleText: "收益明细",
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
                _buildHeaderContainer(),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Text(
                      "收益明细",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.text_dark,
                      ),
                    ),
                  ),
                ),
                _buildIncomeList(),
              ],
            );
          },
        ),
      ),
    );
  }

  _buildHeaderContainer() {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.all(15.w).copyWith(
          bottom: 20.w,
        ),
        width: 345.w,
        height: 123.w,
        decoration: BoxDecoration(
          color: AppColors.green,
          borderRadius: BorderRadius.circular(10.w),
          image: DecorationImage(
            image: AssetImage(
              Assets.imagesIncomeListTopBg,
            ),
            fit: BoxFit.fill,
          ),
        ),
        padding: EdgeInsets.all(15.w).copyWith(top: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateTime.now().millisecondsSinceEpoch.formatTime("YYYY-MM-dd"),
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 30.w,
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("总收益（元）",
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.text_dark.withOpacity(0.5),
                        )),
                    Container(
                      alignment: Alignment.bottomLeft,
                      height: 32.w,
                      child: RichText(
                        text: TextSpan(
                            style: TextStyle(
                              height: 1,
                            ),
                            children: [
                              TextSpan(
                                text: "453256",
                                style: TextStyle(
                                  fontSize: 26.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.text_dark,
                                ),
                              ),
                              TextSpan(
                                text: ".00",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.text_dark,
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ],
                ),
                Expanded(child: SizedBox()),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("今日收益（元）",
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.text_dark.withOpacity(0.5),
                        )),
                    Container(
                      height: 32.w,
                      alignment: Alignment.bottomRight,
                      child: Text(
                        "56788.05",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.text_dark,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _buildIncomeList() {
    return SliverPadding(
      padding: EdgeInsets.all(15.w).copyWith(top: 10.w),
      sliver: controller.incomeList.isEmpty
          ? SliverToBoxAdapter(
              child: Container(
                width: 335.w,
                height: 80.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.w),
                  color: Colors.white,
                ),
                child: Text(
                  "暂无明细",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.text_dark,
                  ),
                ),
              ),
            )
          : SliverList(
              delegate: SliverChildBuilderDelegate(
                (content, index) {
                  return _buildIncomeItem(index);
                },
                childCount: controller.incomeList.length,
              ),
            ),
    );
  }

  _buildIncomeItem(index) {
    return Container(
      width: 335.w,
      margin: EdgeInsets.only(bottom: 10.w),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.w),
        color: Colors.white,
      ),
      padding: EdgeInsets.all(15.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 50.w,
            height: 50.w,
            margin: EdgeInsets.only(right: 15.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.w),
              color: Color(0xFFDDF3EA),
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 50.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        "以心参玉 A货翡翠吊坠 男女款飘花树叶玉石挂件 附送证书",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Color(0xFF434446),
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      )),
                      SizedBox(
                        width: 12.w,
                      ),
                      Text(
                        "+10000.00",
                        style: TextStyle(
                          color: AppColors.text_dark,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: SizedBox(),
                  ),
                  Text(
                    DateTime.now().millisecondsSinceEpoch.formatTime(
                          "YYYY.MM.dd HH:mm:ss",
                        ),
                    style: TextStyle(
                        color: Color(
                      0xFFABAAB9,
                    )),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}