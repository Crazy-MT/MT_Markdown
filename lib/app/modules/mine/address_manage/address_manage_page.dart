import 'package:code_zero/app/routes/app_routes.dart';
import 'package:code_zero/common/colors.dart';
import 'package:code_zero/common/components/common_app_bar.dart';
import 'package:code_zero/common/components/safe_tap_widget.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:code_zero/generated/assets/flutter_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'address_manage_controller.dart';

class AddressManagePage extends GetView<AddressManageController> {
  const AddressManagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFffffff),
      appBar: CommonAppBar(
        titleText: Get.arguments == null ? "地址管理" : (Get.arguments['title'] ?? '地址管理'),
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
                return CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + 10.w + 44.w + 10.w),
                      sliver: Obx(
                        () => SliverList(
                          delegate: SliverChildBuilderDelegate((content, index) {
                            return _buildAddressItem(index);
                          }, childCount: controller.addressList.length),
                        ),
                      ),
                    ),
                  ],
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
    return SafeTapWidget(
      onTap: () {
        if(Get.arguments != null && (Get.arguments['title'] != null && Get.arguments['title'] == '选择地址')) {
          Get.back(result: controller.addressList[index]);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 18.w),
            _cityWidget(index),
            SizedBox(height: 5.w),
            _streetWidget(index),
            SizedBox(height: 14.w),
            _userInfoWidget(index),
            SizedBox(height: 15.w),
            Divider(color: Color(0xffF5F5F5), height: 0.5.w),
          ],
        ),
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
        item.isDefault == 1 ? _addressDefaultIcon() : SizedBox(),
        Expanded(
          child: Text(
            item.region ?? "",
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

  Widget _streetWidget(int index) {
    var item = controller.addressList[index];
    return Row(
      children: [
        Expanded(
          child: Text(
            item.address ?? "",
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
            Get.toNamed(RoutesID.ADDRESS_EDIT_PAGE, arguments: {
              'type': 1,
              'item': controller.addressList[index],
            })?.then((value) {
              if (value == true) {
                controller.getAddressList();
              }
            });
            ;
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

  Widget _userInfoWidget(int index) {
    var item = controller.addressList[index];
    return Row(
      children: [
        Text(
          item.consignee ?? "",
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
          item.phone ?? "",
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
        Get.toNamed(RoutesID.ADDRESS_EDIT_PAGE, arguments: {'type': 0, 'noAddress': controller.addressList.length == 0, 'from': Get.arguments?['from']})?.then((value) {
          if (value == true) {
            controller.getAddressList();
          }
        });
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
