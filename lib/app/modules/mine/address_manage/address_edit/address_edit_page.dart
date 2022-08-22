import 'package:code_zero/common/colors.dart';
import 'package:code_zero/common/components/common_app_bar.dart';
import 'package:code_zero/common/components/common_input.dart';
import 'package:code_zero/common/components/safe_tap_widget.dart';
import 'package:code_zero/generated/assets/flutter_assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'address_edit_controller.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressEditPage extends GetView<AddressEditController> {
  const AddressEditPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFffffff),
      resizeToAvoidBottomInset: false,
      appBar: CommonAppBar(
        titleText: controller.type == AddressType.add ? "新建收货地址" : "编辑地址管理",
        centerTitle: true,
        actions: [
          _deleteItem(),
        ],
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
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: _buildContent(),
            );
          },
        ),
      ),
    );
  }

  Widget _deleteItem() {
    return Visibility(
      visible: controller.type == AddressType.edit,
      child: SafeTapWidget(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.only(right: 20.w),
          alignment: Alignment.center,
          child: Text(
            '删除',
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Color(0xff111111),
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    List<Widget> widgets = [];
    for (var item in controller.menuList) {
      widgets.add(
        Column(
          children: [
            Container(
              height: 50.w,
              child: Row(
                children: [
                  Container(
                    width: 86.w,
                    child: Text(
                      item.title,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Color(0xff111111),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: CommonInput(
                            hintText: item.hintTitle,
                            hintStyle: TextStyle(
                              color: Color(0xffABAAB9),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        item.showLocation
                            ? Row(
                                children: [
                                  Image.asset(Assets.imagesAddressLocationIcon, width: 16.w, height: 16.w),
                                  SizedBox(width: 8.w),
                                  Text(
                                    '定位',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: Color(0xff111111),
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                ],
                              )
                            : SizedBox(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(color: Color(0xffF5F5F5), height: 0.5.w),
          ],
        ),
      );
    }
    widgets.add(_setDefaultWidget());
    widgets.add(_saveWidget());
    return Column(
      children: widgets,
    );
  }

  Widget _setDefaultWidget() {
    return Column(
      children: [
        SizedBox(
          height: 65.w,
        ),
        Divider(color: Color(0xffF5F5F5), height: 0.5.w),
        Container(
          height: 50.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '设置为默认地址',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Color(0xff111111),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              CupertinoSwitch(
                activeColor: Color(0xffffffff),
                value: false,
                onChanged: (isChecked) {},
              )
            ],
          ),
        ),
        Divider(color: Color(0xffF5F5F5), height: 0.5.w),
      ],
    );
  }

  Widget _saveWidget() {
    return SafeTapWidget(
      onTap: () {},
      child: Container(
        height: 44.w,
        margin: EdgeInsets.fromLTRB(20.w, 30.w, 20.w, 0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.green,
          borderRadius: BorderRadius.circular(22.w),
        ),
        child: Text(
          '保存地址',
          textAlign: TextAlign.start,
          style: TextStyle(
            color: Color(0xffffffff),
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
