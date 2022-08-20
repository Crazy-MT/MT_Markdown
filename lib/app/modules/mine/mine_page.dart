import 'package:cached_network_image/cached_network_image.dart';
import 'package:code_zero/app/routes/app_routes.dart';
import 'package:code_zero/common/components/safe_tap_widget.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:code_zero/common/user_helper.dart';
import 'package:code_zero/generated/assets/flutter_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/S.dart';
import '../../../common/colors.dart';
import '../../../common/components/avoid_quick_click.dart';
import '../../../utils/log_utils.dart';
import 'mine_controller.dart';
import 'package:url_launcher/url_launcher.dart';
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
                  height: 158.w,
                  fit: BoxFit.cover,
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                          padding: EdgeInsets.only(top: 20.w),
                          // color:  Colors.redAccent,
                          alignment: Alignment.center,
                          height: 138.w,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Obx(
                                () => Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 20.w, top: 8.w),
                                        width: 60.w,
                                        height: 68.w,
                                        // color: Colors.red,
                                        child: Stack(
                                          children: [
                                            Container(
                                              // height: 60.w,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10.w),
                                                ),
                                                child: CachedNetworkImage(
                                                  imageUrl: userHelper.userInfo
                                                          .value?.avatarUrl ??
                                                      "",
                                                  width: 60.w,
                                                  // height: 90.w,
                                                  errorWidget: (_, __, ___) {
                                                    return Image.asset(Assets
                                                        .iconsAvatarPlaceholder);
                                                  },
                                                  placeholder: (_, __) {
                                                    return Image.asset(Assets
                                                        .iconsAvatarPlaceholder);
                                                  },
                                                ),
                                              ),
                                            ),
                                            (userHelper.isLogin.value &&
                                                    userHelper.userInfo.value !=
                                                        null &&
                                                    userHelper.userInfo.value!
                                                        .captain())
                                                ? Positioned(
                                                    bottom: 0,
                                                    child: Image.asset(
                                                      Assets.iconsCaptain,
                                                      width: 30.w,
                                                    ))
                                                : SizedBox.shrink(),
                                          ],
                                          alignment:
                                              AlignmentDirectional.topCenter,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 10.w,
                                            top: 10.w,
                                            bottom: 10.w),
                                        child: !userHelper.isLogin.value
                                            ? TextButton(
                                                onPressed: () {
                                                  Get.toNamed(
                                                      RoutesID.LOGIN_PAGE);
                                                },
                                                child: Text(
                                                  "登录/注册",
                                                  style: TextStyle(
                                                    color: AppColors.text_dark,
                                                    fontSize: 18.sp,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ))
                                            : Container(
                                                child: Text(
                                                  userHelper.userInfo.value
                                                          ?.nickname ??
                                                      "传翠",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 20.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color.fromRGBO(
                                                        68, 68, 68, 1),
                                                  ),
                                                ),
                                              ),
                                      ),
                                      (userHelper.isLogin.value &&
                                              userHelper.userInfo.value !=
                                                  null &&
                                              userHelper.userInfo.value!
                                                  .member())
                                          ? Image.asset(
                                              Assets.iconsMember,
                                              width: 37.w,
                                            )
                                          : SizedBox.shrink(),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                  right: 22.w,
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
                                          width: 20.w,
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
                                          width: 20.w,
                                        ),
                                      ),
                                    ],
                                  ))
                            ],
                          )),
                      Container(
                        height: 87.w,
                        width: 345.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.w),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: buildItem("待付款", Assets.iconsMineDaifukuan,
                                  () {
                                Get.toNamed(RoutesID.ORDER_PAGE, arguments: {
                                  "index": 1,
                                });
                              }),
                            ),
                            Expanded(
                              child: buildItem("待发货", Assets.iconsMineDaifahuo,
                                  () {
                                Get.toNamed(RoutesID.ORDER_PAGE, arguments: {
                                  "index": 2,
                                });
                              }),
                            ),
                            Expanded(
                              child: buildItem(
                                  "待收货", Assets.iconsMineDaishouhuo, () {
                                Get.toNamed(RoutesID.ORDER_PAGE, arguments: {
                                  "index": 3,
                                });
                              }),
                            ),
                            Expanded(
                              child: buildItem(
                                  "我的订单", Assets.iconsMineWodedingdan, () {
                                Get.toNamed(RoutesID.ORDER_PAGE, arguments: {
                                  "index": 0,
                                });
                              }),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.w,
                      ),
                      Container(
                        width: 345.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.w),
                        ),
                        child: Column(
                          children: [
                            Container(
                                width: 345.w,
                                height: 32.w,
                                padding: EdgeInsets.only(left: 10.w, top: 10.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10.w),
                                      topRight: Radius.circular(10.w)),
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
                              height: 84.w,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: buildItem("我的仓库",
                                        Assets.iconsMineMaiWodecangku, () {}),
                                  ),
                                  Expanded(
                                    child: buildItem("待付款",
                                        Assets.iconsMineMaiDaifukuan, () {}),
                                  ),
                                  Expanded(
                                    child: buildItem("已付款",
                                        Assets.iconsMineMaiYifukuan, () {}),
                                  ),
                                  Expanded(
                                    child: buildItem("待上架",
                                        Assets.iconsMineMaiDaishangjia, () {}),
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
                        width: 345.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.w),
                        ),
                        child: Column(
                          children: [
                            Container(
                                width: 345.w,
                                height: 32.w,
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
                              height: 84.w,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: buildItem(
                                        "我的仓库",
                                        Assets.iconsMineMaiMaiWodecangku,
                                        () {}),
                                  ),
                                  Expanded(
                                    child: buildItem(
                                        "待收款",
                                        Assets.iconsMineMaiMaiDaishoukuan,
                                        () {}),
                                  ),
                                  Expanded(
                                    child: buildItem("待确认",
                                        Assets.iconsMineMaiMaiDaiqueren, () {}),
                                  ),
                                  Expanded(
                                    child: buildItem(
                                        "已完成",
                                        Assets.iconsMineMaiMaiYiwancheng,
                                        () {}),
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
                        width: 345.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.w),
                        ),
                        child: Column(
                          children: [
                            Container(
                                width: 345.w,
                                padding: EdgeInsets.only(left: 10.w, top: 10.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10.w),
                                      topRight: Radius.circular(10.w)),
                                ),
                                child: Text(
                                  "我的服务",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                            Container(
                              height: 130.5.w,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: buildItem(
                                          "我的收益",
                                          Assets.iconsMineWodeshouyi,
                                          () {
                                            Get.toNamed(
                                                RoutesID.INCOME_LIST_PAGE);
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        child: buildItem(
                                            "我的钱包", Assets.iconsMineWodeqianbao,
                                            () {
                                          Get.toNamed(RoutesID.WALLET_PAGE);
                                        }),
                                      ),
                                      Expanded(
                                        child: buildItem(
                                            "邀请好友",
                                            Assets.iconsMineYaoqinghaoyou,
                                            () {}),
                                      ),
                                      Expanded(
                                        child: buildItem(
                                            "收货地址",
                                            Assets.iconsMineShouhuodizhi,
                                            () {}),
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
                                            "收款设置",
                                            Assets.iconsMineShoukuanshezhi,
                                            () {}),
                                      ),
                                      Expanded(
                                        child: buildItem("分销中心",
                                            Assets.iconsMineFenxiaozhongxin,
                                            () {
                                          Get.toNamed(
                                              RoutesID.DISTRIBUTION_PAGE);
                                        }),
                                      ),
                                      Expanded(
                                        child: buildItem("绑定推荐人",
                                            Assets.iconsMineBangdingtuiianren,
                                            () {
                                          Get.toNamed(
                                              RoutesID.BIND_RECOMMEND_PAGE);
                                        }),
                                      ),
                                      Expanded(
                                        child: buildItem(
                                            "客服热线", Assets.iconsMineKefurexian,
                                            () {
                                          showModalBottomSheet(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              context: context,
                                              builder: (context) {
                                                return Container(
                                                  color: Colors.transparent,
                                                  height: 171.w,
                                                  child: Stack(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 10.w,
                                                                left: 10.w),
                                                        child: TextButton(
                                                            child: Text(
                                                              "取消",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            style: ButtonStyle(
                                                              shape: MaterialStateProperty.all<
                                                                      RoundedRectangleBorder>(
                                                                  RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20.w))),
                                                              backgroundColor:
                                                                  MaterialStateProperty.all<
                                                                          Color>(
                                                                      Color(
                                                                          0xFFD8E2EA)),
                                                            )),
                                                      ),
                                                      Container(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text("客服热线", style: TextStyle(
                                                              fontSize: 16.sp,
                                                              color: Color(0xFFABAAB9)
                                                            ),),
                                                            SizedBox(height: 10.w,),
                                                            Text(
                                                                "188-8888-8888", style: TextStyle(
                                                              fontSize: 22.sp
                                                            ),),
                                                            SizedBox(height: 10.w,),
                                                            SizedBox(
                                                              width: 335.w,
                                                              height: 44.w,
                                                              child:
                                                                  ElevatedButton(
                                                                onPressed: () {
                                                                  launchUrl(Uri.parse('tel://18888888888'));
                                                                },
                                                                // style: ButtonStyle(
                                                                //   padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                                                                //   backgroundColor: MaterialStateProperty.all(AppColors.green),
                                                                // ),
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                  // shape: RoundedRectangleBorder(
                                                                  //   borderRadius: BorderRadius.circular(12), // <-- Radius
                                                                  // ),
                                                                  shape:
                                                                      StadiumBorder(),
                                                                ).copyWith(
                                                                  padding: MaterialStateProperty.all(
                                                                      const EdgeInsets.all(
                                                                          0)),
                                                                  backgroundColor:
                                                                      MaterialStateProperty
                                                                          .all(
                                                                    AppColors
                                                                        .green
                                                                        .withOpacity(
                                                                            1),
                                                                  ),
                                                                  elevation:
                                                                      MaterialStateProperty
                                                                          .all(0),
                                                                ),
                                                                child: Text(
                                                                  "拨打电话",
                                                                  style:
                                                                      TextStyle(
                                                                    color: AppColors
                                                                        .text_white
                                                                        .withOpacity(
                                                                            1),
                                                                    fontSize:
                                                                        16.sp,
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        width: double.infinity,
                                                      )
                                                    ],
                                                  ),
                                                );
                                              });
                                        }),
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

  SafeTapWidget buildItem(var title, var icon, var tap) {
    return SafeTapWidget(
      onTap: tap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            icon,
            width: 20.w,
          ),
          SizedBox(
            height: 5.w,
          ),
          Text(
            title,
            style: S.textStyles.grey,
          )
        ],
      ),
    );
  }
}
