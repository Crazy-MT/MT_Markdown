import 'package:code_zero/app/modules/mine/collection_settings/collection_settings_page.dart';
import 'package:code_zero/app/routes/app_routes.dart';
import 'package:code_zero/common/colors.dart';
import 'package:code_zero/common/components/common_app_bar.dart';
import 'package:code_zero/common/components/common_input.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'drawing_controller.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawingPage extends GetView<DrawingController> {
  const DrawingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: CommonAppBar(
        titleText: "余额提现",
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
            return Column(
              children: [
                _titleWidget(),
                _contentWrapperWidget(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _titleWidget() {
    return Container(
      height: 48.w,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '提取类型',
            style: TextStyle(
              color: Color(0xff111111),
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed(RoutesID.COLLECTION_SETTINGS_PAGE);
            },
            child: Row(
              children: [
                Text(
                  '设置收款信息',
                  style: TextStyle(
                    color: Color(0xff111111),
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(width: 4.w),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xFFABAAB9),
                  size: 10.w,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _contentWrapperWidget() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.w), topRight: Radius.circular(20.w)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(25.w, 20.w, 25.w, 37.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '提取金额',
                    style: TextStyle(
                      color: Color(0xff111111),
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 14.w),
                  Row(
                    children: [
                      Text(
                        '￥',
                        style: TextStyle(
                          color: Color(0xff111111),
                          fontSize: 26,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Expanded(
                        child: CommonInput(
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          style: TextStyle(
                            color: Color(0xff111111),
                            fontSize: 26,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.w),
                  Divider(height: 1.w, color: Color(0xffF5F4F9)),
                  SizedBox(height: 10.w),
                  Row(
                    children: [
                      Text(
                        '可提现金额：',
                        style: TextStyle(
                          color: Color(0xff434446),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        '453256.88',
                        style: TextStyle(
                          color: Color(0xff434446),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            GestureDetector(
              child: Container(
                alignment: Alignment.center,
                height: 44.w,
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                  color: AppColors.green,
                  borderRadius: BorderRadius.circular(22.w),
                ),
                child: Text(
                  '提现至银行卡',
                  style: TextStyle(
                    color: Color(0xffffffff),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
