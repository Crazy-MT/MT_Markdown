import 'package:cached_network_image/cached_network_image.dart';
import 'package:code_zero/common/colors.dart';
import 'package:code_zero/common/components/common_app_bar.dart';
import 'package:code_zero/common/components/common_input.dart';
import 'package:code_zero/common/components/safe_tap_widget.dart';
import 'package:code_zero/generated/assets/flutter_assets.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/time_picker/model/date_mode.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../utils/log_utils.dart';
import 'user_information_controller.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:date_format/date_format.dart';
class UserInformationPage extends GetView<UserInformationController> {
  const UserInformationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      appBar: CommonAppBar(
        titleText: "编辑资料",
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
                _buildAvatarItem(),
                _buildNameItem(),
                _buildGenderItem(),
                _buildDateItem(),
                SliverToBoxAdapter(child: _buildConfirmButton()),
              ],
            );
          },
        ),
      ),
    );
  }

  _buildAvatarItem() {
    return SliverToBoxAdapter(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              height: 84.w,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 15.w),
              child: Row(
                children: [
                  Text(
                    "头像",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: AppColors.text_dark,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Expanded(
                    child: SizedBox(),
                  ),
                  SafeTapWidget(
                    onTap: () async {
                      controller.chooseAndUploadImage();
                    },
                    child: Obx(() => ClipOval(
                          child: Container(
                            color: Colors.black,
                            child: CachedNetworkImage(
                                imageUrl: controller.avatarImg.value,
                                width: 60.w,
                                height: 60.w,
                                fit: BoxFit.fill,
                                errorWidget: (_, __, ___) {
                                  return Image.asset(
                                      Assets.iconsAvatarPlaceholder);
                                }),
                          ),
                        )),
                  )
                ],
              ),
            ),
            _buildDivider(),
          ],
        ),
      ),
    );
  }

  _buildNameItem() {
    return SliverToBoxAdapter(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              height: 50.w,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 15.w),
              child: Row(
                children: [
                  Text(
                    "用户名",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: AppColors.text_dark,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Expanded(
                      child: CommonInput(
                    controller: controller.nameController,
                    enable: true,
                    fillColor: Colors.transparent,
                    hintStyle: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.text_dark,
                    ),
                    textAlign: TextAlign.end,
                  )),
                ],
              ),
            ),
            _buildDivider(),
          ],
        ),
      ),
    );
  }

  _buildGenderItem() {
    return SliverToBoxAdapter(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              height: 50.w,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 15.w),
              child: Row(
                children: [
                  Text(
                    "性别",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: AppColors.text_dark,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  Obx(() => DropdownButtonHideUnderline(
                        child: DropdownButton(
                          iconSize: 0,
                          value: controller.gender.value,
                          items: [
                            DropdownMenuItem(
                              child: Text('保密'),
                              value: 0,
                            ),
                            DropdownMenuItem(child: Text('男'), value: 1),
                            DropdownMenuItem(child: Text('女'), value: 2),
                          ],
                          onChanged: (value) {
                            controller.gender.value = value as int;
                          },
                        ),
                      )),
                ],
              ),
            ),
            _buildDivider(),
          ],
        ),
      ),
    );
  }

  _buildDateItem() {
    return SliverToBoxAdapter(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              height: 50.w,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 15.w),
              child: Row(
                children: [
                  Text(
                    "生日",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: AppColors.text_dark,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  SafeTapWidget(
                      onTap: () async {
                        Pickers.showDatePicker(Get.context!, onConfirm: (p) {
                          String month = (p.month!) < 10 ? "0"+p.month.toString() : p.month.toString();
                          String day = (p.day!) < 10 ? "0"+p.day.toString() : p.day.toString();
                          controller.birthday.value = "${p.year}-${month}-${day}";
                        });
                      },
                      child: Obx(() {
                        return Text(controller.birthday.value);
                      })),
                ],
              ),
            ),
            _buildDivider(),
          ],
        ),
      ),
    );
  }

  _buildDivider({height = 1.0}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.w),
      height: height,
      color: Color(0xFFF5F5F5),
    );
  }

  _buildConfirmButton() {
    return SafeTapWidget(
      onTap: () {
       controller.updateInfo();
      },
      child: Container(
        margin: EdgeInsets.all(20.w),
        alignment: Alignment.center,
        height: 44.w,
        decoration: BoxDecoration(
          color: AppColors.green,
          borderRadius: BorderRadius.circular(22.w),
        ),
        child: Text(
          '确认修改',
          style: TextStyle(
            color: AppColors.text_white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
