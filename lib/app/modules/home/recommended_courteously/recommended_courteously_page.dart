import 'package:code_zero/app/routes/app_routes.dart';
import 'package:code_zero/common/colors.dart';
import 'package:code_zero/common/components/common_app_bar.dart';
import 'package:code_zero/common/components/safe_tap_widget.dart';
import 'package:code_zero/common/system_setting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'recommended_courteously_controller.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecommendedCourteouslyPage
    extends GetView<RecommendedCourteouslyController> {
  const RecommendedCourteouslyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg_gray,
      appBar: CommonAppBar(
        titleText: "推荐有礼",
        centerTitle: true,
      ),
      body: Obx(
            () =>
            FTStatusPage(
              type: controller.pageStatus.value,
              errorMsg: controller.errorMsg.value,
              builder: (BuildContext context) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset('assets/images/rcourte_bg.png'),
                          Positioned(
                              top: 50.w,
                              child: Image.asset(
                                'assets/images/rcourte_9.png',
                                width: 300.w,
                              )),
                          Positioned(
                            child: Image.asset(
                              'assets/images/rcourte_1.png',
                              width: 345.w,
                            ),
                            bottom: 0,
                          ),
                          Container(
                            width: 325.w,
                            // height: 300.w,
                            // color: Colors.black,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/rcourte_10.png',
                                ),
                                Positioned(
                                  top: 200.w,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: [
                                          Image.asset(
                                            'assets/images/rcourte_2.png',
                                            width: 80.w,
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                                top: 4.w,
                                                bottom: 4.w,
                                                left: 14.w,
                                                right: 14.w),
                                            decoration: new BoxDecoration(
                                              color: Color(0xffE9504B),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(25.0)),
                                              border: new Border.all(
                                                  width: 1,
                                                  color: Color(0xffFCB7A5)),
                                            ),
                                            child: Obx(() {
                                              return RichText(
                                                text: TextSpan(
                                                    text: '奖励',
                                                    style: TextStyle(
                                                        fontSize: 12.sp,
                                                        color: Colors.white),
                                                    children: [
                                                      TextSpan(
                                                          text: systemSetting
                                                              .model.value
                                                              ?.fromUserReward ??
                                                              ""),
                                                      TextSpan(text: '元红包')
                                                    ]),
                                              );
                                            }),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 22.w,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: [
                                          Image.asset(
                                            'assets/images/rcourte_3.png',
                                            width: 80.w,
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                                top: 4.w,
                                                bottom: 4.w,
                                                left: 14.w,
                                                right: 14.w),
                                            decoration: new BoxDecoration(
                                              color: Color(0xffE9504B),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(25.0)),
                                              border: new Border.all(
                                                  width: 1,
                                                  color: Color(0xffFCB7A5)),
                                            ),
                                            child: Obx(() {
                                              return RichText(
                                                text: TextSpan(
                                                    text: '奖励',
                                                    style: TextStyle(
                                                        fontSize: 12.sp,
                                                        color: Colors.white),
                                                    children: [
                                                      TextSpan(
                                                          text: systemSetting
                                                              .model.value
                                                              ?.toUserReward ??
                                                              ""),
                                                      TextSpan(text: '元红包')
                                                    ]),
                                              );
                                            }),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 10.w,),
                                      SafeTapWidget(
                                        onTap: () {
                                          Get.toNamed(RoutesID.INVITE_PAGE);
                                        },
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/images/rcourte_4.png',
                                              width: 228.w,),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      Container(
                        height: 100.w,
                        width: double.infinity,
                        color: Color(0xffe53021),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SafeTapWidget(
                              onTap: () {
                                Get.toNamed(RoutesID.INVITE_PAGE);
                              },
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/rcourte_8.png',
                                    width: 167.5.w,
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/rcourte_7.png',
                                        width: 20.w,
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Text(
                                        '面对面推荐',
                                        style: TextStyle(
                                            color: Color(0xff434446),
                                            fontSize: 14.sp),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SafeTapWidget(
                              onTap: () {
                                Get.toNamed(RoutesID.INVITE_PAGE,
                                    arguments: {'shareWechatSession': true});
                              },
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/rcourte_8.png',
                                    width: 167.5.w,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Image.asset(
                                        'assets/images/rcourte_6.png',
                                        width: 20.w,
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Text(
                                        '转发推荐',
                                        style: TextStyle(
                                            color: Color(0xff434446),
                                            fontSize: 14.sp),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
      ),
    );
  }
}
