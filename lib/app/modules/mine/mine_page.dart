import 'package:code_zero/app/routes/app_routes.dart';
import 'package:code_zero/common/components/safe_tap_widget.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:code_zero/common/user_helper.dart';
import 'package:code_zero/generated/assets/flutter_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/colors.dart';
import '../../../common/components/avoid_quick_click.dart';
import 'mine_controller.dart';

class MinePage extends GetView<MineController> {
  const MinePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg_gray,
      body: Obx(
        () => FTStatusPage(
          type: controller.pageStatus.value,
          errorMsg: controller.errorMsg.value,
          builder: (BuildContext context) {
            return Stack(
              children: [
                Image.asset(
                  Assets.iconsMineTop,
                  height: 200.w,
                  fit: BoxFit.cover,
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                          // color:  Colors.redAccent,
                          alignment: Alignment.center,
                          height: 180.w,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 20.w),
                                      width: 80.w,
                                      height: 80.w,
                                      child: SafeClickGesture(
                                        onTap: () {},
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10.w),
                                          ),
                                          child:
                                              Image.asset(Assets.iconsMineUser),
                                        ),
                                      ),
                                    ),
                                    Obx(
                                      () => Container(
                                        margin: EdgeInsets.only(
                                            left: 10.w,
                                            top: 10.w,
                                            bottom: 10.w),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            !userHelper.isLogin.value
                                                ? TextButton(
                                                    onPressed: () {
                                                      Get.toNamed(
                                                          RoutesID.LOGIN_PAGE);
                                                    },
                                                    child: Text(
                                                      "登录/注册",
                                                      style: TextStyle(
                                                        color:
                                                            AppColors.text_dark,
                                                        fontSize: 18.sp,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ))
                                                : Container(
                                                    child: Text(
                                                      "传翠",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: 20.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromRGBO(
                                                            68, 68, 68, 1),
                                                      ),
                                                    ),
                                                  )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                  right: 10.w,
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          // 跳转消息页
                                          Get.toNamed(RoutesID.MESSAGE_PAGE);
                                        },
                                        child: Image.asset(
                                          Assets.iconsMineMessage,
                                          fit: BoxFit.cover,
                                          width: 30.w,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20.w,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          // 跳转设置页
                                          Get.toNamed(RoutesID.SETTING_PAGE);
                                        },
                                        child: Image.asset(
                                          Assets.iconsMineSetting,
                                          fit: BoxFit.cover,
                                          width: 30.w,
                                        ),
                                      ),
                                    ],
                                  ))
                            ],
                          )),
                      Container(
                        height: 100.w,
                        width: 340.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.w),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: buildItem("待付款", Assets.iconsMineMessage),
                            ),
                            Expanded(
                              child: buildItem("待发货", Assets.iconsMineMessage),
                            ),
                            Expanded(
                              child: buildItem("待收货", Assets.iconsMineMessage),
                            ),
                            Expanded(
                              child: buildItem("我的订单", Assets.iconsMineMessage),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.w,
                      ),
                      Container(
                        width: 340.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.w),
                        ),
                        child: Column(
                          children: [
                            Container(
                                width: 340.w,
                                padding: EdgeInsets.only(left: 10.w, top: 10.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.w),
                                      topRight: Radius.circular(20.w)),
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color(0x801BDB8A),
                                      Color(0x001BDB8A)
                                    ],
                                  ),
                                ),
                                child: Text(
                                  "买方",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                            Container(
                              height: 100.w,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: buildItem(
                                        "我的仓库", Assets.iconsMineMessage),
                                  ),
                                  Expanded(
                                    child: buildItem(
                                        "待付款", Assets.iconsMineMessage),
                                  ),
                                  Expanded(
                                    child: buildItem(
                                        "已付款", Assets.iconsMineMessage),
                                  ),
                                  Expanded(
                                    child: buildItem(
                                        "待上架", Assets.iconsMineMessage),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.w,
                      ),
                      Container(
                        width: 340.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.w),
                        ),
                        child: Column(
                          children: [
                            Container(
                                width: 340.w,
                                padding: EdgeInsets.only(left: 10.w, top: 10.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10.w),
                                      topRight: Radius.circular(10.w)),
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color(0x80FFD029),
                                      Color(0x00FFD029)
                                    ],
                                  ),
                                ),
                                child: Text(
                                  "卖方",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                            Container(
                              height: 100.w,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: buildItem(
                                        "我的仓库", Assets.iconsMineMessage),
                                  ),
                                  Expanded(
                                    child: buildItem(
                                        "待收款", Assets.iconsMineMessage),
                                  ),
                                  Expanded(
                                    child: buildItem(
                                        "待确认", Assets.iconsMineMessage),
                                  ),
                                  Expanded(
                                    child: buildItem(
                                        "已完成", Assets.iconsMineMessage),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.w,
                      ),
                      Container(
                        width: 340.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.w),
                        ),
                        child: Column(
                          children: [
                            Container(
                                width: 340.w,
                                padding: EdgeInsets.only(left: 10.w, top: 10.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.w),
                                      topRight: Radius.circular(20.w)),
                                ),
                                child: Text(
                                  "我的服务",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                            Container(
                              height: 150.w,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: SafeTapWidget(
                                          onTap: () {
                                            Get.toNamed(
                                                RoutesID.INCOME_LIST_PAGE);
                                          },
                                          child: buildItem(
                                            "我的收益",
                                            Assets.iconsMineMessage,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            Get.toNamed(RoutesID.WALLET_PAGE);
                                          },
                                          child: buildItem(
                                              "我的钱包", Assets.iconsMineMessage),
                                        ),
                                      ),
                                      Expanded(
                                        child: buildItem(
                                            "邀请好友", Assets.iconsMineMessage),
                                      ),
                                      Expanded(
                                        child: buildItem(
                                            "收货地址", Assets.iconsMineMessage),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20.w,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: buildItem(
                                            "收款设置", Assets.iconsMineMessage),
                                      ),
                                      Expanded(
                                        child: buildItem(
                                            "分销中心", Assets.iconsMineMessage),
                                      ),
                                      Expanded(
                                        child: buildItem(
                                            "绑定推荐人", Assets.iconsMineMessage),
                                      ),
                                      Expanded(
                                        child: buildItem(
                                            "客服热线", Assets.iconsMineMessage),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.w,
                      ),
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Column buildItem(var title, var icon) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          icon,
          width: 20.w,
        ),
        Text(title)
      ],
    );
  }
}
