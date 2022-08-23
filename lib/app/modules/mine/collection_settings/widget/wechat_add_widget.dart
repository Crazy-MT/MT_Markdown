import 'package:code_zero/app/modules/mine/collection_settings/collection_settings_controller.dart';
import 'package:code_zero/common/colors.dart';
import 'package:code_zero/common/components/common_input.dart';
import 'package:code_zero/common/components/safe_tap_widget.dart';
import 'package:code_zero/generated/assets/flutter_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class WechatAddWidget extends StatelessWidget {
  const WechatAddWidget({Key? key}) : super(key: key);

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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInputItem('请输入微信收款账号'),
          _buildInputItem('短信验证码'),
          _buildInputItem('请输入微信收款姓名'),
          _addQrcodeWidget(),
          Expanded(child: SizedBox()),
          _addButtonWidget(),
          SizedBox(height: MediaQuery.of(context).padding.bottom + 20.w),
        ],
      ),
    );
  }

  Widget _buildInputItem(String title) {
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
                      '18910495667',
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
      suffixWidget: title == '短信验证码'
          ? SizedBox(
              width: 87.w,
              height: 30.w,
              child: ElevatedButton(
                onPressed: controller.sendSmsCountdown.value <= 0 ? () {} : null,
                style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                ).copyWith(
                  padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                  elevation: MaterialStateProperty.all(0),
                  backgroundColor: MaterialStateProperty.all(
                    AppColors.green.withOpacity(controller.sendSmsCountdown.value <= 0 ? 1 : 0.5),
                  ),
                ),
                child: Text(
                  controller.sendSmsCountdown.value <= 0 ? "获取验证码" : "${controller.sendSmsCountdown.value}s",
                  style: TextStyle(
                    color: Colors.white.withOpacity(controller.sendSmsCountdown.value <= 0 ? 1 : 0.5),
                    fontSize: 12.sp,
                  ),
                ),
              ),
            )
          : SizedBox(),
    );
  }

  Widget _addQrcodeWidget() {
    return Container(
      padding: EdgeInsets.only(left: 17.w, top: 15.w),
      child: Column(
        children: [
          Text(
            '添加微信收款二维码',
            style: TextStyle(
              color: Color(0xff121212),
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 7.w),
          SafeTapWidget(
            onTap: () {},
            child: Stack(
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
                      '上传微信收款码',
                      style: TextStyle(
                        color: AppColors.text_dark.withOpacity(0.3),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _addButtonWidget() {
    return SafeTapWidget(
      onTap: () {
        Get.find<CollectionSettingsController>().bankCardDidAdd.value = true;
      },
      child: Container(
        width: double.infinity,
        height: 44.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.green,
          borderRadius: BorderRadius.circular(22.w),
        ),
        child: Text(
          '确认添加',
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
