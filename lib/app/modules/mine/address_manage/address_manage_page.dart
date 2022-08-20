import 'package:code_zero/app/routes/app_routes.dart';
import 'package:code_zero/common/colors.dart';
import 'package:code_zero/common/components/common_app_bar.dart';
import 'package:code_zero/common/components/safe_tap_widget.dart';
import 'package:code_zero/generated/assets/flutter_assets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'address_manage_controller.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressManagePage extends GetView<AddressManageController> {
  const AddressManagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFffffff),
      appBar: CommonAppBar(
        titleText: "地址管理",
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
        () => Stack(
          children: [
            FTStatusPage(
              type: controller.pageStatus.value,
              errorMsg: controller.errorMsg.value,
              builder: (BuildContext context) {
                return Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).padding.bottom +
                          10.w +
                          44.w +
                          10.w),
                  child: CustomScrollView(
                    slivers: [
                      SliverList(
                        delegate: SliverChildBuilderDelegate((content, index) {
                          return _buildAddressItem(index);
                        }, childCount: controller.addressList.length),
                      ),
                    ],
                  ),
                );
              },
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: MediaQuery.of(context).padding.bottom + 10.w,
              child: _addAddressWidget(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressItem(int index) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          SizedBox(height: 18.w),
          _cityWidget(index),
          SizedBox(height: 5.w),
          _streetWidget(),
          SizedBox(height: 14.w),
          _userInfoWidget(),
          SizedBox(height: 15.w),
          Divider(color: Color(0xffF5F5F5), height: 0.5.w),
        ],
      ),
    );
  }

  Widget _addressDefaultIcon() {
    return Container(
      width: 32.w,
      height: 16.w,
      alignment: Alignment.center,
      margin: EdgeInsets.only(right: 8.w),
      decoration: BoxDecoration(
        color: AppColors.green,
        borderRadius: BorderRadius.circular(8.w),
      ),
      child: Text(
        '默认',
        textAlign: TextAlign.start,
        style: TextStyle(
          color: Colors.white,
          fontSize: 10.sp,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _cityWidget(int index) {
    var item = controller.addressList[index];
    return Row(
      children: [
        item == '默认' ? _addressDefaultIcon() : SizedBox(),
        Expanded(
          child: Text(
            '北京市朝阳区新街口街道',
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Color(0xffABAAB9),
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  Widget _streetWidget() {
    return Row(
      children: [
        Expanded(
          child: Text(
            '北苑路222号某某小区2栋2302',
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Color(0xff111111),
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SafeTapWidget(
          onTap: () {
            Get.toNamed(RoutesID.ADDRESS_EDIT_PAGE, arguments: {'type': 1});
          },
          child: Image.asset(
            Assets.imagesAddressEditIcon,
            width: 20.w,
            height: 20.w,
          ),
        ),
      ],
    );
  }

  Widget _userInfoWidget() {
    return Row(
      children: [
        Text(
          '李旭',
          textAlign: TextAlign.start,
          style: TextStyle(
            color: Color(0xffABAAB9),
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(
          width: 12.w,
        ),
        Text(
          '189****5667',
          textAlign: TextAlign.start,
          style: TextStyle(
            color: Color(0xffABAAB9),
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _addAddressWidget(BuildContext context) {
    return SafeTapWidget(
      onTap: () {
        Get.toNamed(RoutesID.ADDRESS_EDIT_PAGE, arguments: {'type': 0});
      },
      child: Container(
        height: 44.w,
        margin: EdgeInsets.fromLTRB(20.w, 10.w, 20.w, 0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.green,
          borderRadius: BorderRadius.circular(22.w),
        ),
        child: Text(
          '+ 新建收货地址',
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
