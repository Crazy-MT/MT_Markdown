import 'package:cached_network_image/cached_network_image.dart';
import 'package:code_zero/app/modules/mine/collection_settings/collection_settings_controller.dart';
import 'package:code_zero/common/colors.dart';
import 'package:code_zero/common/components/common_input.dart';
import 'package:code_zero/common/components/safe_tap_widget.dart';
import 'package:code_zero/common/user_helper.dart';
import 'package:code_zero/generated/assets/flutter_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class AlipayAddWidget extends StatelessWidget {
  const AlipayAddWidget({Key? key}) : super(key: key);

  //------ pragma mark - properties ------//

  //------ pragma mark - lifecycle ------//

  @override
  Widget build(BuildContext context) {
    return _contentWidget(context);
  }

  //------ pragma mark - event responses (require: start with '_on') ------//

  //------ pragma mark - private methods (require: start with '_') ------//

  //------ pragma mark - widget (require: start with '_', end with 'Widget') ------//

  Widget _contentWidget(BuildContext context) {
    CollectionSettingsController controller = Get.find<CollectionSettingsController>();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Obx(
        (() => SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInputItem('请输入支付宝收款账号', controller.aliPayAccountController),
                  _buildInputItem('短信验证码', controller.aliPayCodeController),
                  _buildInputItem('请输入支付宝收款姓名', controller.aliPayNameController),
                  _addQrcodeWidget(),
                  SizedBox(height: 80.w),
                  _addButtonWidget(),
                  SizedBox(height: MediaQuery.of(context).padding.bottom + 20.w),
                ],
              ),
            )),
      ),
    );
  }

  Widget _buildInputItem(String title, TextEditingController editingController) {
    CollectionSettingsController controller = Get.find<CollectionSettingsController>();
    return buildInputWithTitle(
      Container(
        padding: EdgeInsets.only(left: 17.w, top: 15.w),
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(
                color: Color(0xff121212),
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            title == '短信验证码'
                ? Container(
                    alignment: Alignment.center,
                    height: 20.w,
                    margin: EdgeInsets.only(left: 7.5.w),
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    decoration: BoxDecoration(
                      color: Color(0xffBAEED8),
                      borderRadius: BorderRadius.circular(10.w),
                    ),
                    child: Text(
                      userHelper.userInfo.value?.phone ?? '',
                      style: TextStyle(
                        color: Color(0xff757575),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
      inputController: editingController,
      suffixWidget: title == '短信验证码'
          ? SizedBox(
              width: 87.w,
              height: 30.w,
              child: ElevatedButton(
                onPressed: controller.sendAliPayCodeCountDown.value <= 0
                    ? () {
                        controller.startAlipayCountDown();
                        controller.getSMS(false, isAlipay: true);
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                ).copyWith(
                  padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                  elevation: MaterialStateProperty.all(0),
                  backgroundColor: MaterialStateProperty.all(
                    AppColors.green.withOpacity(controller.sendAliPayCodeCountDown.value <= 0 ? 1 : 0.5),
                  ),
                ),
                child: Text(
                  controller.sendAliPayCodeCountDown.value <= 0 ? "获取验证码" : "${controller.sendAliPayCodeCountDown.value}s",
                  style: TextStyle(
                    color: Colors.white.withOpacity(controller.sendAliPayCodeCountDown.value <= 0 ? 1 : 0.5),
                    fontSize: 12.sp,
                  ),
                ),
              ),
            )
          : SizedBox(),
    );
  }

  Widget _addQrcodeWidget() {
    CollectionSettingsController controller = Get.find<CollectionSettingsController>();
    return Container(
      padding: EdgeInsets.only(left: 17.w, top: 15.w),
      child: Column(
        children: [
          Text(
            '点击编辑支付宝收款二维码',
            style: TextStyle(
              color: Color(0xff121212),
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 7.w),
          SafeTapWidget(
            onTap: () {
              Get.find<CollectionSettingsController>().chooseAndUploadImage(false);
            },
            child: Obx(
              (() => controller.aliPayQrImg.value.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: controller.aliPayQrImg.value,
                      width: 135.w,
                      height: 200.w,
                    )
                  : Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 135.w,
                          height: 200.w,
                          decoration: BoxDecoration(
                            color: Color(0xffF3F9FB),
                            borderRadius: BorderRadius.circular(10.w),
                          ),
                        ),
                        Column(
                          children: [
                            Image.asset(
                              Assets.imagesWalletCollectionAddIcon,
                              width: 40.w,
                              height: 40.w,
                            ),
                            SizedBox(height: 14.w),
                            Text(
                              '上传支付宝收款码',
                              style: TextStyle(
                                color: AppColors.text_dark.withOpacity(0.3),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        )
                      ],
                    )),
            ),
          ),
        ],
      ),
    );
  }

  Widget _addButtonWidget() {
    CollectionSettingsController controller = Get.find<CollectionSettingsController>();
    bool enable = controller.aliPayAccountController.text.isNotEmpty &&
        controller.aliPayCodeController.text.isNotEmpty &&
        controller.aliPayNameController.text.isNotEmpty &&
        controller.aliPayQrImg.value.isNotEmpty;
    return SafeTapWidget(
      onTap: () {
        if (controller.hasNoAliPay) {
          controller.addUserAlipay();
        } else {
          controller.editAlipayCard(controller.aliPayInfo.value?.id);
        }
      },
      child: Container(
        width: double.infinity,
        height: 44.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: enable ? AppColors.green : Color(0xffBAEED8),
          borderRadius: BorderRadius.circular(22.w),
        ),
        child: Text(
          controller.hasNoAliPay ? "确认添加" : "确认修改",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
